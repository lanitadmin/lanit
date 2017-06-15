package org.cp.gossrvc;

import org.cp.admin.AppSettingsBean;
import org.cp.audit.AuditEvent;
import org.cp.audit.AuditManager;
import org.cp.audit.IAuditManager;
import org.cp.cardsystem.CardElement;
import org.cp.common.Kontroller;
import org.cp.common.ObjectGroup;
import org.cp.common.ObjectGroupItem;
import org.cp.common.SelectableQuery;
import org.cp.esia.util.SeamContextUtils;
import org.cp.gossrvc.analisys.AllAboutModel;
import org.cp.gossrvc.terminate.DocPackageForDelete;
import org.cp.lod.DataScroll;
import org.cp.lod.UserPrefs;
import org.cp.lodent.Agent;
import org.cp.lodent.User;
import org.cp.lodent.UserDAO;
import org.cp.model.common.Person;
import org.cp.sed.HierUtils;
import org.cp.sed.OrgUnit;
import org.cp.shark.MiscXpdlUtilities;
import org.cp.shark.ProcessController;
import org.cp.shark.ProcessVariable;
import org.cp.shark.SharkSession;
import org.cp.sharkimpl.persistanse.model.ActivityEntity;
import org.cp.sharkimpl.persistanse.model.AssignmentEntity;
import org.cp.sir.dao.FilterSettingsDAO;
import org.cp.sir.dao.impl.FilterSettingsDAOImpl;
import org.cp.sir.filter.RegisterFilterSections;
import org.cp.sir.model.FilterSettings;
import org.enhydra.shark.api.client.wfmc.wapi.WMFilter;
import org.enhydra.shark.api.client.wfmc.wapi.WMProcessInstance;
import org.enhydra.shark.api.client.wfmc.wapi.WMSessionHandle;
import org.enhydra.shark.api.client.wfservice.WMEntity;
import org.enhydra.shark.api.common.ProcessFilterBuilder;
import org.enhydra.shark.client.utilities.SharkInterfaceWrapper;
import org.jboss.seam.Component;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.In;
import org.jboss.seam.annotations.Logger;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;
import org.jboss.seam.annotations.security.Restrict;
import org.jboss.seam.faces.FacesMessages;
import org.jboss.seam.international.StatusMessage;
import org.jboss.seam.log.Log;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import ru.lanit.core.entity.GossrvcDocPackageBase.TypeStatus;
import ru.lanit.core.entity.GossrvcServiceAttrBase;
import ru.lanit.util.Util;

import javax.faces.model.SelectItem;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Name("gossrvcDocPackageList")
@Scope(ScopeType.CONVERSATION)
public class GossrvcDocPackageList extends SelectableQuery<GossrvcDocPackage> {
	
	@Logger
	Log log;
	
    @In
    EntityManager entityManager;

    @In(create = true)
    UserPrefs userPrefs;
    
    @In
    SharkSession sharkSession;
    
    @In(create = true)
    AppSettingsBean appSettings;    
    
    IAuditManager auditManager;

    private ProcessController processController;

    private List<GossrvcDocPackage> resultList;

    private Map<Long, Boolean> checked = new HashMap<Long, Boolean>();

    private boolean extendedMode;

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat rdf = new SimpleDateFormat("dd.MM.yyyy");

    public TypeStatus getTypeStatus() {
		return typeStatus;
	}

	public void setTypeStatus(TypeStatus typeStatus) {
		this.typeStatus = typeStatus;
	}

	private TypeStatus typeStatus;

    // Кэширование объектов (текущие шаги, пользователи, дедлайны и т.д.)
    private Map<String, Object> cacheMap;
 
    private AllAboutModel filter = new AllAboutModel();
    
    private Integer currCharacteristic;
    
    private Boolean checkAllPackDoc = false;        
    
    public Boolean getCheckAllPackDoc() {
		return checkAllPackDoc;
	}

	public void setCheckAllPackDoc(Boolean checkAllPackDoc) {
		this.checkAllPackDoc = checkAllPackDoc;
	}

	public Integer getCurrCharacteristic() {
		return currCharacteristic;
	}

	public void setCurrCharacteristic(Integer currCharacteristic) {
		this.currCharacteristic = currCharacteristic;
	}

	public AllAboutModel getFilter() {
      return filter;
    }

    public void setFilter(AllAboutModel filter) {
      this.filter = filter;
    }
    
    private Map<String, OrgUnit> orgUnits = new HashMap<String, OrgUnit>();

    public Map<String, OrgUnit> getOrgUnits() {
        return orgUnits;
    }

    private Map<String, Object> searchParameters;

    public Map<String, Object> getSearchParameters() {
        if (searchParameters == null) {
            searchParameters = new HashMap<String, Object>();
        }
        return searchParameters;
    }

    protected String getComponentName() {
        return Component.getComponentName(this.getClass());
    }

    public Map<String, Object> getCacheMap() {
        if (cacheMap == null) {
            cacheMap = new HashMap<String, Object>();
        }
        return cacheMap;
    }

    public void setCacheMap(Map<String, Object> cacheMap) {
        this.cacheMap = cacheMap;
    }

    protected String getFromClause() {
        String resultFromClause = "GossrvcDocPackage p";
        if (this.testValue(this.getSearchParameters().get("workingUser")))
            resultFromClause += ", AssignmentEntity a";
        return resultFromClause;
    }

  public List<SelectItem> getGoalList(Object search) {
    List<SelectItem> result;
    String stringSearch = search.toString().trim();
    String filter = "";
    if (stringSearch.length()>0){
      filter = " and lower(docTree.docTypeId.name) like lower('%" + stringSearch + "%')";
    }
    if(this.getSearchParameters().get("serviceId") != null) {
      result = this.getEntityManager().createQuery("select new javax.faces.model.SelectItem(docTree.docTypeId.id, docTree.docTypeId.name) from GossrvcServiceDocTree docTree, CardElement card  where docTree.serviceId = card and card.id = :serviceId and docTree.parent is null " + filter + " order by docTree.docTypeId.name").setParameter("serviceId", this.getSearchParameters().get("serviceId")).getResultList();
    } else {
      result = this.getEntityManager().createQuery("select new javax.faces.model.SelectItem(docTree.docTypeId.id, docTree.docTypeId.name) from GossrvcServiceDocTree docTree, CardElement card  where docTree.serviceId = card  and docTree.parent is null " + filter + "  order by docTree.docTypeId.name").getResultList();
    }
    return result;
  }

    public Date upDate(Date date){
      if (date == null) return null;
      Calendar c1=Calendar.getInstance();
      c1.setTime(date);
      c1.set(Calendar.HOUR_OF_DAY, 23);
      c1.set(Calendar.MINUTE, 59);
      c1.set(Calendar.SECOND, 59);
      return c1.getTime();
    }
    
    private List<String> list;
    
    public List<SelectItem> getListStep(Object search){
      if (list==null){
        list=(List<String>)entityManager.createQuery("SELECT dm.actName "+
            "FROM XpdlObjectName dm WHERE dm.actName is not null and length(dm.actName)>0 "+
            "group by dm.actName order by dm.actName")
            .setHint("org.hibernate.cacheable",true)
            .getResultList();
      }
      List<SelectItem> res=new ArrayList<SelectItem>();
      boolean all=(search==null||"".equals(search));
      String s=((String)search).toLowerCase();
      for(int k=0;k<list.size();k++){
        String i=list.get(k);
        if (all||(i!=null&&i.toLowerCase().indexOf(s)!=-1)){
          res.add(new SelectItem(k,i));
        }
        if (res.size()==25)
          break;
      }
      return res;
    }
    
    public List<SelectItem> getListUser(Object search){
      String sql="";
      if (search==null||"".equals(search))
          sql+=" (u.test is null OR u.test=false) AND u.enabled=true AND ";
      return (List<SelectItem>)entityManager.createQuery("SELECT new javax.faces.model.SelectItem(u.login,concat(u.lastName,' ',u.firstName)) "+
          "FROM User u WHERE "+sql+
          " lower(concat(u.lastName,' ',u.firstName)) like :search "+
          "order by u.lastName,u.firstName")
          .setHint("org.hibernate.cacheable",true)
          .setParameter("search", "%"+search+"%")
          .setMaxResults(25)
          .getResultList();
    }
    
    public List<SelectItem> getSuggestionOGV(Object value){
        String sql="SELECT new javax.faces.model.SelectItem(o.id, o.name) FROM GossrvcServiceDocTree dm join dm.ogvs o"+
        " WHERE dm.parent is null ";
        if (value!=null&&!"".equals(value))
          sql+=" and lower(o.name) like :search";
        sql+=" GROUP BY o.id,o.name";
        Query q=getEntityManager().createQuery(sql);
        if (value!=null&&!"".equals(value))
          q.setParameter("search", "%"+((String)value).toLowerCase()+"%");
        return q.setMaxResults(25).getResultList();
    }
    
    protected String getWhereClause() {
        String resultWhereClause="true=true";

        // Просрочено от дедлайна на количество дней более
        if (testValue(this.getSearchParameters().get("daysAfterDeadline"))){
            Integer daysAfterDeadline = 0;
            try {
            	daysAfterDeadline = (Integer)this.getSearchParameters().get("daysAfterDeadline");
            } catch (Exception e){
            	log.error("Ошибка приведения параметра daysAfterDeadline к типу Integer", e);
            }
            resultWhereClause += " AND dateadd("+ daysAfterDeadline +", day, p.planDate) < coalesce(p.completedDate, current_date)";
        }
        // Орг. единицы
        if (this.testValue(this.getSearchParameters().get("owner")))
            resultWhereClause += " AND p.owner = #{" + this.getComponentName() + ".searchParameters['owner']}";

        // Номер дела
        if (this.testValue(this.getSearchParameters().get("packNum")))
            resultWhereClause += " AND p.packNum like #{utils.concat(\"%\", \"" + this.getSearchParameters().get("packNum") + "\", \"%\")}";

        // Выбор услуги
        if (this.testValue(this.getSearchParameters().get("serviceId")))
            resultWhereClause += " AND p.serviceId = #{" + this.getComponentName() + ".searchParameters['serviceId']}";
        
        // Выбор цели услуги
        if (this.testValue(this.getSearchParameters().get("docTypeId")))
        	resultWhereClause += " AND p.goalCode = #{" + this.getComponentName() + ".searchParameters['docTypeId']}";
        
        // Ведомство, ответственное за оказание услуги
        if (this.testValue(this.getSearchParameters().get("gosOrgId"))) {
          CardElement gosOrg = entityManager.find(CardElement.class, searchParameters.get("gosOrgId"));
          resultWhereClause += " AND exists (SELECT dm FROM GossrvcServiceDocTree dm join dm.ogvs o WHERE p.goalID=dm.id and o.id in("
              + getDescendantCEIdsStr(gosOrg) + "))";
        }
        // Код авторизации
        if (this.testValue(this.getSearchParameters().get("authCode")))
            resultWhereClause += " AND p.authCode like #{utils.concat(\"%\", \"" + this.getSearchParameters().get(
                "authCode") + "\", \"%\")}";
        
        // Шаг, на котором находится услуга
        if (this.testValue(this.getSearchParameters().get("step"))){
          List<String> l=(List<String>)entityManager.createQuery("SELECT dm.actId "+
              "FROM XpdlObjectName dm WHERE dm.actName=:name "+
              "group by dm.actId")
              .setParameter("name", list.get(((Number)searchParameters.get("step")).intValue()))
              .getResultList();
          String st="";
          for(String i:l){
            if (!"".equals(st))st+=",";
            st+="'"+i+"'";
          };
            
            resultWhereClause += " AND EXISTS(SELECT as1.oid FROM AssignmentEntity as1"+
          " WHERE as1.packId=p.id"+
          " AND as1.activityDefinitionId in ("+st+"))";
        }
        // Регистратор 
        if (this.testValue(this.getSearchParameters().get("registrator")))
          resultWhereClause += " AND EXISTS(SELECT us FROM User us"+
        " WHERE us.id = p.registrator AND us.id = '" + this.getSearchParameters().get("registrator") + "' )";

        // Контролер
        if (this.testValue(this.getSearchParameters().get("controller")))
            resultWhereClause += " AND EXISTS(SELECT us FROM User us, Kontroller k"+
                    " WHERE k.user = us AND us.id = " + this.getSearchParameters().get("controller")+
                    " AND k.gossrvcDocPackage = p " + " )";
        
        //  Дата создания дела
        if (this.testValue(this.getSearchParameters().get("beginDate")) && testValue(this.getSearchParameters().get("endDate")))
            resultWhereClause += " AND p.packDate between #{" + this.getComponentName() + ".searchParameters['beginDate']} and "+
            "#{"+this.getComponentName()+".upDate(" + this.getComponentName() + ".searchParameters['endDate'])}";

        if (this.testValue(this.getSearchParameters().get("beginDate")) && !this.testValue(this.getSearchParameters().get("endDate")))
            resultWhereClause += " AND p.packDate >= #{" + this.getComponentName() + ".searchParameters['beginDate']}";

        if (!this.testValue(this.getSearchParameters().get("beginDate")) && this.testValue(this.getSearchParameters().get("endDate")))
            resultWhereClause += " AND p.packDate <= "+
                "#{"+this.getComponentName()+".upDate(" + this.getComponentName() + ".searchParameters['endDate'])}";

        // Дата окончания (completedDate)
        if (this.testValue(this.getSearchParameters().get("beginDateComp")) && testValue(this.getSearchParameters().get("endDateComp")))
            resultWhereClause += " AND p.completedDate between #{" + this.getComponentName() + ".searchParameters['beginDateComp']} and "+
                    "#{"+this.getComponentName()+".upDate(" + this.getComponentName() + ".searchParameters['endDateComp'])}";

        if (this.testValue(this.getSearchParameters().get("beginDateComp")) && !this.testValue(this.getSearchParameters().get("endDateComp")))
            resultWhereClause += " AND p.completedDate >= #{" + this.getComponentName() + ".searchParameters['beginDateComp']}";

        if (!this.testValue(this.getSearchParameters().get("beginDateComp")) && this.testValue(
            this.getSearchParameters().get("endDateComp")))
            resultWhereClause += " AND p.completedDate <= "+
                    "#{"+this.getComponentName()+".upDate(" + this.getComponentName() + ".searchParameters['endDateComp'])}";

        // Плановая дата оказания услуги
        if (this.testValue(this.getSearchParameters().get("planDateBegin")) && testValue(this.getSearchParameters().get("planDateEnd")))
            resultWhereClause += " AND p.planDate between #{" + this.getComponentName() + ".searchParameters['planDateBegin']} and "+
                    "#{"+this.getComponentName()+".upDate(" + this.getComponentName() + ".searchParameters['planDateEnd'])}";

        if (this.testValue(this.getSearchParameters().get("planDateBegin")) && !this.testValue(this.getSearchParameters().get("planDateEnd")))
            resultWhereClause += " AND p.planDate >= #{" + this.getComponentName() + ".searchParameters['planDateBegin']}";

        if (!this.testValue(this.getSearchParameters().get("planDateBegin")) && this.testValue(
                this.getSearchParameters().get("planDateEnd")))
            resultWhereClause += " AND p.planDate <= "+
                    "#{"+this.getComponentName()+".upDate(" + this.getComponentName() + ".searchParameters['planDateEnd'])}";

        // поиск по ИНН
        if (this.testValue(this.getSearchParameters().get("inn"))) {
            resultWhereClause += " AND ((EXISTS (SELECT g FROM ObjectGroup g join g.items i, Person per WHERE g=p.applicantGroup"
                    + " AND i.objectClass = 'org.cp.model.common.Person' AND i.objectId=per.id " 
                    + " AND per.inn like '%" + ((String) this.getSearchParameters().get("inn")) + "%'))  "
                    + " OR (EXISTS (SELECT g FROM ObjectGroup g join g.items i, Agent ag WHERE g=p.applicantGroup"
                    + " AND i.objectClass = 'org.cp.lodent.Agent' AND i.objectId=ag.id "
                    + " AND ag.inn like '%" + ((String) this.getSearchParameters().get("inn")) + "%'))) ";
        }

        boolean testPack=this.getSearchParameters().get("showTestPack")!=null&&
        	"true".equals(this.getSearchParameters().get("showTestPack").toString());
        // Заявитель 
        if (this.testValue(this.getSearchParameters().get("applicantClass"))) {
            if (this.testValue(this.getSearchParameters().get("applicant")) && this.getSearchParameters().get("applicantClass").equals("org.cp.model.common.Person"))
                resultWhereClause += " AND EXISTS (SELECT g FROM ObjectGroup g join g.items i, Person per WHERE g=p.applicantGroup" +
                " AND i.objectClass = 'org.cp.model.common.Person' AND i.objectId=per.id"+
                " AND lower(concat(per.lastName,' ',per.firstName,' ',per.middleName)) like #{utils.concat(\"%\", \"" + ((String) this.getSearchParameters().get("applicant")).toLowerCase() + "\", \"%\")}) ";

            if (this.testValue(this.getSearchParameters().get("applicant")) && this.getSearchParameters().get("applicantClass").equals("org.cp.lodent.Agent"))
                resultWhereClause += " AND EXISTS (SELECT g FROM ObjectGroup g join g.items i, Agent ag WHERE g=p.applicantGroup" +
                " AND i.objectClass = 'org.cp.lodent.Agent' AND i.objectId=ag.id"+
                " AND lower(ag.name) like #{utils.concat(\"%\", \"" + ((String) this.getSearchParameters().get("applicant")).toLowerCase() + "\", \"%\")}) ";

            if (this.getSearchParameters().get("applicantClass").equals("org.cp.model.common.Person") && this.testValue(this.getSearchParameters().get("snils"))){
              String snils = this.getSearchParameters().get("snils").toString();
              int findIndexMask = snils.indexOf("_");
              if (findIndexMask >= 0){
                snils = snils.substring(0, findIndexMask);
              }
              if (!snils.isEmpty()){
                resultWhereClause += " AND EXISTS (SELECT g FROM ObjectGroup g join g.items i, Person per WHERE g=p.applicantGroup" +
                          " AND i.objectClass = 'org.cp.model.common.Person' AND i.objectId=per.id"+
                          " AND per.snils like '%" + snils + "%')";
              }
            }
        }
        //по умолчанию не отображаем пакеты, заявители в которых тестовые
        if (!testPack)
        	resultWhereClause += " AND (p.testPackage=false or p.testPackage is null)" ;
        // Пользователь, имеющий задание по делу
        if (this.testValue(this.getSearchParameters().get("workingUser")))
            resultWhereClause += " AND a.packId = p.id "+
            "AND a.resourceUsername = '" + ((String) this.getSearchParameters().get("workingUser")) + "'";

        String docPackagesState = this.getSearchParameters().get("docPackagesState") == null ? "All" : this.getSearchParameters().get("docPackagesState").toString();

        if ( docPackagesState.equals("Opened") ){
            resultWhereClause += " AND exists (select 1 from ProcessEntity pe where pe.id = p.procInstId and pe.state not like 'closed.%' )";
        } else if ( docPackagesState.equals("Closed") ) {
            resultWhereClause += " AND not exists (select 1 from ProcessEntity pe where pe.id = p.procInstId and pe.state not like 'closed.%' )";
        }

        if (this.typeStatus != null){
            resultWhereClause += " AND p.packArmStatus = #{"+this.getComponentName() + ".typeStatus}";
        }

        //Источник услуги
        if (testValue(this.getSearchParameters().get("extSystem"))){
        	resultWhereClause += " AND COALESCE(p.externalSystem, 0)="+this.getSearchParameters().get("extSystem");
        }

      if (testValue(this.getSearchParameters().get("addAttr")) || testValue(this.getSearchParameters().get("begDateAddAttr"))
          || testValue(this.getSearchParameters().get("endDateAddAttr")) || testValue(this.getSearchParameters().get("addAttrName"))) {

        resultWhereClause += " and exists (select gdpav from p.attrVals gdpav where true = true";
        String addAttrVal = (String) this.getSearchParameters().get("addAttr");
        if (addAttrVal != null){
          addAttrVal = addAttrVal.trim();
        }
        String attrType = (String) this.getSearchParameters().get("addAttrType");
        String attrName = (String) this.getSearchParameters().get("addAttrName");
        if (Util.isNotEmpty(attrType)){
          String baseClause = Util.isNotEmpty(attrName)? " AND gdpav.attr.id='" + attrName + "'" : "";
          if (Util.isEmpty(addAttrVal) && !testValue(this.getSearchParameters().get("begDateAddAttr")) && !testValue(this.getSearchParameters().get("endDateAddAttr"))){
            resultWhereClause += baseClause;
          } else {
            switch (attrType) {
              case "tboolean":
                resultWhereClause += baseClause + " and gdpav.booleanValue=" + addAttrVal;
                break;
              case "tdate":
                if (this.testValue(this.getSearchParameters().get("begDateAddAttr")) && testValue(this.getSearchParameters().get("endDateAddAttr")))
                  resultWhereClause += baseClause + " AND gdpav.dateValue between #{" + this.getComponentName() + ".searchParameters['begDateAddAttr']} and " +
                                       "#{" + this.getComponentName() + ".upDate(" + this.getComponentName() + ".searchParameters['endDateAddAttr'])}";

                if (this.testValue(this.getSearchParameters().get("begDateAddAttr")) && !this.testValue(this.getSearchParameters().get("endDateAddAttr")))
                  resultWhereClause += baseClause + " AND gdpav.dateValue >= #{" + this.getComponentName() + ".searchParameters['begDateAddAttr']}";

                if (!this.testValue(this.getSearchParameters().get("begDateAddAttr")) && this.testValue(this.getSearchParameters().get("endDateAddAttr")))
                  resultWhereClause +=
                      baseClause + " AND gdpav.dateValue <= #{" + this.getComponentName() + ".upDate(" + this.getComponentName() + ".searchParameters['endDateAddAttr'])}";
                break;
              case "dictionary":
                if (baseClause.length() > 1) {
                  resultWhereClause += baseClause + " and (gdpav.stringValue='" + addAttrVal + "' and gdpav.attr.id=" + attrName + ")";
                }
                break;
              default:
                break;
            }
          }
        } else{
          //Пробуем определить тип доп. атрибута для поиска через regExp
          //Для Boolean
          if ("да".equalsIgnoreCase(addAttrVal)) {
            resultWhereClause += " AND (gdpav.booleanValue=true or lower(gdpav.stringValue) like '%" + addAttrVal.toLowerCase() + "%') ";
          } else if ("нет".equalsIgnoreCase(addAttrVal)) {
            resultWhereClause += " AND (gdpav.booleanValue=false or lower(gdpav.stringValue) like '%" + addAttrVal.toLowerCase() + "%') ";
          } else if (addAttrVal.matches("\\d+$")) { //Проверка, является ли доп. атрибут целым числом
            resultWhereClause += " AND (gdpav.longValue=" + addAttrVal + " or gdpav.stringValue like '%" + addAttrVal + "%') ";
          } else if (addAttrVal.matches("[-+]?(\\d*[.])?\\d+")) { //Проверка, является ли доп. атрибут вещественным числом
            resultWhereClause += " AND (gdpav.doubleValue=" + addAttrVal + " or gdpav.stringValue like '%" + addAttrVal + "%') ";
          } else if (getRussianDate(addAttrVal) != null) {
            searchParameters.put("addAttrRussianDate", getRussianDate(addAttrVal));
            resultWhereClause += " AND (gdpav.dateValue=#{" + this.getComponentName() + ".searchParameters['addAttrRussianDate']} or gdpav.stringValue like '%" + addAttrVal + "%') ";
          } else { //Поиск по строковому значению (в большинстве случаев)
            resultWhereClause += " AND ( lower(gdpav.stringValue) like '%" + addAttrVal.toLowerCase() + "%') ";
          }
        }
        resultWhereClause += ")";
      }

        //Характеристика результата
        if (currCharacteristic!=null){
        	resultWhereClause += " AND p.characterRes="+this.getCurrCharacteristic();
        }

        if (this.getSearchParameters().get("typeDelo") != null && this.getSearchParameters().get("typeDelo").equals("1")) {
            resultWhereClause += " AND (p.cardRating = false or p.cardRating is null) ";
        }

        if (this.getSearchParameters().get("typeDelo") != null && this.getSearchParameters().get("typeDelo").equals("2")) {
            resultWhereClause += " AND p.cardRating = true ";
        }

        return resultWhereClause;
    }

    @Override
    protected String getCountEjbql() {
        String resultQueryString = "SELECT Count(p) FROM " + this.getFromClause() + " WHERE " + this.getWhereClause();
        return resultQueryString;
    }

    protected String buildEjbUnfilteredql() {
        return "SELECT distinct p FROM " + this.getFromClause() + " WHERE " + this.getWhereClause();
    }

    protected String buildEjbqlForTerminatedList() {
      return "SELECT distinct p FROM " + this.getFromClause() + " WHERE " + this.getWhereClause() +
             " AND exists (select 1 from ProcessEntity pe where pe.id = p.procInstId and pe.state not like 'closed.%' ) "
             + "AND not exists (select docDel.id from DocPackageForDelete docDel where docDel.complectDoc.id = p.id)";
    }

    @Override
    public Integer getMaxResults() {
      return maxResults;
    }
    
    @Override
	public void refreshNavigation()	{
        resultList = null;      
        super.refreshNavigation();
	}

	@Override
	public String getListViewId() {
		// TODO Auto-generated method stub
		return "/gossrvc/gossrvcDocPackageList.xhtml";
	}

	private static final long serialVersionUID = 1L;

	public GossrvcDocPackageList() {
	    this.setOrder("p.packDate DESC");
	    this.setShowResult(false);
	    this.resultList = new ArrayList<GossrvcDocPackage>();
	}
	
	public String getElementName(String elementId) {
		if (elementId == null || elementId.isEmpty())
			return "";

		List<CardElement> ces = this.getEntityManager().createQuery("from CardElement where id = :id")
		    .setHint("org.hibernate.cacheable",true)		    
		    .setParameter("id", elementId).getResultList();
		
		return ces.size() > 0 ? ces.get(0).getName() : "Элемент не найден";
	}
	
	public List<javax.faces.model.SelectItem> getElements(String card) {
		List<javax.faces.model.SelectItem> result = new LinkedList<javax.faces.model.SelectItem>();
		javax.faces.model.SelectItem itm = new javax.faces.model.SelectItem();
		itm.setValue("");
		itm.setLabel("[не выбрано]");
		result.add(itm);
		this.getEntityManager().joinTransaction();
		List<CardElement> lst = this.getEntityManager().createQuery(
				"select a from CardElement a where a.card.cardCode = :cardCode order by a.name ").setParameter("cardCode", card).getResultList();
		for (CardElement t : lst) {
			itm = new javax.faces.model.SelectItem();
			itm.setValue(t.getId());
			itm.setLabel(t.getName());
			result.add(itm);
		}
		return result;
	}
	
	public List<SelectItem> getApplicantClassList() {
		List<SelectItem> result = new ArrayList<SelectItem>();
		result.add(new SelectItem(Person.class.getName(), "Физическое лицо"));
		result.add(new SelectItem(Agent.class.getName(), "Юридическое лицо"));
		return result;
	}

	public String getWorkingUsers(Long packId) {
		
		String result = "";
		
		String s = "select distinct a.resourceUsername from AssignmentEntity a " +
				   "where a.packId = :packId";
		List<String> list = this.getEntityManager().createQuery(s).setParameter("packId",
                                                                                        packId).getResultList();

		for (String login : list)
		{
			s = "select concat(u.lastName, ' ', u.firstName) from User u where u.login = :login"; 
			List<String> usersName = (List<String>) this.getEntityManager().createQuery(s).setParameter("login", login).getResultList();
			
			for (String name : usersName)
			{
				result+=name+", ";
			}
		}
		
		if (!"".equals(result)) result=result.substring(0, result.length()-2);
		return result;
	}
	
	// Получаем регистратора по id пакета
	public String getRegistrator(Long packId){
	  String result = "";
	  String s = "SELECT concat(u.lastName, ' ', u.firstName) FROM User u, GossrvcDocPackage p "+
               "WHERE u.id = p.registrator and p.id = :packId";
	  List <String> registrator = this.getEntityManager().createQuery(s).setParameter("packId", packId).getResultList(); 
	  for (String req : registrator){
	    result+= req+", ";
	  }
	  if (!"".equals(result)) result=result.substring(0, result.length()-2);
	  return result; 
	}
	
 //Получаем контроллера по id пакета
  public String getKontroller(Long packId){
    String result = "";
      String s = "select CONCAT(coalesce(u.lastName,''),' ',coalesce(u.firstName,''),' ',coalesce(u.middleName,'')) " +
               "from Kontroller k, User u "+
               "where k.user = u and k.gossrvcDocPackage.id = :packId";
    List <String> kontroller = this.getEntityManager().createQuery(s).setParameter("packId", packId).getResultList(); 
    for (String req : kontroller){
      result+= req+", ";
    }
    if (!"".equals(result)) result=result.substring(0, result.length()-2);
    return result; 
  }



    public String getStep(Long packId) {
        String sqlActivity = "select distinct o.actName from AssignmentEntity ase, XpdlObjectName o " +
                "where ase.packId = :packId and ase.processMgrName=o.processMgrName and ase.activityDefinitionId=o.actId";
        StringBuilder builder = new StringBuilder();
        List<String> activityList = getEntityManager().createQuery(sqlActivity)
                .setParameter("packId", packId)
                .getResultList();
        for (String el : activityList) {
            if (builder.length() > 0) {
                builder.append(", ");
            }
            builder.append(el);
        }
        if (activityList.isEmpty()) return "не определен";
        return builder.toString();
    }

    public List<Object[]> getActivities(Long packId) {
      if (packId==0){
        return null;
      }
      String cacheId = String.format("%s.%s", packId.toString(), "activity");
      if (!getCacheMap().containsKey(cacheId)) {
          String sql = "SELECT ase.activityId, o.actName FROM AssignmentEntity ase, XpdlObjectName o"+
                  " WHERE ase.packId=:packId"+
                  " AND ase.processMgrName=o.processMgrName and ase.activityDefinitionId=o.actId"+
                  " group by ase.activityId, o.actName";
          List <ActivityEntity> activities = this.getEntityManager()
                  .createQuery(sql)
                  .setParameter("packId", packId)
                  .getResultList();
          getCacheMap().put(cacheId, activities);
      }
      return (List<Object[]>) getCacheMap().get(cacheId);
    }
    
    public String getUsersOnActivity(String activityId) {
        String cacheId = String.format("%s.%s", activityId, "users");
        if (!getCacheMap().containsKey(cacheId)) {
            List<String> logins = getLoginsOnActivity(activityId);
            String result = null;
            String sql = "select concat(u.lastName, ' ', u.firstName) from User u where u.login = :login";
            for (String login : logins) {
                List<String> usernames = this.getEntityManager()
                        .createQuery(sql)
                        .setHint("org.hibernate.cacheable",true)
                        .setParameter("login", login)
                        .getResultList();
                for (String el : usernames) {
                    if (result == null) {
                        result = el;
                    } else {
                        result += ", " + el;
                    }
                }
            }
            getCacheMap().put(cacheId, result);
        }
        return (String) getCacheMap().get(cacheId);
    }

    public List<String> getLoginsOnActivity(String activityId) {
        String cacheId = String.format("%s.%s", activityId, "logins");
        if (!getCacheMap().containsKey(cacheId)) {
            String sql = "select distinct ae.resourceUsername from AssignmentEntity ae " +
                    "where ae.activityId = :activityId";
            getCacheMap().put(cacheId,
                    this.getEntityManager()
                            .createQuery(sql)
                            .setParameter("activityId", activityId)
                            .getResultList()
            );
        }
        return (List<String>) getCacheMap().get(cacheId);
    }

    public Long getDeadline(String activityId) {
        String cacheId = String.format("%s.%s", activityId, "deadline");
        if (!getCacheMap().containsKey(cacheId)) {
            String sql = "select de.timeLimit from DeadlineEntity de " +
                    "where de.activityId = :activityId";
            List<Long> limits = this.getEntityManager()
                    .createQuery(sql)
                    .setParameter("activityId", activityId)
                    .getResultList();
            if (!limits.isEmpty()) {
                getCacheMap().put(cacheId, limits.get(0));
            } else {
                getCacheMap().put(cacheId, null);
            }
        }
        return (Long) getCacheMap().get(cacheId);
    }

    public Boolean isActivityOnMe(String activityId) {
        if (activityId!=null){                                  //#13659 Иначе появляется ошибка при выборе услуги
            return getLoginsOnActivity(activityId)
                .contains(userPrefs.getUserCode());
        }
        return null;
    }

    public String getServiceResult(Long packId) {
        String sqlProcessResult = "select items from GossrvcDocPackageItem items join items.gossrvcDocPackage pack " +
                "where pack.id = :packId and items.isResult = true " +
                "and (items.docValue = true or lower(items.gosOrgan) = 'applicant')";
        StringBuilder builder = new StringBuilder();
        List<GossrvcDocPackageItem> processResultList = getEntityManager().createQuery(sqlProcessResult).
                setParameter("packId", packId).
                getResultList();
        for (GossrvcDocPackageItem el : processResultList) {
            if (builder.length() > 0) {
                builder.append(", ");
            }
            builder.append(el.getTitle());
        }
        return builder.toString();
    }
	
	// получаем список ОГВ с незавершенными запросами
	public String getOgvList(Long packId){
	  String result = "";
	  String s = "select el "+
	             "from GossrvcRequest r, CardElement el "+
	             "where r.gossrvcDocPackage.id = :packId and r.ogvId = el.id and r.factDateReqEnd is null";
	  try{
	    List <CardElement> ogvList = (List <CardElement>)this.getEntityManager().createQuery(s).setParameter("packId", packId).getResultList(); 	
	    int count = 1;
	    for (CardElement ogv : ogvList){
	      result+= count+") "+ogv.getName()+"\r\n";
	      count++;
	    }
	  }
	  catch (NoResultException e) {
      e.printStackTrace();           
    }
	  
	  return result;
	}
	
	//Получаем заявителя по id пакета
	public String getApplicant(Long packId){
      String result = "";
      
      GossrvcDocPackage p = this.getEntityManager().find(GossrvcDocPackage.class, packId); 
      ObjectGroup applicant_pack = p.getApplicantGroup();
      if (applicant_pack == null || applicant_pack.getItems() == null){
          return "";
      }
      List <ObjectGroupItem> za = applicant_pack.getItems();
      for (ObjectGroupItem r: za){
        if (!"".equals(result)) result+=",";
        if (r.getObject() instanceof Person){
          Person per = (Person)r.getObject();
          result+= per.getLastName()+" "+per.getFirstName();
        }else if (r.getObject() instanceof Agent)
          result+= ((Agent)r.getObject()).getName();
        else
          result+= r.getObject();
      }
         
      return result;
	}
	
	protected boolean testValue(Object val){
		if (val==null)
			return false;
		if (!(val instanceof java.lang.String))
			return true;
		return !"".equals(val);
	}

    @Override
    public List<GossrvcDocPackage> getResultList() {
        getDataScroll();
        if (resultList == null) {
            String newEjbUnfilteredql = this.buildEjbUnfilteredql();
            // Плохая, неочевидная логика.
            // Родительский getEjbUnfilteredql() возвращает ejbql, объявленный в org.jboss.seam.framework.Query.
            // Если запрос изменился (из-за изменения состава поисковых параметров),
            // сбрасываем все настройки, вызывая setEjbql().
            // Тем же самым запоминаем запрос для дальнейшего сравнения.
            if (!newEjbUnfilteredql.equals(this.getEjbUnfilteredql())) {
                this.setEjbql(newEjbUnfilteredql);
                setCacheMap(null); // Магия. Не трогать!
            }
            
            maxResults=dataScroll.getSmall() ? 26 : 25;
            resultList = super.getResultList();
            maxResults=25;
            dataScroll.truncList(resultList);            
            //Заполним оргюниты
            this.getOrgUnits().clear();
            Set<String> owners=new HashSet<String>();
            for(GossrvcDocPackage i:resultList){
              if (!Util.isEmpty(i.getOwner()))
                owners.add(i.getOwner());
            }
            if (owners.size()!=0){
              Query q=this.getEntityManager().createQuery("SELECT dm FROM OrgUnit dm WHERE dm.owner IN (:owners)")
                  .setParameter("owners", owners);
              for(OrgUnit u:(List<OrgUnit>)q.getResultList()){
                this.getOrgUnits().put(u.getOwner(), u);
              }
            }
        }
        return resultList;
    }

    List listOrgUnit;
	
	public List getListOrgUnit(){
		if (listOrgUnit==null)
			listOrgUnit=HierUtils.createListOrgUnit(getEntityManager());
		return listOrgUnit;
	}

    // Не переопределять refresh()
    // Он вызывается в setEjbql()
    public void doRefresh() {
        validateAddAttributesBlock();
        resultList = null;
        this.setFirstResult(0);        
        this.setShowResult(true);
    }

    public void reset() {
      resultList = null;
      searchParameters = null;
      this.setShowResult(false);
    }
    
    public void refreshArm(){
    	this.getEntityManager().clear();
        doRefresh();
    }

    @Override
    public void validate() {
        if (this.getEjbUnfilteredql() == null)
            this.setEjbql(this.buildEjbUnfilteredql());
        super.validate();
    }
    
    public TypeStatus[] getListTypeStatus(){
    	return GossrvcDocPackage.getElementTypeStatus();
    }
    @Override

    public List getSuggestion(Object search, String filter, Object filterData, Integer maxResults, String orderBy) throws IOException {

         // Сбрасываем параметры поиска, т.к. при автокомплите фильтрация настраивается через свойство filter
        this.getSearchParameters().clear();
        this.getSearchParameters().put("docPackagesState", "All");

        return super.getSuggestion(search, filter, filterData, maxResults, orderBy);
    }
    
    public List<SelectItem> getExtSystemSelectList() {
		String sql = "select exS.name, exS.code from ExternalSystem exS ";
		List listSystem = entityManager.createQuery(sql).getResultList();
		List<SelectItem> result = new ArrayList<SelectItem>();
		for (int i = 0; i < listSystem.size(); i++) {
			Object[] syst = (Object[]) listSystem.get(i);
			SelectItem sSys = new SelectItem(syst[1], syst[0].toString());
			result.add(sSys);
		}
		result.add(new SelectItem(0, "Личные обращения"));
		result.add(new SelectItem(null, "[не выбрано]"));
		Collections.sort(result, new Comparator<SelectItem>() {
			public int compare(SelectItem o1, SelectItem o2) {
				/*if (o1 == null || o2 == null) {
					return 0;
				}*/
				if (o1.getValue() != null && o2.getValue() == null) {
					return 1;
				}
				if (o1.getValue() == null && o2.getValue() != null) {
					return -1;
				}
				if (o1.getValue() == null && o2.getValue() == null) {
					return 0;
				}
				return (Integer) o1.getValue() - (Integer) o2.getValue();
			}
		});
		return result;
	}

    public ProcessController getProcessController() {
        if (processController == null) {
            processController = (ProcessController) Component.getInstance("processController");
        }
        return processController;
    }

    public void setProcessController(ProcessController processController) {
        this.processController = processController;
    }

    public Map<Long, Boolean> getChecked() {
        if (checked == null) {
            checked = new HashMap<Long, Boolean>();
        }
        return checked;
    }

    public void setChecked(Map<Long, Boolean> checked) {
        this.checked = checked;
    }

    public boolean isExtendedMode() {
        return extendedMode;
    }

    public void setExtendedMode(boolean extendedMode) {
        this.extendedMode = extendedMode;
    }

    private WMProcessInstance proc;
    
    public WMProcessInstance getProcById(String procInstId) throws Exception {
      WMProcessInstance proc = getRootProcess(sharkSession.getWapi().getProcessInstance(
            sharkSession.getSessionHandle(), procInstId));
        return proc;
    }
    
    private WMProcessInstance getRootProcess(WMProcessInstance processInstance) {
		WMProcessInstance parent = getParentProcess(processInstance);
		if (parent != null)
			return getRootProcess(parent);
		else
			return processInstance;
	}
    
    public WMProcessInstance getParentProcess(WMProcessInstance processInstance) {
		WMProcessInstance result = null;
		try {
			ProcessFilterBuilder builder = SharkInterfaceWrapper.getShark()
					.getProcessFilterBuilder();
			WMSessionHandle shandle = sharkSession.getSessionHandle();

			WMFilter filter = builder.addIdEquals(shandle, processInstance
					.getId());
			filter
					.setSQLWhereExpression("[ProcessEntity].id = (select max(subProcess.activityRequestersProcessId)  from ProcessEntity subProcess where subProcess.id = :id )");
			WMProcessInstance[] processes = sharkSession.getWapi()
					.listProcessInstances(shandle, filter, true).getArray();
			if (processes.length > 0)
				result = processes[0];
		} catch (Exception e) {
			log.error("", e);
		}
		return result;
	}
    
    @Restrict(value = "#{s:hasPermission('Пакеты документов','Групповое удаление пакетов документов')}")
    public void terminateCheckedProcess() {
    	String auditMessage = " Пользователь нажал кнопку 'Завершить аварийно' в Групповом завершении";
    	
        
        String packNum = "n/a";
		List<ProcessVariable> varses = null;
		
		
        for (Map.Entry<Long, Boolean> map: checked.entrySet()){
            if (map.getValue()){
                try{
                	String procId = String.valueOf(map.getKey());
                	getProcessController().terminateProcess(procId);
                	proc = getProcById(procId);
            		varses = MiscXpdlUtilities.getProcInstVariables(sharkSession.getSessionHandle(), sharkSession.getWapi(), proc.getId());
            		if(varses!=null){
        				for (ProcessVariable v : varses) {
        		            if (v.getId().equals("Komplekt_doc")) {
                                        GossrvcDocPackage pack = (GossrvcDocPackage) entityManager
                                            .find(GossrvcDocPackage.class, v.getValue());
                                      pack.setCompletedDate(new Date());
                                      packNum = v.getCaption();
        		                auditMessage = "(КД: "+packNum+") " + auditMessage;
                                      //необходимо удалить записи по делу из таблицы Kontroller и из моих задач, если есть записи
                                      if (pack!=null){
                                        String kontrollersStr = "SELECT k " +
                                                                "FROM Kontroller k " +
                                                                "WHERE gossrvcDocPackage = :pack";
                                        List <Kontroller> kontrollers = this.getEntityManager().createQuery(kontrollersStr).setParameter("pack", pack).getResultList();
                                        if (kontrollers.size()>0)
                                          for(Kontroller k : kontrollers){
                                            pack.setServiceProvidingController(null);
                                            entityManager.remove(k);
                                          }

                                        String bpmsAssign = "SELECT a FROM AssignmentEntity a WHERE a.packId=:packId";
                                        List <AssignmentEntity> assignments = this.getEntityManager().createQuery(bpmsAssign).setParameter("packId", pack.getId()).getResultList();
                                        if (assignments.size()>0)
                                          for(AssignmentEntity a : assignments){
                                            entityManager.remove(a);
                                          }
                                      }
                                        }
        				}
        			}
                } catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        if (getAuditManager() != null) {
			getAuditManager().logAuditMessage(AuditEvent.BUSINESS_PROCESS_STEP_EXECUTE,
					AuditEvent.OK, auditMessage);
		}
        checked.clear();
        doRefresh();
    }
    
    
    public WMProcessInstance getProcessInstanceById(String procId) {
      String cacheId = String.format("%s.%s", procId, "processInstance");
        if (!getCacheMap().containsKey(cacheId)) {
            WMProcessInstance processInstance = null;
            try {
                processInstance = getProcessController().getProcById(procId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            getCacheMap().put(cacheId, processInstance);
        }
        return (WMProcessInstance) getCacheMap().get(cacheId);
    }

  public void terminateAll() {
    String ejbql = buildEjbqlForTerminatedList();
    List<GossrvcDocPackage> listToTerminate = entityManager.createQuery(ejbql).getResultList();
    List<DocPackageForDelete> docPackageForDeletes = new ArrayList<DocPackageForDelete>();
    DocPackageForDelete item;
    int count = 0;
    try {
      for (GossrvcDocPackage docPackage : listToTerminate) {
        item = new DocPackageForDelete();
        item.setComplectDoc(docPackage);
        entityManager.persist(item);
//        if (entityManager.createQuery("select docDel from DocPackageForDelete docDel where docDel.complectDoc.id = :id").
//            setParameter("id", docPackage.getId()).getResultList().isEmpty()) {
          //entityManager.persist(item);
          ++count;
          if (count % 30 == 0) {
            entityManager.flush();
          }
//        }
      }
      entityManager.flush();
      FacesMessages.instance().add(StatusMessage.Severity.INFO, "В очередь на удаление дел поставлено: " + count);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

    public WMEntity getProcessDefinition(WMProcessInstance processInstance) {
        String cacheId = String.format("%s.%s", processInstance.getId(), "processDefinition");
        if (!getCacheMap().containsKey(cacheId)) {
            WMEntity wmEntity = null;
            try {
                wmEntity = getProcessController().getProcessDefinition(processInstance);
            } catch (Exception e) {
                e.printStackTrace();
            }
            getCacheMap().put(cacheId, wmEntity);
        }
        return (WMEntity) getCacheMap().get(cacheId);
    }
    
    private IAuditManager getAuditManager() {
		if (auditManager == null) {
			auditManager = (IAuditManager) Component
					.getInstance(AuditManager.class);
		}
		return auditManager;
	}
    
    //Фильтры
    private FilterSettingsDAO filterSettingsDAO;
    private List<FilterSettings> myFilters;
    private String filterName;
    
    public String getFilterName() {
      return filterName;
    }

    public void setFilterName(String filterName) {
      this.filterName = filterName;
    }

    public FilterSettingsDAO getFilterSettingsDAO() {
      if (filterSettingsDAO==null)
        filterSettingsDAO=new FilterSettingsDAOImpl(this.entityManager);
      return filterSettingsDAO;
    }

    public List<FilterSettings> getMyFilters() {
      if (myFilters==null)
        myFilters=getFilterSettingsDAO().findByUserAndSection(getCurrentUser(), RegisterFilterSections.MY_GossrvcDocPackage);
      return myFilters;
    }
    
    public FilterSettings saveFilterSettings(String filterName, String filterSettings) {
      FilterSettings userFilter=null;
      for(FilterSettings i: getMyFilters()){
        if (i.getName().equals(filterName)){
          userFilter=i;
          break;
        }  
      }
      if (userFilter==null){
        userFilter = new FilterSettings();
        userFilter.setUser(getCurrentUser());
        userFilter.setSectionName(RegisterFilterSections.MY_GossrvcDocPackage);
        userFilter.setName(filterName);
      }  
      userFilter.setCreateDate(new Date());
      userFilter.setSettings(filterSettings);
      myFilters=null;
      return getFilterSettingsDAO().saveOrUpdate(userFilter);
    }
    
    public User getCurrentUser() {
      UserDAO userDao = SeamContextUtils.getComponentByName("userDAO", true);
      User currUser = userDao.getCurrentUser();
      return currUser;
    }
    
    public void saveUserFilter(){
      if (Util.isEmpty(filterName))
        return;
      Map<String,Object> filter=new HashMap<String,Object>();
      for(String i:searchParameters.keySet()){
        if (this.testValue(searchParameters.get(i))){
          if (searchParameters.get(i) instanceof String &&
              ((String)searchParameters.get(i)).length()>100){
            String st=(String)searchParameters.get(i);
            filter.put(i, st.substring(0, 100));
          }else
            if(searchParameters.get(i) instanceof Date) {
              Date tempDate = (Date)searchParameters.get(i);
              filter.put(i,sdf.format(tempDate));
            } else {
              filter.put(i, searchParameters.get(i));
            }
        }
      }
      JSONObject obj = new JSONObject();
      obj.putAll(filter);
      saveFilterSettings(filterName, obj.toJSONString());
    }

    public void loadUserFilter(String filterString){
      searchParameters.clear();
      //
      Map<String,Object> filter=new HashMap<String,Object>();
      JSONParser parser = new JSONParser();
      try{
        filter=(Map<String,Object>)parser.parse(filterString);
        for(String i:filter.keySet()){
          try
          {
            Date mbDate = sdf.parse(filter.get(i).toString());
            searchParameters.put(i, mbDate);
          }
          catch (java.text.ParseException e) {
            searchParameters.put(i, filter.get(i));
          }
        }
      }catch(ParseException e){
        System.out.println(e.toString());
      }
      //
      doRefresh();
    }
    
    public void deleteUserFilter(FilterSettings fs){
      getFilterSettingsDAO().remove(fs);
      myFilters=null;
    }

    private Set<String> getDescendantCEIds(CardElement ce){
      Set<String> lst = new HashSet<>();
      lst.add(ce.getId());
      for(CardElement el: ce.getChildsCardElements()){
        if (el.getChildren().size() == 0){
          lst.add(el.getId());
        }
        lst.addAll(getDescendantCEIds(el));
      }
      return lst;
    }

    public List<GossrvcServiceAttr> getAddAttrNames(){
      List<GossrvcServiceAttr> res = new ArrayList<>();
      String addAttrType = (String) searchParameters.get("addAttrType");
      String serviceId = (String) searchParameters.get("serviceId");
      String docTypeId = (String) searchParameters.get("docTypeId");
      if (Util.isEmpty(addAttrType)&&(Util.isEmpty(serviceId)||Util.isEmpty(docTypeId))){
        return res;
      }
      String sql = "select attr from GossrvcServiceAttr attr where attr.parent.docTypeId.id='" + docTypeId + "'";
      String whereClause = "";
      if (addAttrType.equals(GossrvcServiceAttrBase.DataType.tboolean.name())||addAttrType.equals(GossrvcServiceAttrBase.DataType.tdate.name())){
        whereClause = " and attr.dataType='" + addAttrType + "'";
      } else if (addAttrType.equals("dictionary")) {
        whereClause = " and (attr.cardCode is not null or length(attr.restrictList)>1))";
      }
      sql = sql + whereClause;
      res = (List<GossrvcServiceAttr>)getEntityManager().createQuery(sql).getResultList();
      return res;
    }

  public List<SelectItem> getAddAttrVals(String attrId){
    List<SelectItem> res = new ArrayList<>();
    String addAttrType = (String) searchParameters.get("addAttrType");
    switch (addAttrType) {
      case "tboolean":
        res.add(new SelectItem("true", "Да"));
        res.add(new SelectItem("false", "Нет"));
        break;
      default:
        if (Util.isNotEmpty(attrId)) {
          try {
            GossrvcServiceAttr attr = getEntityManager().find(GossrvcServiceAttr.class, Long.parseLong(attrId));
            if (attr != null) {
              if (Util.isNotEmpty(attr.getRestrictList())) {
                return attr.getSelectItems();
              } else if (attr.getCardCode() != null) {
                return attr.getCardElementSelectItems();
              }
            }
          } catch (Exception e) {
            //TODO: подумать, надо ли логгировать это исключение
            e.printStackTrace();
          }
        }
    }
    return res;
  }

  public void clearAddAttrsFilter(){
    searchParameters.remove("addAttrName");
    clearAddAttrValues();
  }

  public void clearAddAttrValues(){
    searchParameters.remove("addAttr");
    searchParameters.remove("begDateAddAttr");
    searchParameters.remove("endDateAddAttr");
  }

  private void  validateAddAttributesBlock() {
    if (!testValue(searchParameters.get("addAttr")) && !testValue(searchParameters.get("begDateAddAttr")) && !testValue(searchParameters.get("endDateAddAttr"))
        && !testValue(searchParameters.get("addAttrName")) && testValue(searchParameters.get("addAttrType"))) {
      FacesMessages.instance().add("Не задано значение и/или наименование дополнительного атрибута для поиска. Значения остальных параметров из блока «Дополнительные атрибуты» не были учтены при поиске.");
    }
  }

  private Date getRussianDate(String dateStr){
    try {
      return rdf.parse(dateStr);
    } catch (java.text.ParseException e) {
      return null;
    }
  }

  private String getDescendantCEIdsStr(CardElement ce){
      return getDescendantCEIds(ce).toString().replace("[","'").replace("]","'").replace(", ","','");
    }

  public static void main(String[] arg0){
    String snils = "__ __";
    int findIndexMask = snils.indexOf("_");
    if (findIndexMask >= 0){
      snils = snils.substring(0, findIndexMask);
    }
    System.out.println(snils);

  }

    private DataScroll dataScroll = null;
    
    @Override
    public DataScroll getDataScroll() {
      if (dataScroll == null) {
        dataScroll = new DataScroll();
        dataScroll.setSmall(true);
        initNavigation();
      }
      return dataScroll;
    }

    @Override
    public Long getResultCount() {
      if (dataScroll.getSmall()){
         List list=getResultList();
         return new Long(list.size());
      }else
        return super.getResultCount();
    }

    public void toSmallMode() {
      dataScroll.setSmall(false);
      doRefresh();
    }

    int maxResults = 25;
}
