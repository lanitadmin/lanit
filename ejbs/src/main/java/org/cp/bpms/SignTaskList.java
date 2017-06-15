package org.cp.bpms;

import org.cp.audit.AuditEvent;
import org.cp.audit.AuditManager;
import org.cp.audit.IAuditManager;
import org.cp.lodent.UserDAO;
import org.cp.soap.*;
import org.cp.staff.SelectedItems;
import org.jboss.seam.Component;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.In;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;

import javax.jcr.RepositoryException;
import javax.jcr.ValueFormatException;
import javax.jcr.lock.LockException;
import javax.jcr.nodetype.ConstraintViolationException;
import javax.jcr.version.VersionException;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.*;
import org.cp.common.ObjectGroupItem;
import org.cp.gossrvc.GossrvcDocPackage;
import org.cp.lodent.Agent;
import org.cp.model.common.Person;
import org.cp.sharkimpl.persistanse.model.AssignmentEntity;
import org.jboss.seam.annotations.Logger;
import org.jboss.seam.log.Log;

@Name("signTaskList")
@Scope(ScopeType.CONVERSATION)
public class SignTaskList implements Serializable {

    @Logger
    Log log;
    
    public static final String VIEW = "/member/signTasks.xhtml";

    @In(create = true)
    private EntityManager entityManager;

    private String tmpuids;
    private String infomsg;
    private String uid;
    private String text;
    private Boolean begin;
    private Boolean end;
    private Boolean error;
    private int i = 1;
    private Boolean createList=false;
    
    public Boolean getCreateList() {
      return createList;
    }

    public void setCreateList(Boolean createList) {
      this.createList = createList;
    }

    private List<SelectedItems> contextList;

    public List<SelectedItems> getContextList() {
        if(contextList==null&&createList){
            fillRequestSet();
        }
        return contextList;
    }

    public void setContextList(List<SelectedItems> contextList) {
        this.contextList = contextList;
    }

    private boolean showApplet = false;

    public boolean isShowApplet() {
        return showApplet;
    }

    public void setShowApplet(boolean showApplet) {
        this.showApplet = showApplet;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
        //System.out.println("uid = " + uid);
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public Boolean getBegin() {
        return begin;
    }

    public void setBegin(Boolean begin) {
        this.begin = begin;
    }

    public Boolean getEnd() {
        return end;
    }

    public void setEnd(Boolean end) {
        this.end = end;
    }

    public Boolean getError() {
        return error;
    }

    public void setError(Boolean error) {
        this.error = error;
    }

    public String getTmpuids() {
        return tmpuids;
    }

    public void setTmpuids(String tmpuids) {
        this.tmpuids = tmpuids;
    }

    public void fillRequestSet(){
        Set<SoapContext> requestSet = new HashSet<SoapContext>();
        UserDAO userDAO = (UserDAO)Component.getInstance(UserDAO.class);
        String username = userDAO.getCurrentUserLogin();
        contextList = new ArrayList<SelectedItems>();
        String sql="select sc from SoapContext sc, AssignmentEntity a where "+
            "a.resourceUsername = :currentuser and "+
            "a.soapContextId=sc.id and " +
            "sc.complete=false and "+         
            "(sc.systemStatus =:status1 or sc.systemStatus =:status2 or sc.systemStatus =:status3 or sc.systemStatus =:status4 or sc.systemStatus =:status5)";
        Query query = entityManager.createQuery(sql)
                .setParameter("status1", SoapContext.SystemStatus.signSoap)
                .setParameter("status2", SoapContext.SystemStatus.signXml)
                .setParameter("status3", SoapContext.SystemStatus.signZip)
                .setParameter("status4", SoapContext.SystemStatus.signSMEV3)
                .setParameter("status5", SoapContext.SystemStatus.signCMS)
                .setParameter("currentuser",username);
        List<SoapContext> resultList = (List<SoapContext>)query.getResultList();
        for(SoapContext sc :resultList){
            
            
            try {
            Query q = entityManager.createQuery("select a from AssignmentEntity a where a.soapContextId = :id ")
                    .setParameter("id", sc.getId());
            AssignmentEntity ae = (AssignmentEntity) q.getSingleResult();
            
            Query q2 = entityManager.createQuery("select a from GossrvcDocPackage a where a.id = :id ")
                    .setParameter("id", ae.getPackId());
            GossrvcDocPackage pack = (GossrvcDocPackage) q2.getSingleResult();
            sc.setServiceName(pack.getServiceName());
            
            String applicantName = "";
            List<ObjectGroupItem> applicants = pack.getApplicantGroup().getItems();
            if (!applicants.isEmpty()) {
                ObjectGroupItem item = applicants.get(0);
                Object applicant = item.getObject();

                if (applicant instanceof Person) {
                    applicantName = ((Person) applicant).getLastName() + " " + ((Person) applicant).getFirstName() + " " + ((Person) applicant).getMiddleName();
                } else if (applicant instanceof Agent) {
                    applicantName = ((Agent) applicant).getName();
                }
            }
            sc.setApplicantName(applicantName);
            sc.setActivityId(ae.getActivityId());
            } catch (Exception ex) {
                // обработка, когда данных о КД не нашлось в AssignmentEntity или GossrvcDocPackage
                log.error("", ex);
                log.error("AssignmentEntity or GossrvcDocPackage not found for SoapContext.id = {} {}", sc.getId(), sc);
            }
            
            requestSet.add(sc);
            contextList.add(new SelectedItems(sc.getId().toString(), false, sc));
        }
    }


    public List<String> getRequestGroupList() {
        Set<String> groupSet = new HashSet<String>();
        if(contextList==null){
            fillRequestSet();
        }
        for(SelectedItems item: contextList){
            groupSet.add(((SoapContext) item.getValue()).getParent().getCode() + " - " + ((SoapContext) item.getValue()).getParent().getName());

        }
        return new ArrayList<String>(groupSet);
    }

    private void getIds() {
        int i = 0;

        StringBuilder sb = new StringBuilder();
        StringBuilder info = new StringBuilder();
        for (SelectedItems item: contextList) {
            if (item.getSelected()) {
                SoapContext sc = (SoapContext) item.getValue();
                if (i > 0) {
                    sb.append("###");
                }
                sb.append(sc.getUid());
                sb.append("##");
                sb.append(sc.getModeSign());
                sb.append("##");
                sb.append(sc.getParent().getActorText());
                sb.append("##");
                sb.append(sc.getXmlId());
                sb.append("##");
                sb.append(sc.getXmlExtParam());
                sb.append("##");
                sb.append(sc.getFileSignExt());
                i++;
            }
        }
        tmpuids = sb.toString();
    }

    public List<SelectedItems> getContextByGroup(String group) {
        List<SelectedItems> resultList = new ArrayList<SelectedItems>();
        if (group != null && !group.isEmpty()) {
            String code = group.substring(0, group.indexOf(" - "));
            for(SelectedItems item: contextList){
                SoapContext sc = (SoapContext) item.getValue();
                if(code.equals(sc.getParent().getCode())){
                    resultList.add(item);
                }
            }
            Collections.sort(resultList, new Comparator<SelectedItems>() {
                @Override
                public int compare(SelectedItems o1, SelectedItems o2) {
                    Date a = null;
                    Date b = null;
                    if (o1.getValue()!=null)
                      a=((SoapContext)o1.getValue()).getRunTime();
                    if (o2.getValue()!=null)
                      b=((SoapContext)o2.getValue()).getRunTime();
                    if (a!=null&&b!=null)
                        return a.compareTo(b);
                    else if (a!=null&&b==null)
                        return 1;
                    else if (a==null&&b!=null)
                        return -1;
                    else
                      return 0;
                }
                /*public int compare(SoapContext sc1, SoapContext sc2) {
                    DateTime a = sc1.getDateTime();
                    DateTime b = sc2.getDateTime();
                    if (a.lt(b))
                        return -1;
                    else if (a.lteq(b)) // it's equals
                        return 0;
                    else
                        return 1;
                }*/
            });
        }
        return resultList;
    }

    public String getExistSign(String uid) {
        try {
            return String.valueOf(ExtFunc.existsSignSoap(uid));
        } catch (Exception e) {
            return "нет данных";
        }
    }

    public void updateSignatureNew()
            throws UnsupportedEncodingException, ValueFormatException, VersionException, LockException, ConstraintViolationException, RepositoryException {
        if(!Boolean.TRUE.equals(error)) {
            ExtFunc.updateSignSoap(uid, text);
            for (SoapContext sc : getContextByUid(uid)) {
                SoapManage soapManage = (SoapManage) Component.getInstance(SoapManage.class, ScopeType.CONVERSATION, true);
                soapManage.runScript(sc, getContextVarByContext(sc), false,
                        entityManager, null, null);
            }
            IAuditManager am = (IAuditManager) Component.getInstance(AuditManager.class);
            am.logAuditMessage(AuditEvent.SEC_JCR_MULTISOAP_SIGN, AuditEvent.OBJECT, getInfoByUid(uid));
        }else{
            for (SoapContext sc : getContextByUid(uid)) {
                sc.setInfomsg("Ошибка: " + text);
            }
        }

        error = null;
    }


    public List<SoapContext> getContextByUid(String uid) {
        List<SoapContext> tmpList = new ArrayList<SoapContext>();
        Query query = entityManager.createQuery(" select sc from SoapContext  sc where sc.uid like :uid").setParameter("uid",uid);
        tmpList = query.getResultList();
        return tmpList;
    }

    public Map<String, Object> getContextVarByContext(SoapContext sc) {
        List<SoapContextVar> tmpList = new ArrayList<SoapContextVar>();
        Map<String, Object> values = new HashMap<String, Object>();
        Query query = entityManager.createQuery(" select scv from SoapContextVar  scv where scv.parent  = :parent").setParameter("parent",sc);
        tmpList = query.getResultList();
        for(SoapContextVar var : tmpList){
            values.put(var.getAttr().getCode(), var.getValue());
        }
        return values;
    }

    public void clearSelected(){
        showApplet = false;
        for(SelectedItems item: contextList){
            item.setSelected(false);
        }
    }

    public void selectAll(){
        showApplet = false;
        for(SelectedItems item: contextList){
            SoapContext sc = (SoapContext) item.getValue();
            if(sc!=null && sc.getUid()!=null && !sc.getUid().isEmpty()) {
                item.setSelected(true);
            }
        }
    }

    public void prepareGroupSigner(){
        showApplet = true;
        getIds();
    }

    public String getInfoByUid(String uid){
        StringBuilder info = new StringBuilder();
        UserDAO userDAO = (UserDAO) Component.getInstance(UserDAO.class);
        for(SelectedItems item: contextList){
            SoapContext sc = (SoapContext)item.getValue();
            if(sc.getUid()!=null && uid!=null && sc.getUid().equals(uid)){
                info.append("Пользователем  ");
                info.append(userDAO.getCurrentUser());
                info.append(" подписан запрос в составе пакета запросов. ");
                info.append(sc.getParent().getCode() + " " +sc.getParent().getName());
                info.append(" Uid: " + sc.getUid());
            }
        }
        return info.toString();
    }

    public void updateRequestList(){
        for(SelectedItems item : contextList){
            item.setSelected(false);
        }
        showApplet = false;
    }
}
