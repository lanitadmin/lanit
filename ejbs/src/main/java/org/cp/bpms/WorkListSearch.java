package org.cp.bpms;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.faces.model.SelectItem;
import javax.persistence.EntityManager;

import org.cp.common.Filter;
import org.cp.common.FilterCreator;
import org.cp.common.setting.TableDefSetting;
import org.cp.common.setting.TableFieldSetting;
import org.cp.common.setting.TableFieldValueSetting;
import org.cp.common.setting.TableSetting;
import org.cp.common.setting.TableSettingBean;
import org.cp.common.setting.TableSettingController;
import org.cp.common.setting.UseTableSetting;
import org.cp.shark.ListWorkItemController;
import org.cp.shark.ProcessVariable;
import org.enhydra.shark.api.client.wfmc.wapi.WMWorkItem;
import org.enhydra.shark.api.client.wfservice.WMEntity;
import org.jboss.seam.Component;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.Factory;
import org.jboss.seam.annotations.In;
import org.jboss.seam.annotations.Logger;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;
import org.jboss.seam.contexts.Contexts;
import org.jboss.seam.log.Log;
import org.jboss.seam.security.Identity;

/**
 * Контроллер для поиска по задачам
 * 
 * @author zaharov
 * 
 */
@Name("worklistSearch")
@Scope(ScopeType.SESSION)
public class WorkListSearch implements UseTableSetting, Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4173551021043202267L;
	
	static final String FILTER_TARGET = "WorkListSearch";
	public static final String TABLE_SETTING = "worklistSearch";
	private static final String ANONIMUS = "anon";
	public static final String IDENTITY_PRE = "proc_ident";
	public static final String VIEW = "/member/myTasks.xhtml";
	private static final String[][] DEFAULT_FIELD = { {"statusicon", ""}, { "create", "Создано" },
			{ "started", "Принято к исполнению" }, { "process", "Процесс" },
			{ "act", "Шаг" }, { "status", "Статус" },
			{ "limit", "Срок исполнения до" }, {"test", "Тест"} };

	@Logger
	Log log;

	@In(create = true)
	WorkItemLocal workitemBean;
	@In(create = true)
	ActivityInstanceLocal activityinstanceBean;
	@In(create = true)
	ProcessInstanceLocal processinstanceBean;
	@In(create = true)
	ProcessDefinitionLocal processdefinitionBean;
	@In(create = true)
	PackageLocal packageBean;

	@In(create = true)
	FilterCreator filterCreator;

	@In(create = true)
	Identity identity;

	@In(create = true)
	TableSettingBean tablesettingBean;
	private TableSetting tableSetting;
	private Map<String, TableFieldValueSetting> fieldSettingMap;
	private List<TableFieldSetting> visibleFields;

	@In
	EntityManager entityManager;

	@Factory(value="workItemList", scope=ScopeType.PAGE)
	public List<WorkTask> getWorkItemList() {
		List<WorkTask> workItemList = new ArrayList<WorkTask>();
		List<WMWorkItem> resultItem = workitemBean.getList(getActiveFilters());
		for (WMWorkItem item : resultItem)
			workItemList.add(new WorkTask(item));
		return workItemList;
	}

	public String refresh()
	{
		return VIEW;
	}

	private SearchInfo searchInstance = new SearchInfo();
	private List<FilterInfo> filters;

	private List<String> identities;
	private Map<String, String> identityCaption;
	private Map<String, List<ProcessVariable>> identityValues;

	/* Getters and Setters */

	public SearchInfo getSearchInstance() {
		if (searchInstance == null)
			searchInstance = new SearchInfo(getIdentities());
		return searchInstance;
	}

	public void setSearchInstance(SearchInfo searchInstance) {
		this.searchInstance = searchInstance;
	}

	private String newFilterName;

	public String getNewFilterName() {
		return newFilterName;
	}

	public void setNewFilterName(String newFilterName) {
		this.newFilterName = newFilterName;
	}

	public List<String> getIdentities() {
		if (identities == null) {
			identities = Arrays.asList(getIdentityCaption().keySet().toArray(
					new String[0]));
		}
		return identities;
	}

	@SuppressWarnings("unchecked")
	public List<ProcessVariable> getIdentityValues(String key) {
		boolean addToValue;
		
		if (identityValues == null) {
			identityValues = new HashMap<String, List<ProcessVariable>>();
			
			List<WorkTask> workItemList = (List<WorkTask>)Component.getInstance("workItemList");
			for (WorkTask task : workItemList)
				for (String skey : task.getIdentities().keySet()) {
					ProcessVariable value = task.getIdentities().get(skey);
					if (value.getValue() != null /*&& value.getCaption() != null
							&& !value.getCaption().isEmpty()*/) {
						List<ProcessVariable> list = identityValues.get(skey);
						if (list == null) {
							list = new ArrayList<ProcessVariable>();
							identityValues.put(skey, list);
						}
						addToValue = true;
						for (ProcessVariable variable : list)
							if (variable.getValue().equals(value.getValue())) {
								addToValue = false;
								break;
							}
						if (addToValue)
							list.add(value);
					}
				}
		}
		return identityValues.get(key);
	}

	@SuppressWarnings("unchecked")
	public Map<String, String> getIdentityCaption() {
		if (identityCaption == null) {
			identityCaption = new HashMap<String, String>();
			
			List<WorkTask> workItemList = (List<WorkTask>)Component.getInstance("workItemList");
			for (WorkTask task : workItemList)
				for (String key : task.getIdentities().keySet())
					if (identityCaption.get(key) == null)
						identityCaption.put(key, task.getIdentities().get(key)
								.getName());

		}
		return identityCaption;
	}

	public List<String> getVisibleIdentities() {
		List<String> result = new ArrayList<String>();
		for (String ident : getIdentities())
			if (isVisible(IDENTITY_PRE + "." + ident))
				result.add(ident);
		return result;
	}

	public String getTableSettingName() {
		return TABLE_SETTING;
	}

	public TableSetting getTableSetting() {
		if (tableSetting == null)
			tableSetting = tablesettingBean.getSetting(TABLE_SETTING,
					getPrincipal());
		return tableSetting;
	}

	public Map<String, TableFieldValueSetting> getFieldSettingMap() {
		if (fieldSettingMap == null) {
			fieldSettingMap = new HashMap<String, TableFieldValueSetting>();
			for (TableFieldValueSetting value : getTableSetting().getFields())
				fieldSettingMap.put(value.getField().getName(), value);
		}
		return fieldSettingMap;
	}

	public List<TableFieldSetting> getVisibleFields() {
		if (visibleFields == null) {
			visibleFields = new ArrayList<TableFieldSetting>();
			for (TableFieldValueSetting value : getTableSetting()
					.getVisibleFields()) {
				visibleFields.add(value.getField());
			}
		}
		return visibleFields;
	}

	String viewOpenSearch = "false";
	
	public String getViewOpenSearch() {
		return viewOpenSearch;
	}

	public void setViewOpenSearch(String viewOpenSearch) {
		this.viewOpenSearch = viewOpenSearch;
	}	
	
	String viewOpenSearchIdentities = "false";

	public String getViewOpenSearchIdentities() {
		return viewOpenSearchIdentities;
	}

	public void setViewOpenSearchIdentities(String viewOpenSearchIdentities) {
		this.viewOpenSearchIdentities = viewOpenSearchIdentities;
	}	
	

	/* Select Items viewOpenSearchIdentities*/



	public List<SelectItem> getPackageSelectList() {
		List<SelectItem> result = new ArrayList<SelectItem>();
		result.add(new SelectItem("", "[не выбрано]"));
		for (WMEntity entity : packageBean.getList(PackageLocal.Version.ACTUAL)) {
			result.add(new SelectItem(entity.getId(), entity.getName()));
		}
		return result;
	}

	public List<SelectItem> getPackageVersionSelectList() {
		List<SelectItem> result = new ArrayList<SelectItem>();
		result.add(new SelectItem(PackageLocal.VERSION_ALL, "Все версии"));
		result.add(new SelectItem(PackageLocal.VERSION_ACTUAL,
				"Актуальная версия"));
		return result;
	}

	public List<SelectItem> getProcessSelectList() {
		List<SelectItem> result = new ArrayList<SelectItem>();
		result.add(new SelectItem("", "[не выбрано]"));
		for (WMEntity def : processdefinitionBean.getProcessDefs(
				searchInstance.getPackageId()))
			result.add(new SelectItem(def.getId(), def.getName()));
		return result;
	}

	public List<SelectItem> getActivityDefSelectList() {
		List<SelectItem> result = new ArrayList<SelectItem>();
		result.add(new SelectItem("", "[не выбрано]"));
		String pkgId = searchInstance.getPackageId();
		String procId = searchInstance.getProcessId();
		if (pkgId != null && !pkgId.isEmpty() && procId != null
				&& !procId.isEmpty())
			for (WMEntity def : activityinstanceBean.getActivityDefs(pkgId,
					procId))
				result.add(new SelectItem(def.getId(), def.getName()));
		return result;
	}

	public List<SelectItem> getIdentityValuesSelectList(String key) {
		List<SelectItem> result = new ArrayList<SelectItem>();
		result.add(new SelectItem("", "[не выбрано]"));
		List<ProcessVariable> list = getIdentityValues(key);
		HashSet<String> tmp = new HashSet<String>();
		if (list != null)
			for (ProcessVariable o : list) {
				if (o.getCaption() != null && tmp.add(o.getCaption()))
					result.add(new SelectItem(o.getCaption(), o.getCaption()));
			}

		return result;
	}
	
	public List<String> getIdentityValuesList(String key) {
		List<String> result = new ArrayList<String>();
		List<ProcessVariable> list = getIdentityValues(key);
		HashSet<String> tmp = new HashSet<String>();
		if (list != null)
			for (ProcessVariable o : list) {
				if (o.getCaption() != null && tmp.add(o.getCaption()))
					result.add(o.getCaption());
			}
		log.info("#0 result before: #1", key, result);
		Collections.sort(result);
		log.info("#0 result after : #1", key, result);
		return result;
	}

	private String getPrincipal() {
		return identity.getPrincipal() == null ? ANONIMUS : identity
				.getPrincipal().getName();
	}

	/* Controls */

	public void addFilter() {
		if (newFilterName != null && !newFilterName.isEmpty()) {
			Filter filter = new Filter();
			filter.setName(newFilterName);
			filter.setTarget(FILTER_TARGET);
			filter.setUser(getPrincipal());
			filter.setProperties(createFilter());
			filterCreator.save(filter);
			newFilterName = null;
			filters = null;
			clearSearchForm();
		}
	}

	public void deleteFilter(FilterInfo filter) {
		filterCreator.delete(filter.getFilter());
		filters = null;
	}

	public void clearResultList() {
		Contexts.removeFromAllContexts("workItemList");
		clearTableSetting();
	}

	public void clearTableSetting() {
		tableSetting = null;
		fieldSettingMap = null;
		visibleFields = null;
	}

	public void clearSearchForm() {
		identities = null;
		identityCaption = null;
		identityValues = null;
		this.searchInstance = new SearchInfo(getIdentities());
	}

	public boolean isVisible(String name) {
		TableFieldValueSetting field = getFieldSettingMap().get(name);
		if (field == null)
			return false;
		return field.isVisible();
	}

	public String doing(WMWorkItem item) {
		clearResultList();
		try {
			ListWorkItemController controller = (ListWorkItemController) Component
					.getInstance("listWorkItemController", true);
			return controller.getActiveController().selectWorkItem(item, VIEW);
		} catch (Exception e) {
			log.error("aaa", e);
		}
		return null;
	}

	public String openSetting() {
		clearSearchForm();
		clearResultList();
		TableSettingController controller = (TableSettingController) Component
				.getInstance(TableSettingController.class, ScopeType.SESSION,
						true);
		controller.setReturnView(VIEW);
		controller.setTable(TABLE_SETTING);
		controller.setUser(getPrincipal());
		return TableSettingController.VIEW;
	}

	public TableDefSetting getDefaultTableDefSetting() {
		// TableDefSetting
		TableDefSetting tableDefSetting = TableDefSetting.createTableDefSettingInstance(TABLE_SETTING,
				"Мои задачи");
		// TableFieldSetting
		for (String[] str : DEFAULT_FIELD) {
			tableDefSetting.getFields().add(
					TableFieldSetting.createTableSettingInstance(tableDefSetting, str[0], str[1]));
		}
		return tableDefSetting;
	}

	public List<TableFieldSetting> getPassibleFields() {
		List<TableFieldSetting> result = new ArrayList<TableFieldSetting>();
		for (String[] str : DEFAULT_FIELD)
			result.add(TableFieldSetting.createTableSettingInstance(null, str[0], str[1]));
		
		List<WMEntity> packages =  packageBean.getList();
		Map<String, String> propsMap = new HashMap<String, String>(); 
		for(WMEntity pkg:packages){
			propsMap.putAll(processdefinitionBean.getProcIdentities(pkg));
		}
		
		for(String key :   propsMap.keySet()){
			result.add(TableFieldSetting.createTableSettingInstance(null, IDENTITY_PRE + "." + key, propsMap.get(key)));
		}
		
		//Наши поля, которых нет в xpdl
        result.add(TableFieldSetting.createTableSettingInstance(null, IDENTITY_PRE + "." + "coreStatusSoap", "Статус запроса"));
        
		return result;
	}

	/* Filters */

	public List<FilterInfo> getFilters() {
		if (getPrincipal().equals(ANONIMUS))
			return new ArrayList<FilterInfo>();
		if (filters == null)
			filters = findFilters();
		return filters;
	}

	private List<FilterInfo> findFilters() {
		List<Filter> list = filterCreator.getFilters(FILTER_TARGET,
				getPrincipal());
		List<FilterInfo> result = new ArrayList<FilterInfo>();
		for (Filter filter : list) {
			result.add(new FilterInfo(filter));
		}
		return result;
	}

	private List<Properties> getActiveFilters() {
		List<Properties> filters = new ArrayList<Properties>();
		filters.add(createFilter());
		for (FilterInfo filterInfo : getFilters()) {
			if (filterInfo.isCheck())
				filters.add(filterInfo.getFilter().getProperties());
		}
		return filters;
	}

	private Properties createFilter() {
		Properties filter = new Properties();

		String property;

		if ((property = searchInstance.getPackageId()) != null
				&& !property.isEmpty())
			filter.put(PackageLocal.FILTER_PACKAGE_ID, property);
		if ((property = searchInstance.getPackageVersion()) != null
				&& !property.isEmpty())
			filter.put(PackageLocal.FILTER_PACKAGE_VERSION, property);
		if ((property = searchInstance.getProcessId()) != null
				&& !property.isEmpty())
			filter.put(ProcessDefinitionLocal.FILTER_PROCESSDEF_ID, property);
		if ((property = searchInstance.getActivityDef()) != null
				&& !property.isEmpty())
			filter
					.put(
							ActivityInstanceLocal.FILTER_ACTIVITYINSTANCE_ACTIVITYDEFINITIONID,
							property);
		if (searchInstance.getCreateFrom() != null)
			filter.put(ProcessInstanceLocal.FILTER_CREATE_FROM, new Long(
					searchInstance.getCreateFrom().getTime()).toString());
		if (searchInstance.getCreateTo() != null)
			filter.put(ProcessInstanceLocal.FILTER_CREATE_TO, new Long(
					searchInstance.getCreateTo().getTime()).toString());
		if (searchInstance.getStartedFrom() != null)
			filter.put(ProcessInstanceLocal.FILTER_STARTED_FROM, new Long(
					searchInstance.getStartedFrom().getTime()).toString());
		if (searchInstance.getStartedTo() != null)
			filter.put(ProcessInstanceLocal.FILTER_STARTED_TO, new Long(
					searchInstance.getStartedTo().getTime()).toString());
		if (searchInstance.getLimitFrom() != null)
			filter.put(ProcessInstanceLocal.FILTER_LIMIT_FROM, new Long(
					searchInstance.getLimitFrom().getTime()).toString());
		if (searchInstance.getLimitTo() != null)
			filter.put(ProcessInstanceLocal.FILTER_LIMIT_TO, new Long(
					searchInstance.getLimitTo().getTime()).toString());

		for (String key : searchInstance.getIdentities().keySet()) {
			String value = searchInstance.getIdentities().get(key);
			if (value != null && !value.isEmpty())
				filter.put(ProcessInstanceLocal.FILTER_IDENTITIES_PRED + key,
						value);
		}

		return filter;
	}

	/* Result List */
/*
	public List<WorkTask> getResultList() {
		if (resultList != null)
			return resultList;
		resultList = new ArrayList<WorkTask>();
		List<WMWorkItem> resultItem = workitemBean.getList(getActiveFilters());
		for (WMWorkItem item : resultItem)
			resultList.add(new WorkTask(item));
		return resultList;
	}
*/

	/*
	 * private List<WMWorkItem> workItemList;
	 * 
	 * public List<WMWorkItem> getWorkItemList() { if (workItemList == null)
	 * workItemList = workitemBean.getList(); return workItemList; }
	 * 
	 * private List<WMActivityInstance> activityInstanceList;
	 * 
	 * public List<WMActivityInstance> getActivityInstanceList() { if
	 * (activityInstanceList == null) activityInstanceList =
	 * activityinstanceBean.getList(); return activityInstanceList; }
	 * 
	 * private List<WMProcessInstance> processInstanceList;
	 * 
	 * public List<WMProcessInstance> getProcessInstanceList() { if
	 * (processInstanceList == null) processInstanceList =
	 * processinstanceBean.getList(); return processInstanceList; }
	 * 
	 * private List<WMProcessDefinition> processDefinitionList;
	 * 
	 * public List<WMProcessDefinition> getProcessDefinitionList() { if
	 * (processDefinitionList == null) processDefinitionList =
	 * processdefinitionBean.getList(); return processDefinitionList; }
	 * 
	 * private List<WMEntity> packageList;
	 * 
	 * public List<WMEntity> getPackageList() { if (packageList == null)
	 * packageList = packageBean.getList(); return packageList; }
	 */
	/* Inner classes */

	public class WorkTask {
		public Date created;
		public Date started;
		public Date limited;
		private WMWorkItem item;
		private WMEntity processDef;
		private Map<String, ProcessVariable> identities = new HashMap<String, ProcessVariable>();

		public WorkTask(WMWorkItem item) {
			this.item = item;
			processDef = processdefinitionBean
					.getEntityByProcessInstanceId(item.getProcessInstanceId());
			identities = processinstanceBean.getIdentityMap(item
					.getProcessInstanceId());
			created = workitemBean.getCreated(item);
			started = workitemBean.getStarted(item);
			limited = workitemBean.getLimited(item);
		}

		public WMWorkItem getItem() {
			return item;
		}

		public void setItem(WMWorkItem item) {
			this.item = item;
		}

		public String getName() {
			return item.getName();
		}

		public String getStatus() {
			return item.getState().toString();
		}

		public Date getCreated() {
			return created;
		}

		public void setCreated(Date created) {
			this.created = created;
		}

		public Date getStarted() {
			return started;
		}

		public void setStarted(Date started) {
			this.started = started;
		}

		public Date getLimited() {
			return limited;
		}

		public void setLimited(Date limited) {
			this.limited = limited;
		}

		public WMEntity getProcessDef() {
			return processDef;
		}

		public Map<String, ProcessVariable> getIdentities() {
			return identities;
		}

		public boolean nowLimited() {
			if (limited == null)
				return false;
			return new Date().compareTo(limited) > 0;
		}

		public ProcessVariable getIdentitiesByField(String field) {
                    
                    log.error("DEBUG REQUESTED FIELD {}", field);
                    
//                    if (field.contains("coreStatusSoap")) {
//                        ProcessVariable var = new ProcessVariable();
//                        return getIdentities().get("act");
//                    }
                        
			if (field.startsWith(IDENTITY_PRE))
				field = field.substring(IDENTITY_PRE.length() + 1);
                        
                        
                        ProcessVariable var = getIdentities().get(field);
                        
                         log.error("DEBUG REQUESTED FIELD {} VALUE {} {}", field, var.getValue(), var);
                        
			return var;
		}
	}

	public static class SearchInfo {
		private String packageId;
		private String packageVersion;
		private String processId;
		private String activityDef;
		private String status;
		private Date createFrom;
		private Date createTo;
		private Date startedFrom;
		private Date startedTo;
		private Date limitFrom;
		private Date limitTo;

		// private Map<String, Boolean> identVisible = new HashMap<String,
		// Boolean>();
		private Map<String, String> identities = new HashMap<String, String>();

		public SearchInfo() {
			packageVersion = PackageLocal.VERSION_ALL;
		}

		public SearchInfo(List<String> identities) {
			this();
			for (String string : identities) {
				this.identities.put(string, null);
				// this.identVisible.put(string, false);
			}
		}

		public String getPackageId() {
			return packageId;
		}

		public void setPackageId(String packageId) {
			this.packageId = packageId;
		}

		public String getPackageVersion() {
			return packageVersion;
		}

		public void setPackageVersion(String packageVersion) {
			this.packageVersion = packageVersion;
		}

		public String getProcessId() {
			return processId;
		}

		public void setProcessId(String processId) {
			this.processId = processId;
		}

		public String getActivityDef() {
			return activityDef;
		}

		public void setActivityDef(String activityDef) {
			this.activityDef = activityDef;
		}

		public String getStatus() {
			return status;
		}

		public void setStatus(String status) {
			this.status = status;
		}

		public Date getCreateFrom() {
			return createFrom;
		}

		public void setCreateFrom(Date createFrom) {
			this.createFrom = createFrom;
		}

		public Date getCreateTo() {
			return createTo;
		}

		public void setCreateTo(Date createTo) {
			this.createTo = createTo;
		}

		public Date getStartedFrom() {
			return startedFrom;
		}

		public void setStartedFrom(Date startedFrom) {
			this.startedFrom = startedFrom;
		}

		public Date getStartedTo() {
			return startedTo;
		}

		public void setStartedTo(Date startedTo) {
			this.startedTo = startedTo;
		}

		public Date getLimitFrom() {
			return limitFrom;
		}

		public void setLimitFrom(Date limitFrom) {
			this.limitFrom = limitFrom;
		}

		public Date getLimitTo() {
			return limitTo;
		}

		public void setLimitTo(Date limitTo) {
			this.limitTo = limitTo;
		}

		// public Map<String, Boolean> getIdentVisible() {
		// return identVisible;
		// }
		//
		// public void setIdentVisible(Map<String, Boolean> identVisible) {
		// this.identVisible = identVisible;
		// }

		public Map<String, String> getIdentities() {
			return identities;
		}

		public void setIdentities(Map<String, String> identities) {
			this.identities = identities;
		}

		// public List<String> getVisibleIdentities() {
		// List<String> result = new ArrayList<String>();
		// for (String key : identVisible.keySet())
		// if (identVisible.get(key))
		// result.add(key);
		// return result;
		// }

		@Override
		public String toString() {
			return "{packageId=" + packageId + ", packageVersion="
					+ packageVersion + ", processId=" + processId
					+ ", activityDef=" + activityDef + ", status=" + status
					+ ", createFrom=" + createFrom + ", createTo=" + createTo
					+ ", startedFrom=" + startedFrom + ", startedTo="
					+ startedTo + ", limitFrom=" + limitFrom + ", limitTo="
					+ limitTo + ", identities=" + identities + "}";
		}

		public boolean isClear() {
			return (packageId == null || packageId.isEmpty())
					&& (processId == null || processId.isEmpty())
					&& (activityDef == null || activityDef.isEmpty())
					&& (status == null || status.isEmpty())
					&& (createFrom == null) && (createTo == null)
					&& (startedFrom == null) && (startedTo == null)
					&& (limitFrom == null) && (limitTo == null)
					&& (isEmpty(identities));
		}

		private boolean isEmpty(Map<String, String> identities2) {
			if (identities != null || !identities.isEmpty())
				return true;
			for (String value : identities.values())
				if (value != null)
					return false;
			return true;
		}
	}

	public static class FilterInfo {
		private boolean check = false;
		private Filter filter;

		public FilterInfo(Filter filter) {
			this.filter = filter;
		}

		public boolean isCheck() {
			return check;
		}

		public boolean getCheck() {
			return check;
		}

		public void setCheck(boolean check) {
			this.check = check;
		}

		public Filter getFilter() {
			return filter;
		}

		public void setFilter(Filter filter) {
			this.filter = filter;
		}

		public String getName() {
			return filter.getName();
		}
	}

}
