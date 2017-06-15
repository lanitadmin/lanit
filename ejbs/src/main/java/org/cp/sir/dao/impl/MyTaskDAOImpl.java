package org.cp.sir.dao.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.apache.commons.beanutils.NestedNullException;
import org.cp.bpms.ProcessDefinitionBean.ProcessIdentityEntity;
import org.cp.bpms.WorkListSearch;
import org.cp.cardsystem.CardElement;
import org.cp.common.ISearchObject;
import org.cp.common.UserTableSettingsBean;
import org.cp.lodent.User;
import org.cp.sharkimpl.persistanse.CsPersistentManager;
import org.cp.sir.dao.MyTaskDAO;
import org.cp.sir.dao.MyTaskSearchCriteria;
import org.cp.sir.dao.filter.MyTaskRestriction;
import org.cp.sir.dao.filter.MyTaskRestrictionFactory;
import org.cp.sir.filter.builder.mytask.MyTaskFilterItemCodes;
import org.cp.sir.model.FilterValue;
import org.jboss.seam.log.Log;
import org.jboss.seam.log.Logging;

public class MyTaskDAOImpl implements MyTaskDAO {

 
  /**
   * Логгер
   */
  private static Log _log = Logging.getLog(MyTaskDAOImpl.class);

  private final EntityManager em;

  private SqlQuery hqlTaskQuery;

  public MyTaskDAOImpl(EntityManager em) {
    this.em = em;
  }

  @Override
public String getProcessId(String activityId) throws Exception {
    Query query = em.createQuery("select processId from ActivityEntity where id = :activityId");
    query.setParameter("activityId", activityId);
    return (String) query.getSingleResult();
  }

  private Query getQuery(String queryString, MyTaskSearchCriteria searchCriteria) throws Exception {
    Query q = em.createQuery(queryString);
    q.setParameter("principal", searchCriteria.getUser());
    for (FilterValue filter : searchCriteria.getFilterValues().values()) {
      MyTaskRestriction restriction = MyTaskRestrictionFactory.create(filter);
      if (restriction != null) {
        restriction.setParams(q);
      }
    }


    return q;
  }

  // TODO: Вынести в ДАО ExternalSystem
  @Override
@SuppressWarnings("unchecked")
  public List<Object[]> getExternalSystem() {
    Query query = em.createNamedQuery("ExternalSystem.getAllNamesAndCodes");
    List<Object[]> retVal = query.getResultList();
    if (retVal == null) {
      retVal = new ArrayList<Object[]>(1);
    }
    return retVal;
  }

  @SuppressWarnings("unchecked")
  @Override
  public List<Object[]> findByCriteria(MyTaskSearchCriteria searchCriteria, UserTableSettingsBean searchInstance,
      int from, int count, boolean clearCache) throws Exception {
    _log.debug("finByCriteria запущен. from: #0, count: #1", from, count);
    
    if (clearCache || hqlTaskQuery == null) {
      hqlTaskQuery = createHqlQuery(searchCriteria);
    }
      
      
    String queryStr = hqlTaskQuery.findQuery();
    _log.debug("findQuery: #0", queryStr);
    Query q = getQuery(queryStr, searchCriteria);
    q.setFirstResult(from);
    q.setMaxResults(count);
    List<Object[]> list = q.getResultList();
    _log.debug("finByCriteria завершен.");
    return list;
  }

  @Override
@SuppressWarnings("unchecked")
  public List<Object[]> getTaskStatusData(String commaSeparatedActIds) throws Exception {
    Query q =
        em.createQuery("SELECT a.id, a.state, a.lastStateTime, o.actName, o.procName FROM ActivityEntity a, XpdlObjectName o WHERE a.id IN ("
            + commaSeparatedActIds + ") and a.processMgrName=o.processMgrName and a.activityDefinitionId=o.actId");

    return q.getResultList();
  }

  @Override
  public long countByCriteria(MyTaskSearchCriteria searchCriteria, UserTableSettingsBean searchInstance,
      boolean clearCache) throws Exception {
    try {
      if (clearCache || hqlTaskQuery == null) {
        hqlTaskQuery = createHqlQuery(searchCriteria);
      }
      String queryStr = hqlTaskQuery.countQuery("assigment");
      _log.debug("countQuery: #0", queryStr);
      Query q = getQuery(queryStr, searchCriteria);
      return (Long) q.getSingleResult();
    } catch (NestedNullException e) {
      _log.error(e.getMessage(), e);
    }

    return 0;
  }


  public String convertProcessIdentityVaribleName(String varibleName) {
    // если параметр начинается с идентификатора, то отбрасываем его.
    if (varibleName.startsWith("proc_ident"))
      varibleName = varibleName.substring("proc_ident".length() + 1/* плюс точка */);
    return varibleName;
  }

  @SuppressWarnings("rawtypes")
  public Class getClassByIdentName(String identName, ProcessIdentityEntity identityEntity) {
    Class cl = null;
    try {
      String entClass = identityEntity.getEntityClass();
      if (identityEntity.getParticipantSource() != null)
        entClass = User.class.getCanonicalName();

      if (entClass != null) {
        if (entClass.indexOf(".") == -1)
          entClass = CardElement.class.getCanonicalName();
        if (entClass.indexOf(".") > 0)
          cl = Class.forName(entClass);
      }
    } catch (ClassNotFoundException e) {
      _log.error(e.getMessage(), e);
    }
    return cl;
  }

  /**
   * 1) В главном запросе ключевые слова SELECT FROM WHERE ORDER BY - большими буквами 2) Во
   * вложенных запросах все мелкими буквами
   * 
   * @throws NoSuchMethodException
   * @throws InvocationTargetException
   * @throws IllegalAccessException
   */
  public SqlQuery createHqlQuery(MyTaskSearchCriteria searchCriteria)
      throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
    _log.debug("createQuery запущен");
    long timestamp = System.currentTimeMillis();
    StringBuilder select = new StringBuilder();
    StringBuilder subWhere = new StringBuilder();
    StringBuilder subFrom = new StringBuilder();
    int pos = 0;
    boolean addPack=false;
    for (String fieldName : searchCriteria.getColumnNames()) {
      String identName = convertProcessIdentityVaribleName(fieldName);
      if (select.length() > 0 && !select.toString().endsWith(", ")) {
        select.append(", ");
      }
      if (fieldName.equals("statusicon")) {
        select.append("'' as statusicon");
      } else if (fieldName.equals("create")) {
        select.append("'' as create");
      } else if (fieldName.equals("started")) {
        select.append("'' as started");
      } else if (fieldName.equals("process")) {
        select.append("'' as process");
      } else if (fieldName.equals("act")) {
        select.append("'' as act");
      } else if (fieldName.equals("status")) {
        select.append("'' as status");
      } else if (fieldName.equals("docPackageComment")) {
          select.append("'' as docPackageComment");
      } else if (fieldName.equals("limit")) {
        select
            .append("(select deadLine.timeLimit from DeadlineEntity deadLine where deadLine.activityId=assigment.activityId) as limit");
      } else if (fieldName.equals("test")) {
        select.append("(select a.testPackage from GossrvcDocPackage a where assigment.packId=a.id) as test");
      } else if (fieldName.startsWith(WorkListSearch.IDENTITY_PRE)&&
            (CsPersistentManager.procIdent.indexOf(","+identName+",")!=-1 || fieldName.endsWith(".Zayavitel")
            ||fieldName.endsWith(".Service")||fieldName.endsWith("senderPackNum")
            ||fieldName.endsWith("lastSendSoap"))) {
          //Спец обработка через комплект док-ов
          if ("senderPackNum".equals(identName))
            // для переменной процесса senderPackNum считать значение переменной из КД
            select.append("(select a.senderPackNum from GossrvcDocPackage a where assigment.packId=a.id) as senderPackNum");
          else if ("Komplekt_doc".equals(identName))
            select
            .append("assigment.packId as " + 
                identName);
          else if ("Service".equals(identName))
            select
            .append("(select p.serviceId from GossrvcDocPackage p where p.id = assigment.packId) as " + 
                identName);
          else if ("Zayavitel".equals(identName))
            select
              .append("(select applicantGroup.id from GossrvcDocPackage p where p.id = assigment.packId) as " + 
                  identName);
          else if ("Kontr_part".equals(identName))
            select.append("assigment.kontrPart as "+identName);
          else if ("Gos_Org".equals(identName))
            select.append("assigment.gosOrg as "+identName);
          else if ("dateServEnd".equals(identName))
            select.append("assigment.dateServEnd as "+identName);
          else if ("Registr_part".equals(identName))
            select.append("assigment.registrPart as "+identName);
          else if ("docsFromOgv".equals(identName))
            select.append("assigment.docsFromOgv as "+identName);
          else if ("docWait".equals(identName))
            select.append("assigment.docWait as "+identName);
          else if ("lastSendSoap".equals(identName))
            select.append("(select s.lastSendSoap from SoapContext s where s.id = assigment.soapContextId) as " + identName);
          else if ("komment".equals(identName))
            select.append("assigment.komment as "+identName);
          Object identValue = searchCriteria.getFilterValueByCode(identName);
          boolean addSqlPack=false;
          if (identValue != null && !"".equals(String.valueOf(identValue))) {
            pos++;
            String alias = "pp" + pos;                      
            if ("senderPackNum".equals(identName)){
              subWhere.append("lower(packNew.senderPackNum) like lower('%" + identValue + "%') and ");
              addSqlPack=true;
            }else if ("Kontr_part".equals(identName)){
              subFrom.append(" User " + alias + ", ");
              subWhere.append(" assigment.kontrPart="+alias+".login and "+
                  "lower("+alias+".lastName ||' '|| "+alias+".firstName ||' '|| "+alias+".middleName) like lower('%"
                      + identValue+ "%') and");
            }else if ("Gos_Org".equals(identName)){
              subWhere.append("assigment.gosOrg = '"+identValue+"' and ");
            }else if ("dateServEnd".equals(identName)){
              subWhere.append("assigment.dateServEnd between :beg_"+identName+" and :end_"+identName+" and ");
            }else if ("Registr_part".equals(identName)){
              subFrom.append(" User " + alias + ", ");
              subWhere.append(" assigment.registrPart="+alias+".login and "+
                  "lower("+alias+".lastName ||' '|| "+alias+".firstName ||' '|| "+alias+".middleName) like lower('%"
                      + identValue+ "%') and");
            }else if ("docWait".equals(identName)){
              subWhere.append("assigment.docWait = '"+identValue+"' and ");
            }else if ("lastSendSoap".equals(identName)){
              subFrom.append("SoapContext sc,");
              subWhere.append("sc.id=assigment.soapContextId and sc.lastSendSoap between :beg_"+identName+" and :end_"+identName+" and ");
            }else if ("komment".equals(identName)){
              subWhere.append("assigment.komment = '"+identValue+"' and ");
            }  
            if (addSqlPack&&!addPack){
                addPack=true;
                subFrom.append("GossrvcDocPackage packNew,");
                subWhere.append("packNew.id=assigment.packId and ");
              }
            }  
      } else if (fieldName.startsWith(WorkListSearch.IDENTITY_PRE)) {
        Object identValue = searchCriteria.getFilterValueByCode(identName);
          ProcessIdentityEntity identityEntity = searchCriteria.getIdentityEntities().get(identName);
          /* StringBuilder subWhereVal = new StringBuilder(); */
          if (identityEntity != null) {
            select.append("(select procIdent.");
            if ("string".equalsIgnoreCase(identityEntity.getVaribleType()))
              select.append("stringValue");
            else if ("integer".equalsIgnoreCase(identityEntity.getVaribleType()))
              select.append("longValue");
            else if ("datetime".equalsIgnoreCase(identityEntity.getVaribleType())
                || "date".equalsIgnoreCase(identityEntity.getVaribleType()))
              select.append("dateValue");
            else {
              // TODO: сделать остальные если понадобяться
              select.append("stringValue");
            }
            select
                .append(
                    " from ProcessVariableEntity procIdent where procIdent.processId = assigment.processId and procIdent.definitionId = '")
                .append(identName).append("') as ").append(identName);

            if (identValue != null && !"".equals(String.valueOf(identValue))) {
              // Если поиск по доп. атрибутам
              pos++;
              String alias = "pp" + pos;
              String field = "";
              StringBuilder subWhereVal = new StringBuilder();
              if ("string".equalsIgnoreCase(identityEntity.getVaribleType()))
                field = "to_char_if_clob(procIdent" + identName + ".stringValue)";
              else if ("integer".equalsIgnoreCase(identityEntity.getVaribleType()))
                field = "procIdent" + identName + ".longValue";
              else if ("datetime".equalsIgnoreCase(identityEntity.getVaribleType())
                  || "date".equalsIgnoreCase(identityEntity.getVaribleType()))
                field = "procIdent" + identName + ".dateValue";
              else
                field = "procIdent" + identName + ".stringValue";
                // Остальные сущности
                Class clazz = getClassByIdentName(identName, identityEntity);
                if (clazz != null) {
                  try {
                    String ss = ((ISearchObject) clazz.newInstance()).getSearchFieldName();
                    if (ss == null) {
                      System.out.println("-----Поле не проаннотировано-----" + ss);
                    } else {
                      if (!identityEntity.getCard())
                        subFrom.append(clazz.getSimpleName()).append(" ").append(alias).append(", ");
                      if ("User".equals(clazz.getSimpleName()))
                        subWhere.append(" ").append(field).append("=").append(alias).append(".login and lower(")
                            .append(alias).append(".").append(ss).append(") like lower('%").append(identValue)
                            .append("%') and ");
                      else {
                        if (identityEntity.getCard()) {
                          String st = (String) identValue;
                          if (st.indexOf("','") == -1)
                            subWhere.append(" ").append(field).append("= '").append(identValue).append("' and ");
                          else
                            subWhere.append(" ").append(field).append(" IN (").append(identValue).append(") and ");
                        } else
                          subWhere.append(" ").append(field).append("=").append(alias).append(".id and lower(")
                              .append(alias).append(".").append(ss).append(") like lower('%").append(identValue)
                              .append("%') and ");
                      }
                    }
                  } catch (Exception e) {
                    _log.error(e.getMessage(), e);
                  }
                } else {
                  if ("string".equalsIgnoreCase(identityEntity.getVaribleType()))
                    subWhereVal.append(" and lower(procIdent").append(identName).append(".stringValue) like lower('%")
                        .append(identValue).append("%')");
                  else if ("integer".equalsIgnoreCase(identityEntity.getVaribleType()))
                    subWhereVal.append(" and procIdent").append(identName).append(".longValue = ").append(identValue)
                        .append(" ");
                  else if ("datetime".equalsIgnoreCase(identityEntity.getVaribleType())
                      || "date".equalsIgnoreCase(identityEntity.getVaribleType())) {
                    subWhereVal.append(" and procIdent").append(identName).append(".dateValue between :beg_")
                        .append(identName).append(" and :end_").append(identName).append(" ");
                  }
                }
              //
              subWhere.append(" procIdent").append(identName).append(".definitionId = '").append(identName)
                  .append("' ").append(subWhereVal).append("  and procIdent").append(identName)
                  .append(".processId = assigment.processId and ");
              subFrom.append("ProcessVariableEntity procIdent").append(identName).append(", ");
            }
          } else
            select.append("'' as ").append(identName);
      } else {
        throw new IllegalArgumentException("Field name '" + fieldName + "' not supported");
      }
    }

    String testZayvitel = searchCriteria.getFilterValueByCode(MyTaskFilterItemCodes.TEST_DOC);
    Boolean showTestZayvitel = (testZayvitel == null) ? true : Boolean.parseBoolean(testZayvitel);
    if (!showTestZayvitel){
      if (!addPack){
        addPack=true;
        subFrom.append("GossrvcDocPackage packNew, ");
        subWhere.append("packNew.id=assigment.packId and ");
      }           
      subWhere.append("packNew.testPackage=false and ");  
    }
    
    List<String> listFrom = new ArrayList<String>();
    List<String> listWhere = new ArrayList<String>();


    subWhere.append("(").append("assigment.resourceUsername = :principal").append(") and ");

    for (FilterValue filter : searchCriteria.getFilterValues().values()) {
      MyTaskRestriction restriction = MyTaskRestrictionFactory.create(filter);
      if (restriction != null) {
        subWhere.append(restriction.getSubWhere());
        String from = restriction.getFrom();
        if (!"".equals(from)) {
          String[] fromArr = from.split(",");
          for (String fromRef : fromArr) {
            if (!listFrom.contains(fromRef)) {
              listFrom.add(fromRef);
            }  
          }
          
        }
        String where = restriction.getWhere();
        if (!"".equals(where) && !listWhere.contains(where)) {
          listWhere.add(where);
        }
        if (restriction.getUseGossrvcDocPackage()&&!addPack){
          addPack=true;
          subFrom.append("GossrvcDocPackage packNew, ");
          subWhere.append("packNew.id=assigment.packId and ");
        }           
      }
    }
 

    MyTaskQueryBuilder queryBuilder =
        new MyTaskQueryBuilder(select.toString(), listFrom, listWhere, subFrom.toString(), subWhere.toString(),
            searchCriteria);
    SqlQuery sqlQuery = queryBuilder.buildQuery();
    _log.debug("createQuery завершен. Время выполнения: #0ms", System.currentTimeMillis() - timestamp);
    return sqlQuery;
  }

  public static void main(String[] args) {
    List<String> test = new ArrayList<String>();
    System.out.println(test.addAll(Arrays.asList("1,2".split(","))));
  }


  private static class MyTaskQueryBuilder {

    private final String select;
    private final List<String> listFrom;
    private final List<String> listWhere;
    private final String subFrom;
    private final String subWhere;
    private final MyTaskSearchCriteria searchCriteria;

    public MyTaskQueryBuilder(String select, List<String> listFrom, List<String> listWhere, String subFrom,
        String subWhere,  MyTaskSearchCriteria searchCriteria) {
      super();
      this.select = select;
      this.listFrom = listFrom;
      this.listWhere = listWhere;
      this.subFrom = subFrom;
      this.subWhere = subWhere;
      this.searchCriteria = searchCriteria;
    }



    public SqlQuery buildQuery() {
      String fields = buildSelect();
      String from = buildFrom();
      String where = buildWhere();
      String orderBy = buildOrderBy();
      return new SqlQuery(fields, from, where, orderBy);
    }

    private String buildSelect() {
      StringBuilder q = new StringBuilder();
      q.append(select);
      if (select != null && !select.isEmpty()) {
        q.append(", ");
      }
      q.append("assigment.activityId as actid");
      return q.toString();
    }

    private String buildFrom() {
      StringBuilder from = new StringBuilder();
      // from
      for (String i : listFrom) {
        from.append(i).append(", ");
      }
      from.append(subFrom).append("AssignmentEntity assigment");
      return from.toString();
    }

    private String buildWhere() {
      StringBuilder where = new StringBuilder();
      for (String i : listWhere) {
        where.append(i).append(" and ");
      }
      where.append(subWhere);
      if (!"".equals(where))
        where = new StringBuilder(where.substring(0, where.length() - 4));

      if (searchCriteria.isShowMyTask()) {
        where.append(" and assigment.accepted=true ");
      }

      /*
       * if (searchInstance.getInputRequest() != null && searchInstance.getInputRequest()) { where
       * .append(
       * " and exists(select a.packNum from GossrvcDocPackage a, ProcessVariableEntity ent1 where assigment.processId=ent1.processId and ent1.longValue=a.id and (a.externalSystem = 1 or a.externalSystem = 2)) "
       * ); }
       */
      if (searchCriteria.isUseCaseForRaspredFilter()
      /* && (searchInstance.getCaseForRaspred() == null || !searchInstance.getCaseForRaspred()) */) {
        FilterValue shoDocsOnDistribCriteria = searchCriteria.getFilterByCode(MyTaskFilterItemCodes.SHOW_DOCS_ON_DISTRIBUTION);
        if (shoDocsOnDistribCriteria != null && !Boolean.parseBoolean(shoDocsOnDistribCriteria.getValues().get(0))) {
          where.append(" and assigment.activityId not like '%_chooseResp1' ");
        }
      }
      return where.toString();
    }

    private String buildOrderBy() {
      String orderBy = " ORDER BY assigment.oid desc";

      if (searchCriteria.getOrderBy() != null && searchCriteria.getOrderType() != null) {
        if (searchCriteria.getOrderBy().equals("create") || searchCriteria.getOrderBy().equals("started")
            || searchCriteria.getOrderBy().equals("limit")) {
          orderBy = " ORDER BY " + searchCriteria.getOrderBy();
        }
        if (searchCriteria.getOrderType().equals("desc")) {
          orderBy += " desc NULLS LAST";
        }
      }
      return orderBy;
    }
  }

  private static class SqlQuery {
    private final String fields;
    private final String from;
    private final String where;
    private final String orderBy;

    public SqlQuery(String fields, String from, String where, String orderBy) {
      super();
      this.fields = fields;
      this.from = from;
      this.where = where;
      this.orderBy = orderBy;
    }

    public String findQuery() {
      _log.debug("findQuery запущен.");
      long timestamp = System.currentTimeMillis();
      StringBuilder findQuery = new StringBuilder();
      findQuery.append("SELECT ");
      findQuery.append(fields);
      findQuery.append(" FROM ");
      findQuery.append(from);
      findQuery.append(" WHERE ");
      findQuery.append(where);
      findQuery.append(orderBy);
      String findQueryStr = findQuery.toString();
      _log.debug("findQuery завершен. Время выполнения: #0ms", System.currentTimeMillis() - timestamp);
      return findQueryStr;
    }

    public String countQuery(String alias) {
      _log.debug("countQuery запущен.");
      long timestamp = System.currentTimeMillis();
      StringBuilder countQuery = new StringBuilder();
      countQuery.append("SELECT count(").append(alias).append(") FROM ");
      countQuery.append(from);
      countQuery.append(" WHERE ");
      countQuery.append(where);
      String countQueryStr = countQuery.toString();
      _log.debug("findQuery завершен. Время выполнения: #0ms", System.currentTimeMillis() - timestamp);
      return countQueryStr;
    }
  }

  @Override
@SuppressWarnings("unchecked")
  public List<Object[]> getCardElementsByCode(String cardCode) {
    StringBuilder queryStr = new StringBuilder();
    queryStr.append("SELECT ").append("c.id,c.name ");
    queryStr.append("FROM CardElement c ");
    queryStr.append("WHERE ");
    queryStr.append("c.card.cardCode=:cardCode ");
    queryStr.append("order by c.name");

    return em.createQuery(queryStr.toString()).setHint("org.hibernate.cacheable", true)
        .setParameter("cardCode", cardCode)
        .getResultList();
  }
  
  @Override
  @SuppressWarnings("unchecked")
  public String getDocPackageComment(Object activityId) {
	  
	  StringBuilder result = new StringBuilder();
	  
	  if (activityId != null) {
		  
		  Query query = em.createQuery("select ent1.message from GossrvcDocPackageComment ent1 where ent1.gossrvcDocPackage.id =" + activityId.toString());
  
		  List<Object> resultArray = query.getResultList();
	  
		  for (Object oneResult : resultArray) {
			  result.append((String)oneResult); 
			  result.append("\n");
		  }
	  }

	  return result.toString();

  }

}
