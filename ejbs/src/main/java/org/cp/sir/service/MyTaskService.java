package org.cp.sir.service;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;

import org.cp.bpms.PackageBean;
import org.cp.bpms.PackageLocal;
import org.cp.bpms.ProcessDefinitionBean;
import org.cp.bpms.ProcessDefinitionBean.ProcessIdentityEntity;
import org.cp.bpms.WorkListSearch;
import org.cp.common.ObjectGroup;
import org.cp.common.UserTableSettingsBean;
import org.cp.common.setting.TableSetting;
import org.cp.common.setting.TableSettingBean;
import org.cp.esia.util.SeamContextUtils;
import org.cp.lodent.User;
import org.cp.lodent.UserDAO;
import org.cp.sir.dao.FilterSettingsDAO;
import org.cp.sir.dao.MyTaskDAO;
import org.cp.sir.dao.MyTaskSearchCriteria;
import org.cp.sir.dao.ObjectGroupDAO;
import org.cp.sir.dao.impl.FilterSettingsDAOImpl;
import org.cp.sir.dao.impl.MyTaskDAOImpl;
import org.cp.sir.dao.impl.ObjectGroupDAOImpl;
import org.cp.sir.filter.RegisterFilterSections;
import org.cp.sir.model.FilterSettings;
import org.cp.utils.UserUtils;
import org.enhydra.shark.api.client.wfservice.WMEntity;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.Begin;
import org.jboss.seam.annotations.Create;
import org.jboss.seam.annotations.In;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;
import org.jboss.seam.log.Log;
import org.jboss.seam.log.Logging;
import org.jboss.seam.security.Identity;

@Name("myTaskService")
@Scope(ScopeType.CONVERSATION)
public class MyTaskService {
  
  private static Log _log = Logging.getLog(MyTaskService.class);

  private MyTaskDAO myTaskDAO;

  private ObjectGroupDAO objGroupDAO;

  private FilterSettingsDAO filterSettingsDAO;

  @In(create = true)
  private Identity identity;

  @In(create = true)
  private PackageBean packageBean;

  @In(value = "processdefinitionBean", create = true)
  private ProcessDefinitionBean processDefinitionBean;



  @Create
  @Begin(join = true)
  public void init() {
    EntityManager em = SeamContextUtils.getComponentByName("entityManager", true);
    myTaskDAO = new MyTaskDAOImpl(em);
    filterSettingsDAO = new FilterSettingsDAOImpl(em);
    objGroupDAO = new ObjectGroupDAOImpl(em);
  }

  public List<FilterSettings> getMyFilters() {
    return filterSettingsDAO.findByUserAndSection(getCurrentUser(), RegisterFilterSections.MY_TASKS);

  }

  public FilterSettings saveFilterSettings(String filterName, String filterSettings) {
    FilterSettings userFilter = new FilterSettings();
    userFilter.setCreateDate(new Date());
    userFilter.setSectionName(RegisterFilterSections.MY_TASKS);
    userFilter.setSettings(filterSettings);
    userFilter.setName(filterName);
    userFilter.setUser(getCurrentUser());
    return filterSettingsDAO.saveOrUpdate(userFilter);
  }

  public User getCurrentUser() {
    UserDAO userDao = SeamContextUtils.getComponentByName("userDAO", true);
    User currUser = userDao.getCurrentUser();
    return currUser;
  }

  private String getCommaSeparatedFields(List<Object[]> tasks, int fieldIndex) {
    StringBuilder st = new StringBuilder();
    for (Object[] task : tasks) {
      st.append("'").append(task[fieldIndex]).append("',");
    }
    return st.substring(0, st.length() - 1);
  }

  public String getProcessId(String activityId) throws Exception {
    return myTaskDAO.getProcessId(activityId);
  }

  public long getTaskCount(MyTaskSearchCriteria searchCriteria, UserTableSettingsBean searchInstance, boolean clearCache)
      throws Exception {
    return myTaskDAO.countByCriteria(searchCriteria, searchInstance, clearCache);
  }


  public List<Object[]> getTasks(MyTaskSearchCriteria searchCriteria, UserTableSettingsBean searchInstance, int from,
      int count, boolean clearCache) throws Exception {
    List<Object[]> tasks = myTaskDAO.findByCriteria(searchCriteria, searchInstance, from, count, clearCache);
    if (tasks.size() > 0) {
      int actid = searchCriteria.getColumnNames().size();
      int docPackageIdCollum =  searchCriteria.getColumnNames().indexOf("proc_ident.Komplekt_doc");
      String actsIds = getCommaSeparatedFields(tasks, actid);
      List<Object[]> statusDataList = myTaskDAO.getTaskStatusData(actsIds);
      for (Object[] task : tasks) {
        String act = (String) task[actid];
        for (Object[] statusData : statusDataList) {
          if (act.equals(statusData[0])) {
            if (searchCriteria.getColumnNames().indexOf("statusicon") != -1) {
              task[searchCriteria.getColumnNames().indexOf("statusicon")] = statusData[1];
            }
            if (searchCriteria.getColumnNames().indexOf("create") != -1)
              task[searchCriteria.getColumnNames().indexOf("create")] = statusData[2];
            if (searchCriteria.getColumnNames().indexOf("started") != -1)
              task[searchCriteria.getColumnNames().indexOf("started")] = statusData[2];
            if (searchCriteria.getColumnNames().indexOf("process") != -1)
              task[searchCriteria.getColumnNames().indexOf("process")] = statusData[4];
            if (searchCriteria.getColumnNames().indexOf("act") != -1)
              task[searchCriteria.getColumnNames().indexOf("act")] = statusData[0] + "@" + statusData[3];
            if (searchCriteria.getColumnNames().indexOf("status") != -1)
              task[searchCriteria.getColumnNames().indexOf("status")] = statusData[1];
            if (searchCriteria.getColumnNames().indexOf("docPackageComment") != -1)
                task[searchCriteria.getColumnNames().indexOf("docPackageComment")] = myTaskDAO.getDocPackageComment(task[docPackageIdCollum]);
          }
        }
       }
    }
    return tasks;
  }


  public TableSetting getTableSetting() {
    TableSettingBean tableSettingBean = SeamContextUtils.getComponentByClass(TableSettingBean.class, true);
    return tableSettingBean.getSetting(WorkListSearch.TABLE_SETTING, getPrincipal());
  }

  public String getPrincipal() {
    return identity.getPrincipal() == null ? UserUtils.ANONIMUS : identity.getPrincipal().getName();
  }

  public Map<String, ProcessIdentityEntity> getAllProcessIdentityEnities() {
    Map<String, ProcessIdentityEntity> allActualProcessIdentityVariables = new HashMap<String, ProcessIdentityEntity>();
    for (WMEntity pkg : packageBean.getList(PackageLocal.Version.ACTUAL)) {
      allActualProcessIdentityVariables.putAll(processDefinitionBean.getProcessIdentityEntities(pkg));
    }
    return allActualProcessIdentityVariables;
  }

  public String convertProcessIdentityVaribleName(String varibleName) {
    // если параметр начинается с идентификатора, то отбрасываем его.
    if (varibleName.startsWith(WorkListSearch.IDENTITY_PRE))
      varibleName = varibleName.substring(WorkListSearch.IDENTITY_PRE.length() + 1/* плюс точка */);
    return varibleName;
  }

  public ObjectGroup getObjGroup(Long objGroupId) {
    return objGroupDAO.find(objGroupId);
  }
  
  public Map<String, String> getExternalSystems() {
    Map<String, String> retVal = new HashMap<String, String>();
    try {
      List<Object[]> extSystParams = myTaskDAO.getExternalSystem();
      for (Object[] extSystParam : extSystParams) {
          retVal.put(extSystParam[1].toString(), extSystParam[0].toString());
      }
    } catch (Exception e) {
      _log.error(e.getMessage(), e);
    }
    return retVal;
  }
  
  public Map<String, String> getServices() {
    Map<String, String> retVal = new LinkedHashMap<String, String>();
    try {
      List<Object[]> serviceIdNames = myTaskDAO.getCardElementsByCode("SService");
      Map<String, String> tempRetVal = new LinkedHashMap<String, String>();
      for (Object[] serviceIdName : serviceIdNames) {
        String serviceName = serviceIdName[1] != null ? ((String) serviceIdName[1]).trim() : null;
        String serviceCode = (String)serviceIdName[0];
        if (serviceName != null) {
          if (!tempRetVal.containsKey(serviceName)) {
            tempRetVal.put(serviceName, serviceCode);
          } else {
            tempRetVal.put(serviceName, String.format("'%s','%s'", tempRetVal.get(serviceName), serviceCode));
          }
        }
      }
      
     for (String serviceName : tempRetVal.keySet()) {
       retVal.put(tempRetVal.get(serviceName), serviceName);
     }
    } catch (Exception e) {
      _log.error(e.getMessage(), e);
    }
    return retVal;
  }
  
  public void deleteFilter(FilterSettings filterSettings) {
    filterSettingsDAO.remove(filterSettings);
  }

}
