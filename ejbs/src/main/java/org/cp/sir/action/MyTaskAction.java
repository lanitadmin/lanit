package org.cp.sir.action;


import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.cp.admin.AppSettingsBean;
import org.cp.bpms.PackageBean;
import org.cp.bpms.ProcessDefinitionBean;
import org.cp.bpms.ProcessDefinitionBean.ProcessIdentityEntity;
import org.cp.bpms.WorkListSearch;
import org.cp.common.ObjectGroup;
import org.cp.common.UserTableSettingsBean;
import org.cp.common.setting.TableFieldSetting;
import org.cp.common.setting.TableFieldValueSetting;
import org.cp.common.setting.TableSetting;
import org.cp.common.setting.TableSettingController;
import org.cp.esia.util.SeamContextUtils;
import org.cp.esia.util.StringUtils;
import org.cp.lod.DataScroll;
import org.cp.lodent.RoleEnt;
import org.cp.lodent.User;
import org.cp.lodent.UserDAO;
import org.cp.model.common.Person;
import org.cp.shark.ListWorkItemController;
import org.cp.shark.WorklistBeanLocal;
import org.cp.sir.dao.MyTaskSearchCriteria;
import org.cp.sir.filter.JSONFilterConstructor;
import org.cp.sir.filter.builder.FilterBuilder;
import org.cp.sir.filter.builder.FilterType;
import org.cp.sir.filter.builder.JSONFilterBuilder;
import org.cp.sir.filter.builder.mytask.AppNumItemBuilder;
import org.cp.sir.filter.builder.mytask.CommentItemBuilder;
import org.cp.sir.filter.builder.mytask.CreateDateItemBuilder;
import org.cp.sir.filter.builder.mytask.DeclarantRequisiteItemBuilder;
import org.cp.sir.filter.builder.mytask.DocOnDistributionItemBuilder;
import org.cp.sir.filter.builder.mytask.DocAttrItemBuilder;
import org.cp.sir.filter.builder.mytask.DocPackageItemBuilder;
import org.cp.sir.filter.builder.mytask.ErrorAdapterItemBuilder;
import org.cp.sir.filter.builder.mytask.ExternalSystemItemBuilder;
import org.cp.sir.filter.builder.mytask.MyTaskFilterItemCodes;
import org.cp.sir.filter.builder.mytask.PackNumItemBuilder;
import org.cp.sir.filter.builder.mytask.PlannedFinishDateItemBuilder;
import org.cp.sir.filter.builder.mytask.ServiceNameItemBuilder;
import org.cp.sir.filter.builder.mytask.StartDateItemBuilder;
import org.cp.sir.filter.builder.mytask.TestDocItemBuilder;
import org.cp.sir.filter.converter.FilterValueDeserializer;
import org.cp.sir.filter.converter.FilterValueSerializer;
import org.cp.sir.model.FilterSettings;
import org.cp.sir.model.FilterValue;
import org.cp.sir.model.filter.FilterItem;
import org.cp.sir.model.filter.JSONFilter;
import org.cp.sir.service.MyTaskService;
import org.cp.sir.validator.MyTaskFilterValidator;
import org.cp.sir.validator.MyTaskFilterValidatorFactory;
import org.cp.toolsimpl.EntityToolsBean;
import org.cp.utils.UserUtils;
import org.enhydra.shark.api.client.wfmc.wapi.WMWorkItem;
import org.jboss.seam.Component;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.Begin;
import org.jboss.seam.annotations.Create;
import org.jboss.seam.annotations.In;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;
import org.jboss.seam.faces.FacesMessages;
import org.jboss.seam.international.StatusMessage.Severity;
import org.jboss.seam.log.Log;
import org.jboss.seam.log.Logging;
import org.jboss.seam.security.Identity;

import com.mchange.v2.sql.filter.FilterCallableStatement;


@Name("myTaskAction")
@Scope(ScopeType.CONVERSATION)
public class MyTaskAction implements Serializable {

  public static final String MY_TASK_VIEW = "/member/myTasks.xhtml";
  private static final int ROW_COUNT_PER_PAGE = 25;
  private static final String USE_CASE_FOR_RASPRED_FILTER = "use_case_for_raspred_filter";
  private static final String USE_APPICATION_NUM_FILTER = "use_application_num_filter";
  /**
   * Логгер
   */
  private static Log _log = Logging.getLog(MyTaskAction.class);

  private static final List<String> availableFilterNames = Arrays.asList(new String[]{MyTaskFilterItemCodes.CREATE_DATE,
      MyTaskFilterItemCodes.PACK_NUM, MyTaskFilterItemCodes.SERVICE_NAME, MyTaskFilterItemCodes.START_DATE,
      MyTaskFilterItemCodes.PLANNED_END_DATE, MyTaskFilterItemCodes.DECLARANT_REQUISITE,
      MyTaskFilterItemCodes.EXTERNAL_SYSTEM, MyTaskFilterItemCodes.TEST_DOC, MyTaskFilterItemCodes.COMMENT, 
      MyTaskFilterItemCodes.ERROR_ADAPTER, MyTaskFilterItemCodes.DOC_ATTR});

  /** TODO **/

  @In(create = true)
  Identity identity;

  @In(value = "searchInstanceForAssign", create = true)
  private UserTableSettingsBean searchInstance;
  @In(create = true)
  private AppSettingsBean appSettings;
  @In(create = true)
  PackageBean packageBean;
  @In(create = true)
  ProcessDefinitionBean processdefinitionBean;
  /** \TODO **/

  @In(create = true)
  WorklistBeanLocal worklistBean;



  /**
   * Фильтры
   */
  private JSONFilter jsonFilter;
  private Map<String, FilterItem> filters;
  /**
   * Сохраненные фильтры пользователя
   */
  private List<FilterSettings> myFilters = new ArrayList<FilterSettings>(1);
  /**
   * Выбранные значения фильтра
   */
  private Map<String, FilterValue> filterValues = new HashMap<String, FilterValue>(1);

  private Long selectedFilterSettings;

  /**
   * Мои задачи
   */
  private List<Object[]> tasks = new ArrayList<Object[]>();

  /**
   * Скроллинг
   */
  private DataScroll dataScroll;

  /**
   * Сортировка
   */
  private String orderType;
  private String orderBy;

  /**
   * Настройки для отображения таблицы с моими задачами
   */
  private TableSetting tableSetting;

  /**
   * Доступные для отображения поля таблицы с моими задачами
   */
  private final List<TableFieldSetting> visibleFields = new ArrayList<TableFieldSetting>();

  /**
   * Название колонок в таблице Мои задачи для отображения пользователю
   */
  private final List<String> columnNames = new ArrayList<String>();

  private List<String> visibleIdentityNames = new ArrayList<String>();

  private Map<String, ProcessIdentityEntity> identityEntities = new HashMap<String, ProcessIdentityEntity>();

  /**
   * Флаг, указывающий, что необходимо обновить состав полей для отображения в моих задачах
   */
  private boolean needToUpdateColumns = false;

  private boolean needToUpdateTasksSQL = false;

  private String filterName;

  @Begin(join = true)
  @Create
  public void init() {
    Map<String, Map<String, String>> availableFilterValues  = new HashMap<String, Map<String,String>>();
    availableFilterValues.put(MyTaskFilterItemCodes.EXTERNAL_SYSTEM, getExternalSystemFilterValues());
    setFixedFilters();
    refresh();

  }
  
  private void setFixedFilters() {
    FilterBuilder filterBuilder = new FilterBuilder();
    filterBuilder.addFilter(new CreateDateItemBuilder());
    filterBuilder.addFilter(new StartDateItemBuilder());
    filterBuilder.addFilter(new PlannedFinishDateItemBuilder());
    filterBuilder.addFilter(new TestDocItemBuilder());
    filterBuilder.addFilter(new CommentItemBuilder());
    filterBuilder.addFilter(new ErrorAdapterItemBuilder());
    filterBuilder.addFilter(new DocAttrItemBuilder());
    
    filters = filterBuilder.getFilters();
  }
  
  private void addExtraFilters() {
    MyTaskService myTaskService =
        SeamContextUtils.getComponentByClass(MyTaskService.class, ScopeType.CONVERSATION, true);
    FilterBuilder filterBuilder = new FilterBuilder();
    if (availableFilterNames.contains(MyTaskFilterItemCodes.PACK_NUM) && !filters.containsKey(MyTaskFilterItemCodes.PACK_NUM)) {
      filterBuilder.addFilter(new PackNumItemBuilder());
    }
    if (availableFilterNames.contains(MyTaskFilterItemCodes.SERVICE_NAME)  && !filters.containsKey(MyTaskFilterItemCodes.SERVICE_NAME)) {
      filterBuilder.addFilter(new ServiceNameItemBuilder(myTaskService.getServices()));
    }
    if (availableFilterNames.contains(MyTaskFilterItemCodes.DECLARANT_REQUISITE) && !filters.containsKey(MyTaskFilterItemCodes.DECLARANT_REQUISITE)) {
      filterBuilder.addFilter(new DeclarantRequisiteItemBuilder());
    }
    if (availableFilterNames.contains(MyTaskFilterItemCodes.DOC_PACKAGE) && !filters.containsKey(MyTaskFilterItemCodes.DOC_PACKAGE)) {
      filterBuilder.addFilter(new DocPackageItemBuilder());
    }
    if (availableFilterNames.contains(MyTaskFilterItemCodes.EXTERNAL_SYSTEM) && !filters.containsKey(MyTaskFilterItemCodes.EXTERNAL_SYSTEM)) {
      filterBuilder.addFilter(new ExternalSystemItemBuilder(getExternalSystemFilterValues()));
    }
    if (appSettings.getIntSetting(USE_CASE_FOR_RASPRED_FILTER, 0) == 1) {
      filterBuilder.addFilter(new DocOnDistributionItemBuilder());
    }
    if (appSettings.getIntSetting(USE_APPICATION_NUM_FILTER, 0) == 1) {
        filterBuilder.addFilter(new AppNumItemBuilder());
      }
    filters.putAll(filterBuilder.getFilters());
  }
  
  


  private Map<String, String> getExternalSystemFilterValues() {
    MyTaskService myTaskService =
        SeamContextUtils.getComponentByClass(MyTaskService.class, ScopeType.CONVERSATION, true);
    Map<String, String> filterValues = myTaskService.getExternalSystems();
    filterValues.put("-1", "[не выбрано]");
    filterValues.put("0", "Личные обращения");
    return filterValues;
  }

  private void refresh() {
    MyTaskService myTaskService =
        SeamContextUtils.getComponentByClass(MyTaskService.class, ScopeType.CONVERSATION, true);
    dataScroll = new DataScroll();
    dataScroll.setPageSize(ROW_COUNT_PER_PAGE);
    visibleFields.clear();
    columnNames.clear();
    for (TableFieldValueSetting value : myTaskService.getTableSetting().getVisibleFields()) {
      visibleFields.add(value.getField());
      columnNames.add(value.getField().getName());
    }
    identityEntities.clear();
    identityEntities = myTaskService.getAllProcessIdentityEnities();
    visibleIdentityNames.clear();
    visibleIdentityNames = getVisibleIdentities(visibleFields);
    myFilters = myTaskService.getMyFilters();
    
    addExtraFilters();
    jsonFilter = new JSONFilterConstructor(FilterType.MY_TASKS, filters.values()).create(new JSONFilterBuilder());
  }

  private List<String> getVisibleIdentities(List<TableFieldSetting> visibleFields) {
    List<String> visibleIdentities = new ArrayList<String>();
    if (visibleFields != null && visibleFields.size() > 0) {
      for (TableFieldSetting field : visibleFields) {
        if (field != null && field.getName() != null && field.getName().startsWith(WorkListSearch.IDENTITY_PRE)) {
          visibleIdentities.add(convertProcessIdentityVaribleName(field.getName()));
        }
      }
    }
    return visibleIdentities;
  }

  /**
   * подгружает задачи при обновлении страницы
   */

  public void updateTasks() {
    _log.debug("updateTasks запущен");
    getTasksByPage(1, needToUpdateTasksSQL);
    needToUpdateTasksSQL = false;
    _log.debug("updateTasks завершен");
  }

  private void getTasksByPage(int page, boolean clearCache) {
    _log.debug("getTasks запущен. Page: #0", page);
    try {
      UserTableSettingsBean searchInstance =
          new UserTableSettingsBean(new ArrayList<String>(getVisibleIdentityNames()));
      
      searchInstance.setShowMyTasks(this.searchInstance.getShowMyTasks());
      
      MyTaskService service = SeamContextUtils.getComponentByClass(MyTaskService.class, ScopeType.CONVERSATION, true);
      MyTaskSearchCriteria searchCriteria = new MyTaskSearchCriteria();
      searchCriteria.setUser(getPrincipal());
      searchCriteria.setUseCaseForRaspredFilter(appSettings.getIntSetting(USE_CASE_FOR_RASPRED_FILTER, 0) == 1);
      searchCriteria.setColumnNames(columnNames);
      searchCriteria.setVisibleIdentityNames(visibleIdentityNames);
      searchCriteria.setIdentityEntities(identityEntities);
      searchCriteria.setFilterValues(filterValues);
      searchCriteria.setOrderBy(orderBy);
      searchCriteria.setOrderType(orderType);
      searchCriteria.setShowMyTask(searchInstance.getShowMyTasks() != null && searchInstance.getShowMyTasks());
      Long taskTotalCount = service.getTaskCount(searchCriteria, searchInstance, clearCache);
      getDataScroll().setRecordSize(taskTotalCount);
      getDataScroll().setPage(page);
      if (taskTotalCount > 0) {
        tasks =
            service.getTasks(searchCriteria, searchInstance, getDataScroll().getFirstResult(), getDataScroll()
                .getPageSize(), false);
        
        // определяем индексы полей act, proc_ident.coreStatusSoap
        int indexAct = 0;
        int indexSoap = 0;
        for (int i = 0; i < visibleFields.size(); i++) {
            TableFieldSetting fld = visibleFields.get(i);
            if (fld.getName().equals("act")) {
                indexAct = i;
            }
            if (fld.getName().equals("proc_ident.coreStatusSoap")) {
                indexSoap = i;
            }
        }
        
        // формируем значения
        for (Object[] task : tasks) {
            String s = (String) task[indexAct];
            if (s.contains("Ожидание результата запроса")) {
                task[indexSoap] = "Отправлен";
            } else if (s.contains("Отправка запроса")) {
                task[indexSoap] = "Не отправлен";
            } else if (s.contains("Принять результат электронного запроса")) {
                task[indexSoap] = "Ответ получен";
            }
        }
        
      } else {
        tasks.clear();
      }
    } catch (Exception e) {
      _log.error(e.getMessage(), e);
    }
    _log.debug("getTasks завершен.");
  }

  public String convertProcessIdentityVaribleName(String varibleName) {
    // если параметр начинается с идентификатора, то отбрасываем его.
    if (varibleName.startsWith(WorkListSearch.IDENTITY_PRE))
      varibleName = varibleName.substring(WorkListSearch.IDENTITY_PRE.length() + 1/* плюс точка */);
    return varibleName;
  }

  /**
   * вызывается при событии на пейджинге
   */
  public void refreshNavigation() {
    _log.debug("refreshNavigation запущен");
    getTasksByPage(getDataScroll().getPage(), false);
    _log.debug("refreshNavigation завершен");
  }

  /**
   * Метод заглушка. Вызов осуществляется в пейджинге, ПОСЛЕ ТОГО как отрисовалась таблица, поэтому
   * он не подходит.
   */
  public void initNavigation() {
    // getTasksByPage(1);
  }
  
  public void resetFilters() {
    jsonFilter.setSelectedFilters(null);
    searchInstance.clearInstance();
  }

  /**
   * 
   */
  public void applyFilterValues() {
    _log.debug("applyFilterValues запущен. filterValues: #0", jsonFilter.getSelectedFilters());
    Map<String, FilterValue> filterValues =
        new FilterValueDeserializer().deserialize(filters.values(), jsonFilter.getSelectedFilters());
    for (FilterValue filterValue : filterValues.values()) {
      MyTaskFilterValidator validator = MyTaskFilterValidatorFactory.validator(filterValue);
      if (validator != null && !validator.validate(filterValue)) {
        return;
      }
    }
    this.filterValues = filterValues;
    needToUpdateTasksSQL = true;
    _log.debug("applyFilterValues завершен");
  }

  public void saveFilter() {
    if (StringUtils.isEmpty(filterName)) {
      FacesMessages.instance().add(Severity.WARN, "Название фильтра не задано");
      return;
    }
    Map<String, FilterValue> filterValues =
        new FilterValueDeserializer().deserialize(filters.values(), jsonFilter.getSelectedFilters());
    if (filterValues != null) {
      for (FilterValue filterValue : filterValues.values()) {
        MyTaskFilterValidator validator = MyTaskFilterValidatorFactory.validator(filterValue);
        if (validator != null && !validator.validate(filterValue)) {
          return;
        }
      }
      this.filterValues = filterValues;
    }
    MyTaskService myTaskService =
        SeamContextUtils.getComponentByClass(MyTaskService.class, ScopeType.CONVERSATION, true);
    myTaskService.saveFilterSettings(filterName, jsonFilter.getSelectedFilters());
    myFilters = myTaskService.getMyFilters();
    filterName = null;
  }

  public void selectFilterSettings() {
    if (selectedFilterSettings != null) {
      for (FilterSettings filterSettings : myFilters) {
        if (selectedFilterSettings.equals(filterSettings.getId())) {
          selectFilter(filterSettings.getSettings());
          break;
        }
      }
    }
  }
  
  public void selectFilter(String filterSettings) {
    jsonFilter.setSelectedFilters(filterSettings);
    applyFilterValues();
  }
  
  public void removeSelectedFilter() {
    FilterSettings selectedFilter = null;
    if (selectedFilterSettings != null) {
      for (FilterSettings filterSettings : myFilters) {
        if (selectedFilterSettings.equals(filterSettings.getId())) {
          selectedFilter = filterSettings;
          break;
        }
      }
    }
    if (selectedFilter != null) {
      removeFilter(selectedFilter);
    }
  }
  
  public void removeFilter(FilterSettings filterSettings) {
    if (filterSettings == null) {
      return;
    }
    MyTaskService myTaskService =
        SeamContextUtils.getComponentByClass(MyTaskService.class, ScopeType.CONVERSATION, true);
    myTaskService.deleteFilter(filterSettings);
    myFilters.remove(filterSettings);
  }

  public String selectFilterSettingsAndGoToMyTasks(FilterSettings filterSettings) {
    if (filterSettings == null || filterSettings.getId() == null) {
      return null;
    }

    selectedFilterSettings = filterSettings.getId();
    selectFilterSettings();
    return MY_TASK_VIEW;
  }

  public TableSetting getTableSetting() {
    return tableSetting;
  }


  public String doing(String activityId) {
    return doing(activityId, MY_TASK_VIEW);
  }

  public void setParamsOrder(String fieldName) {
    setOrderBy(fieldName);
    if (fieldName != null && (fieldName.equals("create") || fieldName.equals("started") || fieldName.equals("limit"))) {
      getTasksByPage(getDataScroll().getPage(), true);
    }

  }

  public String getProcVaribleCaption(String procIdent, Object id, Object resListElement) {
    if (id == null)
      return null;

    String procIdent2 = convertProcessIdentityVaribleName(procIdent);
    ProcessIdentityEntity procVarTemp = identityEntities.get(procIdent2);
    if (procVarTemp == null) {
      return "[не определено]";
    }
    String procId = procVarTemp.getId();
    String entityClass = procVarTemp.getEntityClass();

    Integer fieldIndex = null;
    Date validDate = new Date();

    if ("Zayavitel".equals(procId)) {
      for (int i = 0; i < getVisibleFields().size(); i++) {
        if ("create".equals(getVisibleFields().get(i).getName())) {
          fieldIndex = i;
          break;
        }
      }

      if (resListElement != null && fieldIndex != null) {
        Object[] arr = (Object[]) resListElement;

        try {
          if (arr[fieldIndex] != null) {
            validDate.setTime((Long) arr[fieldIndex]);
          }
        } catch (java.lang.ClassCastException e) {
          _log.debug(e.getMessage(), e);
        }
      }
    }

    if (entityClass == null || entityClass.isEmpty()) {
      if (id instanceof Date)
        return new SimpleDateFormat("dd.MM.yyyy").format(id);
      else
        return id.toString();
    } else {
      if (entityClass.equals("org.cp.common.ObjectGroup")) {
        MyTaskService myTaskService =
            SeamContextUtils.getComponentByClass(MyTaskService.class, ScopeType.CONVERSATION, true);
        ObjectGroup og = myTaskService.getObjGroup((Long) id);
        if (!og.isHaveApplicScopeBinds()){
          Object o = og.getSelectedObject();
          
          if (o instanceof Person) {
            Person p = (Person) o;
            if (p != null && validDate != null) {
              return p.toString(validDate);
            }
          }
        }
      }
      EntityToolsBean entityToolsBean =
          SeamContextUtils.getComponentByClass(EntityToolsBean.class, ScopeType.CONVERSATION, true);
      return entityToolsBean.getEntityName(entityClass, id);
    }
  }


  public String openSetting() {
    needToUpdateColumns = true;

    TableSettingController controller =
        SeamContextUtils.getComponentByClass(TableSettingController.class, ScopeType.SESSION, true);
    controller.clear();
    controller.setReturnView(MY_TASK_VIEW);
    controller.setTable(WorkListSearch.TABLE_SETTING);
    controller.setUser(getPrincipal());
    return TableSettingController.VIEW;
  }

  public String doing(String activityId, String returnView) {
    try {
      WMWorkItem item = getWorkItem(activityId);
      if (item == null)
        return null;
      ListWorkItemController listController =
          (ListWorkItemController) Component.getInstance("listWorkItemController", true);
      listController.init();
      return listController.getList().get(0).selectWorkItem(item, returnView);

    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }

  public WMWorkItem getWorkItem(String activityId) {
    try {
      MyTaskService myTaskService =
          SeamContextUtils.getComponentByClass(MyTaskService.class, ScopeType.CONVERSATION, true);
      String processInstanceId = myTaskService.getProcessId(activityId);
      WMWorkItem w =
          worklistBean.getWapi().getWorkItem(worklistBean.getSessionHandle(), processInstanceId,
              activityId + "#" + getPrincipal());
      return w;
    } catch (Exception e) {
      _log.error("Ошибка получения шага из шарка по id", e);
    }
    return null;
  }


  public String getPrincipal() {
    return identity.getPrincipal() == null ? UserUtils.ANONIMUS : identity.getPrincipal().getName();
  }



  public List<TableFieldSetting> getVisibleFields() {
    // Грязный хак, так как этот метод в jstl тэге отрабатывает быстрее, нежели вызов метода выше
    if (needToUpdateColumns) {
      refresh();
      needToUpdateColumns = false;
      needToUpdateTasksSQL = true;
    }
    return visibleFields;
  }

  /**
   * @return the tasks
   */
  public List<Object[]> getTasks() {
    return tasks;
  }

  public DataScroll getDataScroll() {
    return dataScroll;
  }

  public int getMaxRowCount() {
    return ROW_COUNT_PER_PAGE;
  }

  public List<String> getVisibleIdentityNames() {
    return visibleIdentityNames;
  }

  public Map<String, ProcessIdentityEntity> getIdentityEntities() {
    return identityEntities;
  }

  public UserTableSettingsBean getSearchInstance() {
    return searchInstance;
  }

  public String getFilterName() {
    return filterName;
  }

  public void setFilterName(String filterName) {
    this.filterName = filterName;
  }

  public List<FilterSettings> getMyFilters() {
    return myFilters;
  }

  /**
   * @return the selectedFilterSettings
   */
  public Long getSelectedFilterSettings() {
    return selectedFilterSettings;
  }

  /**
   * @param selectedFilterSettings the selectedFilterSettings to set
   */
  public void setSelectedFilterSettings(Long selectedFilterSettings) {
    this.selectedFilterSettings = selectedFilterSettings;
  }

  public JSONFilter getJsonFilter() {
    return jsonFilter;
  }

  public Collection<FilterItem> getFilters() {
    return filters.values();
  }
  
  public void addRuntimeFilterValues(Map<String, FilterValue> runtimeFilters) {
    Map<String, FilterValue> deserializedFilterValues = 
        new FilterValueDeserializer().deserialize(filters.values(), jsonFilter.getSelectedFilters());
    
    deserializedFilterValues.putAll(runtimeFilters);
    
    String serializedFilterValues = 
        new FilterValueSerializer(deserializedFilterValues.values()).getSerializedJSON();
    
    jsonFilter.setSelectedFilters(serializedFilterValues);
  }

  public String getOrderType() {
    return orderType;
  }

  public void setOrderType(String orderType) {
    this.orderType = orderType;
  }

  public String getOrderBy() {
    return orderBy;
  }

  public void setOrderBy(String orderBy) {
    this.orderBy = orderBy;
    if (orderType != null) {
        if ("asc".equals(orderType)) orderType="desc";
        else orderType=null;
    }
    else orderType="asc";
  }

    public boolean showSignTasksList(){
        UserDAO userDAO = (UserDAO)Component.getInstance(UserDAO.class);
        User currUser = userDAO.getCurrentUser();
        if("max".equals(currUser.getLogin())){
            return true;
        }else{
            for (RoleEnt role : userDAO.getCurrentUser().getRoles()) {
                if ("DirectorOIV".equals(role.getCode())) {
                    return true;
                }
            }
        }
        return false;
    }
  
}
