package org.cp.sir.action;

import org.cp.common.HibernateFilter;
import org.cp.common.Request;
import org.cp.ecm.model.ECMAttach;
import org.cp.ecm.model.ECMDocument;
import org.cp.jcr.DocPackJcrController;
import org.cp.jcr.JcrNodeLite;
import org.cp.jcr.MemberResourceController;
import org.cp.model.doc.JcrAttach;
import org.jboss.seam.Component;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.In;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;
import org.jboss.seam.faces.FacesMessages;
import org.jboss.seam.international.StatusMessage.Severity;

import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.Query;

@Name("searchAction")
@Scope(ScopeType.CONVERSATION)
public class SearchAction {
  
  @In(value="entityManager")
  EntityManager em;
  
  @In
  HibernateFilter hibernateFilter;

  private String searchStr;
  private List<SearchType> listTypes;
  private String currentTab;
  private String searchTop;
  
  public String getSearchTop() {
    return searchTop;
  }

  public void setSearchTop(String searchTop) {
    this.searchTop = searchTop;
  }

  public String getCurrentTab() {
    return currentTab;
  }

  public void setCurrentTab(String currentTab) {
    this.currentTab = currentTab;
  }

  public enum TYPE{
    doc, query, applicant, attach, ecm;
  }

  public class SearchType {
    private Boolean select=true;
    private TYPE code;
    private String name;
    private List list;
    public Boolean getSelect() {
      return select;
    }
    public void setSelect(Boolean select) {
      this.select = select;
    }
    public TYPE getCode() {
      return code;
    }
    public void setCode(TYPE code) {
      this.code = code;
    }
    public String getName() {
      return name;
    }
    public void setName(String name) {
      this.name = name;
    }
    public List getList() {
      return list;
    }
    public void setList(List list) {
      this.list = list;
    }
    public SearchType(TYPE code, String name) {
      super();
      this.code = code;
      this.name = name;
    }
  }
  
  public List<SearchType> getListTypes() {
    if (listTypes==null){
      listTypes=new ArrayList<SearchType>();
      listTypes.add(new SearchType(TYPE.doc,"Комплекты документов"));
      listTypes.add(new SearchType(TYPE.query,"Межведомственные запросы"));
      listTypes.add(new SearchType(TYPE.applicant,"Заявители"));
      listTypes.add(new SearchType(TYPE.attach,"Документы"));
      listTypes.add(new SearchType(TYPE.ecm,"Документооборот"));
    }
    return listTypes;
  }

  public void setListTypes(List<SearchType> listTypes) {
    this.listTypes = listTypes;
  }

  public String getSearchStr() {
    return searchStr;
  }

  public void setSearchStr(String searchStr) {
    this.searchStr = searchStr;
  }
  
  public String search(){
    if (searchTop==null||searchTop.length()<3){
      FacesMessages.instance().add(Severity.INFO, "Для поиска необходимо ввести более 3-х символов.");
      return null;
    }
    this.searchStr=this.searchTop;
    this.searchTop=null;
    refresh();
    return "/member/search.xhtml";
  }
  
  public void refresh(){
    if (searchStr==null||searchStr.length()<3){
      FacesMessages.instance().add(Severity.INFO, "Для поиска необходимо ввести более 3-х символов.");
      return;
    }
    String search="%"+searchStr.trim().toLowerCase()+"%";
    for(SearchType st:getListTypes()){
      if (st.getSelect())
        if (st.getCode().equals(TYPE.doc)){
          String sql="SELECT p FROM GossrvcDocPackage p WHERE "+
              "lower(p.packNum) like :search"+
              " OR EXISTS (SELECT g FROM ObjectGroup g join g.items i, Person per WHERE g=p.applicantGroup" +
              " AND i.objectClass = 'org.cp.model.common.Person' AND i.objectId=per.id"+
              " AND lower(concat(per.lastName,' ',per.firstName,' ',per.middleName)) like :search)"+
              " OR EXISTS (SELECT g FROM ObjectGroup g join g.items i, Agent ag WHERE g=p.applicantGroup" +
              " AND i.objectClass = 'org.cp.lodent.Agent' AND i.objectId=ag.id"+
              " AND lower(ag.name) like :search)"+
              " OR EXISTS (SELECT c FROM CardElement c WHERE c.id=p.serviceId AND lower(c.name) like :search)"+
              " OR EXISTS (SELECT attr FROM GossrvcDocPackageAttrVal attr WHERE attr.gossrvcDocPackage=p "+
              " AND lower(attr.stringValue) like :search)"+
              " OR EXISTS (SELECT com FROM GossrvcDocPackageComment com WHERE "+
              " com.gossrvcDocPackage=p AND lower(com.message) like :search)";
            st.setList(em.createQuery(sql)
                .setParameter("search",search)
                .setMaxResults(50)
                .getResultList());
        }else if (st.getCode().equals(TYPE.query)){
          String sql="SELECT req FROM Request req join req.soapContext c join c.vars v WHERE "+
            "lower(req.printDoc.docNum) like :search or "+
            "lower(v.stringValue) like :search";
          st.setList(em.createQuery(sql)
              .setParameter("search",search)
              .setMaxResults(50)
              .getResultList());
        }else if (st.getCode().equals(TYPE.applicant)) {
          String sql = "SELECT new org.cp.sir.model.Applicant(p) FROM Person p WHERE " +
                       "lower(concat(p.firstName,p.lastName,p.middleName)) like :search or " +
                       "lower(p.inn) like :search or " +
                       "lower(p.snils) like :search or " +
                       "lower(p.address) like :search or " +
                       "lower(p.factAddress) like :search or " +
                       "lower(p.passSeria) like :search or " +
                       "lower(p.passNo) like :search";
          st.setList(em.createQuery(sql)
                         .setParameter("search", search)
                         .setMaxResults(25)
                         .getResultList());
          //
          sql = "SELECT new org.cp.sir.model.Applicant(p) FROM Agent p WHERE " +
                "lower(p.name) like :search or " +
                "lower(p.nameShort) like :search or " +
                "lower(p.inn) like :search or " +
                "lower(p.kpp) like :search or " +
                "lower(p.ogrn) like :search or " +
                "lower(p.address) like :search or " +
                "lower(p.bossFio) like :search";
          st.getList().addAll(em.createQuery(sql)
                                  .setParameter("search", search)
                                  .setMaxResults(25)
                                  .getResultList());
        } else if(st.getCode().equals(TYPE.ecm)) {
          //Документооборот
          MemberResourceController
              jcr = (MemberResourceController) Component.getInstance("csResourceController", true);
          String escape="!():^[]{}?";
          String searchString = searchStr.trim().replace("/", "").replace("'", "").replace("\"", "");
          for(int i=0;i<escape.length()-1;i++){
            searchString=searchString.replace(""+escape.charAt(i), "\\"+escape.charAt(i));
          }
          if (searchString.indexOf("\\")==-1)
            searchString="*"+searchString+"*";
          //searchString="fdf OR Ива*";
          //searchString="*-1*";
          String xqry = "//element(*, cs:Document)[";
          xqry += "(jcr:contains(jcr:content, '" + searchString+"'))";
          String owners=hibernateFilter.getCurrentOwners();
          //owners="Tyumen";
          if (!",".equals(owners)){
            xqry += " and (";
            for(String i:owners.split(",")){
              xqry += "(@cs:keywords='"+i+"') or ";
            }
            xqry += " not(@cs:keywords)";
            xqry += ")";
          }
          xqry+="] ";
          List<JcrNodeLite> list=jcr.executeQueryLite(xqry, 50);

          if (list.size()>0){
            List<String> listUid=new ArrayList<String>();
            for(JcrNodeLite i:list){
              listUid.add(i.getUid());
            }
            //Комплекты
            String sql="SELECT attach, doc FROM ECMDocument doc join doc.attaches attach WHERE attach.uid in (:uid) "+
                       "and doc.parent is null";
            Query q=em.createQuery(sql);
            q.setParameter("uid", listUid);
            q.setMaxResults(50);
            Map<String,Map.Entry<ECMAttach, ECMDocument>> mapRes1=new HashMap<String,Map.Entry<ECMAttach, ECMDocument>>();
            for(Object[] i:(List<Object[]>)q.getResultList()){
              if (i.length == 2) {
                ECMAttach attach = (ECMAttach) i[0];
                ECMDocument document = (ECMDocument) i[1];
                mapRes1.put(attach.getUid(), new AbstractMap.SimpleEntry<ECMAttach, ECMDocument>(attach, document));
              }
            }
            Iterator<JcrNodeLite> liteIterator = list.iterator();
            while (liteIterator.hasNext()) {
              JcrNodeLite node = liteIterator.next();
              if (mapRes1.containsKey(node.getUid())) {
                node.setEcmDocument(mapRes1.get(node.getUid()).getValue());
              } else {
                liteIterator.remove();
              }
            }
//            for(JcrNodeLite i:list){
//              if (mapRes1.containsKey(i.getUid())) {
//                i.setEcmDocument(mapRes1.get(i.getUid()).getValue());
//              }
//            }
          }
          st.setList(list);

        }else{
            //Документы
            DocPackJcrController jcr=(DocPackJcrController)Component.getInstance("docPackJcrController",true);
            String escape="!():^[]{}?";
            String searchString = searchStr.trim().replace("/", "").replace("'", "").replace("\"", "");
            for(int i=0;i<escape.length()-1;i++){
              searchString=searchString.replace(""+escape.charAt(i), "\\"+escape.charAt(i));
            }
            if (searchString.indexOf("\\")==-1)
              searchString="*"+searchString+"*";
            //searchString="fdf OR Ива*";
            //searchString="*-1*";
            String xqry = "//element(*, cs:Document)[";
            xqry += "(jcr:contains(jcr:content, '" + searchString+"'))";
            String owners=hibernateFilter.getCurrentOwners();
            //owners="Tyumen";
            if (!",".equals(owners)){
              xqry += " and (";
              for(String i:owners.split(",")){
                xqry += "(@cs:keywords='"+i+"') or ";
              }
              xqry += " not(@cs:keywords)";
              xqry += ")";
            }
            xqry+="] ";
            List<JcrNodeLite> list=jcr.executeQueryLite(xqry, 50);
            
            if (list.size()>0){
              List<String> listUid=new ArrayList<String>();
              for(JcrNodeLite i:list){
                listUid.add(i.getUid());
              }
              //Комплекты
              String sql="SELECT dm FROM JcrAttach dm WHERE dm.jcrUid in (:uid) "+
                  "and dm.gossrvcDocPackageItem is not null";
              Query q=em.createQuery(sql);
              q.setParameter("uid", listUid);
              q.setMaxResults(50);
              Map<String,JcrAttach> mapRes1=new HashMap<String,JcrAttach>();
              for(JcrAttach i:(List<JcrAttach>)q.getResultList()){
                mapRes1.put(i.getJcrUid(), i);
              }
              //Мэжвед
              sql="SELECT r.id,hist.uidRequest,hist.uidResponse FROM Request r join r.soapContext c join c.historyContext hist "+
                  "WHERE hist.uidRequest in (:uid) or hist.uidResponse in (:uid)";
              q=em.createQuery(sql);
              q.setParameter("uid", listUid);
              q.setMaxResults(50);
              Map<String,Request> mapRes2=new HashMap<String,Request>();
              for(Object[] i:(List<Object[]>)q.getResultList()){
                Request r=em.find(Request.class, i[0]);
                mapRes2.put((String)i[1], r);
                mapRes2.put((String)i[2], r);
              }
              //
              for(JcrNodeLite i:list){
                if (mapRes1.containsKey(i.getUid()))
                  i.setDoc(mapRes1.get(i.getUid()).getGossrvcDocPackageItem().getGossrvcDocPackage());
                if (mapRes2.containsKey(i.getUid()))
                  i.setRequest(mapRes2.get(i.getUid()));
              }
            }  
            st.setList(list);
        }
      else
        st.setList(new ArrayList());
    }
  }
  
}
