package org.cp.xml;


import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.xml.bind.JAXBException;

import org.cp.cardsystem.CardElement;
import org.cp.cardsystem.xml.CardAdapter;
import org.cp.cardsystem.xml.CardElementAdapter;
import org.cp.cardsystem.xml.CardRootAdapter;
import org.cp.common.utils.ArrayUtils;
import org.cp.common.utils.FileUtils;
import org.cp.common.utils.JAXBUtils;
//import org.cp.common.utils.JAXBUtils;
import org.cp.gossrvc.xml.GossrvcServiceDocAdapter;
import org.cp.gossrvc.xml.GossrvcServiceDocTreeAdapter;
import org.cp.gossrvc.xml.RequestTemplateAdapter;
import org.cp.sed.OrgUnit;
import org.cp.ui.component.DefaultTreeNode;
import org.cp.ui.component.TreeNode;
import org.jboss.seam.Component;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.In;
import org.jboss.seam.annotations.Logger;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Role;
import org.jboss.seam.annotations.Scope;
import org.jboss.seam.faces.FacesManager;
import org.jboss.seam.faces.FacesMessages;
import org.jboss.seam.international.StatusMessage.Severity;
import org.jboss.seam.log.Log;
import org.richfaces.component.UITree;
import org.richfaces.event.FileUploadEvent;
import org.richfaces.event.TreeSelectionChangeEvent;
import org.richfaces.model.UploadedFile;

import ru.lanit.DAOBus;
import ru.lanit.util.CorrectBug;
import ru.lanit.util.Util;

/**
 *  Класс добавлен для решения тикета 62813, нужно удалить после обновления ядра до 8.3.0
 */
@Name("xmlImport")
@Scope(ScopeType.CONVERSATION)
@Role(name="xmlImportStateless", scope=ScopeType.STATELESS)
public class XmlImport implements Serializable {

    private static final long serialVersionUID = 8176050051810701981L;
    private static final String message_warn_is_monopoly = "На данный момент импорт уже производится другим пользователем. Попробуйте повторить попытку позже!";
    public static final String folder_import = "/import";

    @Logger
    Log log;

    @In
    EntityManager entityManager;


//	@In(create=true)
//	XmlLog xmlLog;

    @In("#{xmlExportClasses.classes}")
    private List<Class<?>> exportClasses;

    private XmlRootAdapter rootAdapter;

    private Comparator<Method> comparator;

    private OrgUnit orgUnitForTree;

    private OrgUnit orgUnit;

    private String oldOwner;

    /**
     * Выбранный элемент картотеки из таблицы для переопределения элементов, для которого будет произведена замена при импорте на элемент,
     * выбранный из системы
     */
    private TreeNode<CardElementAdapter> currentAdapterNode;

    /**
     * Список иерархичных элементов типов документов с иерархией (Для таблицы с переопределением элементов)
     */
    public List<TreeNode<CardElementAdapter>> cardElementTrees;

    /**
     * Линейный список всех элементов типов документов. Формируется после обхода <code>cardElementTrees</code> и добавлением всех элементов,
     * по условию <code>treeNode.getParent() == null || treeNode.getParent().getExpanded()</code>. Список формируется каждый раз заново после
     * раскрытия элемента картотеки в таблицы для переопределения элементов.
     */
    private List<TreeNode<CardElementAdapter>> cardElementTreeNodesAsList;

    /**
     * Идентификатор (Код) элемента картотеки, на который будет произведена замена при переопределении элементов.
     *
     */
    private String selectedCardElementId;

    /**
     * Используется только для сброса значения для автокомплита
     */
    private String selectedCardElementName;

    private String exportCompleteView;

    /**
     * Хранилище для id, которые уже были сохранены в БД, используется для связанных адаптеров импорта
     */
    private Map<String, Object> persistedIdsWarehouse = new ConcurrentHashMap<String, Object>();

    private Map<String, OrgUnit> mapOrgUnit = new HashMap<String,  OrgUnit>();

    private Map<String, String> mapOwner = new HashMap<String,  String>();

    private Map<String, CardElementAdapter> mapCardElementAdapter = new HashMap<String,  CardElementAdapter>();

	/* IMPORT */

    private InputStream uploadContent;

    /* CHECK. Cache */

    private Map<String, List<CheckXmlAdapter>> cache;

    /**
     * Все элементы справочника
     */
    private Map<String, CardElement> mapCardElement = null;

    public String getSelectedCardElementId() {
        return selectedCardElementId;
    }

    public void setSelectedCardElementId(String cardElementId) {
        this.selectedCardElementId = cardElementId;
    }

    public Map<String, CardElementAdapter> getMapCardElementAdapter() {
        return mapCardElementAdapter;
    }

    public Map<String, CardElement> getMapCardElement() {
        if (mapCardElement == null){
            mapCardElement = new HashMap<String, CardElement>();
            List<CardElement> lst = DAOBus.getCardElementDAO().getAll();
            for (CardElement ce: lst)
                mapCardElement.put(ce.getId(), ce);
        }
        return mapCardElement;
    }

    private void setParentCardCode(CardElementAdapter cardElementAdapter) {
        CardAdapter cardAdapter;
        CheckXmlAdapter parent = cardElementAdapter.getParent();
        while(true){
            if (parent instanceof CardAdapter){
                cardAdapter = (CardAdapter) parent;
                break;
            }
            parent = parent.getParent();
        }
        cardElementAdapter.setCardCode(cardAdapter.getCode());

    }

	/*public List<CardElementAdapter> getListCardElementAdapter(){
		List<CardElementAdapter> list = new ArrayList<CardElementAdapter>(mapCardElementAdapter.values());

		Collections.sort(list, new Comparator<CardElementAdapter>() {
			public int compare(CardElementAdapter o1, CardElementAdapter o2) {
				if (o1.getCardCode() == null){
				  setParentCardCode(o1);
				}
				if (o2.getCardCode() == null){
				  setParentCardCode(o2);
				}
				int res = o1.getCardCode().compareTo(o2.getCardCode());
				if (res == 0) {
					res = o1.getCode().compareTo(o2.getCode());
				}
				return res;
			}
		});

		return list;
	}*/



    public Collection<String> getMapOrgUnitKey() {
        return new ArrayList<String>(mapOrgUnit.keySet());
    }


    public String getOldOwner() {
        return oldOwner;
    }

    public void setOldOwner(String oldOwner) {
        this.oldOwner = oldOwner;
    }

    public OrgUnit getOrgUnitForTree() {
        return orgUnitForTree;
    }

    public void setOrgUnitForTree(OrgUnit orgUnitForTree) {
        this.orgUnitForTree = orgUnitForTree;
    }

    public OrgUnit getOrgUnit() {
        return orgUnit;
    }

    public void setOrgUnit(OrgUnit orgUnit) {
        this.orgUnit = orgUnit;
    }

    public String uploadContentType;

    public String uploadFileName;

    private Map<String, InputStream> listAttachments = new HashMap<String, InputStream>();

	/* GENERAL */

    public String getUploadContentType() {
        return uploadContentType;
    }

    public XmlImport(){
        comparator = new Comparator<Method>(){
            public int compare(Method o1,
                               Method o2){
                XmlImportGetForSave getForSave1 = o1.getAnnotation(XmlImportGetForSave.class);
                XmlImportGetForSave getForSave2 = o2.getAnnotation(XmlImportGetForSave.class);

                if (getForSave1 != null && getForSave2 != null)
                    return getForSave1.weight() - getForSave2.weight();
                else
                    return 0;
            }
        };
    }


    public void setUploadContentType(String uploadContentType) {
        this.uploadContentType = uploadContentType;
    }

    public String getUploadFileName() {
        return uploadFileName;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public void refresh() {
        rootAdapter = null;
        for (String key: listAttachments.keySet()){
            try {
                InputStream inp =  listAttachments.get(key);
                if (inp != null){
                    inp.close();
                }
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                log.error("Ошибка при закрытие входного потока для файла:"+key+" !");
            }
        }
        listAttachments.clear();
        mapCardElementAdapter.clear();
        //xmlLog.clearLog();
        refreshCache();
    }

    public List<CheckXmlAdapter> getRootList() {
        if (rootAdapter == null)
            return null;
        return rootAdapter.getRootList();
    }

    private final Lock isMonopoly = new ReentrantLock();

    public void save() {
        if (isMonopoly.tryLock()) {
            try {
                save(false, 3, true);
                redirectToViewWithoutConversation();
            } catch (Exception e) {
                e.printStackTrace();
                FacesMessages.instance().clear();
                FacesMessages.instance().add(Severity.ERROR, "Ошибка при сохранение данных!" + e.toString());
            } finally {
                isMonopoly.unlock();
                persistedIdsWarehouse.clear();
            }
        } else {
            log.debug(message_warn_is_monopoly);
            FacesMessages.instance().add(Severity.WARN, message_warn_is_monopoly);
        }
    }

    public void saveAll() throws Exception {
        save (true, 0, false);
    }

    public void saveAll(boolean isDelete) throws Exception {
        save (true, 0, isDelete);
    }

    private void redirectToViewWithoutConversation() {
        if (!Util.isEmpty(exportCompleteView))
            FacesManager.instance().redirect(exportCompleteView, null, false);
    }

    private void updateCardElementAdater(CheckXmlAdapter adapter, boolean uncheckChild){
        boolean uncheckChildren = false;
        if (adapter instanceof CardElementAdapter){
            CardElementAdapter cEAdapter = (CardElementAdapter) adapter;
            //if (uncheckChild) {
            //  checkAdapeterUid(cEAdapter.getUid(), false);
            //} else {
            if (cEAdapter.getCardElement() != null) {
                if (!(cEAdapter.getParent() instanceof CardElementAdapter)) {
                    checkAdapeterUid(cEAdapter.getUid(), false);
                } else {
                    uncheckChildren = true;
                }
            }
            //}
            for(CheckXmlAdapter el :adapter.getChildren()) {
                updateCardElementAdater(el, uncheckChildren);
            }
        }
    }

    public void save(boolean isAll, int levelMessage, boolean isDelete) throws Exception {
        List<CheckXmlAdapter> lst = getRootList();
        if (lst.size() > 0 && lst.get(0) instanceof CardRootAdapter)
            updateCardElementAdater(getRootList().get(0), false);
        mapOwner.clear();
        for(String key :mapOrgUnit.keySet() ){
            OrgUnit orgUnit = mapOrgUnit.get(key);
            mapOwner.put(key, orgUnit != null ? orgUnit.getOwner() : null);
        }
        Date d1 = new Date();
        for (CheckXmlAdapter adapter : lst){
            if (isAll || adapter.isCheck()){
                saveAdapter(null, adapter, false, isAll, isDelete);
            }
        }
        Date d2 = new Date();
        if (levelMessage > 2){
            FacesMessages.instance().clear();
            double time = Math.rint((new Double(d2.getTime()-d1.getTime()))/1000/60*100)/100;
            FacesMessages.instance().add(Severity.INFO, "Успешно сохранено! Время: "+time+" мин.");
            log.info("Успешно сохранено! Время: "+time+" мин.");
        }
        refresh();
    }

    @SuppressWarnings("unchecked")
    private void saveAdapter(Object parentEntity, CheckXmlAdapter adapter, boolean required, boolean isAll, boolean isDelete) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException, SecurityException, NoSuchMethodException {

        if (!isAll && !adapter.isCheck()&&!required) return;

        Object entity = null;

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("this", adapter);
        paramMap.put("parentEntity", parentEntity);
        if (adapter.getExpOwner() != null && !adapter.getExpOwner().isEmpty()){
            OrgUnit ogrUnit =  this.mapOrgUnit.get(adapter.getExpOwner());
            adapter.setOwner(ogrUnit != null ? ogrUnit.getOwner() : null);
        }else{
            OrgUnit ogrUnit =  this.mapOrgUnit.get(AbstractCheckXmlAdapter.superOwner);
            adapter.setOwner(ogrUnit != null ? ogrUnit.getOwner() : null);
        }

        adapter.setMapOwner(this.mapOwner);

        List<Method> methods = new ArrayList<Method>();
        for (Method method : adapter.getClass().getMethods())
            if (method.getAnnotation(XmlImportGetForSave.class) != null)
                methods.add(method);

        Collections.sort(methods, comparator);

        for (Method method : methods){
            XmlImportGetForSave getForSave = method.getAnnotation(XmlImportGetForSave.class);
            if (getForSave.importType() == XmlImportSaveType.SAVE) {

                if (getForSave.setParentEntity()){
                    if (getForSave.parentController())
                        if (!getForSave.saveAttachment()){
                            entity = method.invoke(adapter, parentEntity, this);
                        }else {
                            entity = method.invoke(adapter, parentEntity, listAttachments, this);
                        }
                    else {
                        if (!getForSave.saveAttachment()){
                            entity = method.invoke(adapter, parentEntity);
                        }else {
                            entity = method.invoke(adapter, parentEntity, listAttachments);
                        }
                    }
                }
                else {
                    if (getForSave.parentController())
                        if(!getForSave.saveAttachment()){
                            entity = method.invoke(adapter, this);
                        }else {
                            entity = method.invoke(adapter, listAttachments, this);
                        }
                    else{
                        if(!getForSave.saveAttachment()){
                            entity = method.invoke(adapter);
                        }else {
                            entity = method.invoke(adapter, listAttachments);
                        }
                    }
                }
                entityManager.persist(entity);
            } else if (getForSave.importType() == XmlImportSaveType.UPDATE_OR_SAVE) {
                if (!getForSave.query().isEmpty()) {
                    Query query = entityManager.createQuery(getForSave.query());

                    for (String param : getForSave.params()) {
                        if (param.indexOf("=") < 0)
                            throw new IllegalArgumentException("param must be patern : 'param=query'");
                        String[] split = param.split("=");
                        query.setParameter(split[0], runQueryFromMap(split[1], paramMap));
                    }

                    List<?> list = query.getResultList();
                    if (list.size() > 0)
                        if (getForSave.setParentEntity()){
                            if (getForSave.saveAttachment()){
                                if (getForSave.parentController())
                                    entity = method.invoke(adapter, parentEntity, list.get(0), listAttachments, this);
                                else
                                    entity = method.invoke(adapter, parentEntity, list.get(0), listAttachments);
                            }
                            else {
                                if (getForSave.parentController())
                                    entity = method.invoke(adapter, parentEntity, list.get(0), this);
                                else
                                    entity = method.invoke(adapter, parentEntity, list.get(0));
                            }
                        }
                        else{
                            if (getForSave.saveAttachment()){
                                if (getForSave.parentController())
                                    entity = method.invoke(adapter, list.get(0), listAttachments, this);
                                else
                                    entity = method.invoke(adapter, list.get(0), listAttachments);
                            }
                            else {
                                if (getForSave.parentController())
                                    entity = method.invoke(adapter, list.get(0), this);
                                else
                                    entity = method.invoke(adapter, list.get(0));
                            }
                        }
                    else {
                        if (getForSave.setParentEntity()){
                            if (getForSave.saveAttachment()){
                                if (getForSave.parentController())
                                    entity = method.invoke(adapter, parentEntity, (Object) null, listAttachments, this);
                                else
                                    entity = method.invoke(adapter, parentEntity, (Object) null, listAttachments);
                            }
                            else {
                                if (getForSave.parentController())
                                    entity = method.invoke(adapter, parentEntity, (Object) null, this);
                                else
                                    entity = method.invoke(adapter, parentEntity, (Object) null);
                            }

                        }
                        else{
                            if (getForSave.saveAttachment()){
                                if (getForSave.parentController())
                                    entity = method.invoke(adapter, (Object) null, listAttachments, this);
                                else
                                    entity = method.invoke(adapter, (Object) null, listAttachments);
                            }
                            else {
                                if (getForSave.parentController())
                                    entity = method.invoke(adapter, (Object) null, this);
                                else
                                    entity = method.invoke(adapter, (Object) null);
                            }
                        }
                        if (entity!=null)
                            entityManager.persist(entity);
                    }

                } else {
                    if (adapter instanceof CardElementAdapter){
                        entity = method.invoke(adapter, parentEntity, getMapCardElement().get(((CardElementAdapter)adapter).getFullCode()), listAttachments);
                        if (entity!=null) {
                            entityManager.persist(entity);
                            getMapCardElement().put(((CardElement)entity).getId(), (CardElement)entity);
                        }
                    }else
                        throw new IllegalArgumentException("необходимо заполнить параметр query");
                }
            } else if (isDelete && getForSave.importType() == XmlImportSaveType.DELETE) {
                if (!getForSave.query().isEmpty()) {
                    method.invoke(adapter);
                    Query query = entityManager.createQuery(getForSave.query());

                    for (String param : getForSave.params()) {
                        if (param.indexOf("=") < 0)
                            throw new IllegalArgumentException("param must be patern : 'param=query'");
                        String[] split = param.split("=");
                        query.setParameter(split[0], runQueryFromMap(split[1], paramMap));
                    }
                    List<?> list = query.getResultList();
                    for (Object object : list)
                        entityManager.remove(object);
                } else {
                    throw new IllegalArgumentException("необходимо заполнить параметр query");
                }
            } else if (getForSave.importType() == XmlImportSaveType.DELETE_AND_SAVE) {
                if (!getForSave.query().isEmpty()) {
                    Query query = entityManager.createQuery(getForSave.query());

                    for (String param : getForSave.params()) {
                        if (param.indexOf("=") < 0)
                            throw new IllegalArgumentException("param must be patern : 'param=query'");
                        String[] split = param.split("=");
                        query.setParameter(split[0], runQueryFromMap(split[1], paramMap));
                    }

                    List<?> list = query.getResultList();
                    for (Object object : list)
                        entityManager.remove(object);
                    if (getForSave.setParentEntity()){
                        if (getForSave.saveAttachment()){
                            if (getForSave.parentController())
                                entity = method.invoke(adapter, parentEntity, listAttachments, this);
                            else
                                entity = method.invoke(adapter, parentEntity, listAttachments);
                        }
                        else {
                            if (getForSave.parentController())
                                entity = method.invoke(adapter, parentEntity, this);
                            else
                                entity = method.invoke(adapter, parentEntity);
                        }
                    }
                    else{
                        if (getForSave.saveAttachment()) {
                            if (getForSave.parentController())
                                entity = method.invoke(adapter, listAttachments, this);
                            else
                                entity = method.invoke(adapter, listAttachments);
                        }
                        else {
                            if (getForSave.parentController())
                                entity = method.invoke(adapter, this);
                            else
                                entity = method.invoke(adapter);
                        }
                    }
                    if (getForSave.returnResult())
                        entityManager.persist(entity);
                } else {
                    throw new IllegalArgumentException("необходимо заполнить параметр query");
                }
            }
        }

        for (Method method : adapter.getClass().getMethods())
            if (method.getAnnotation(XmlImportForSaveList.class) != null)
                if (method.getAnnotation(XmlImportForSaveList.class).beforeChildren()) {
                    List<? extends CheckXmlAdapter> list = (List<? extends CheckXmlAdapter>) method.invoke(adapter);
                    for (CheckXmlAdapter child : list)
                        saveAdapter(entity, child, true, isAll, isDelete);
                }

        for (CheckXmlAdapter child : adapter.getChildren())
            saveAdapter(entity, child, false, isAll, isDelete);

        for (Method method : adapter.getClass().getMethods())
            if (method.getAnnotation(XmlImportForSaveList.class) != null)
                if (!method.getAnnotation(XmlImportForSaveList.class).beforeChildren()) {
                    List<? extends CheckXmlAdapter> list = (List<? extends CheckXmlAdapter>) method.invoke(adapter);
                    for (CheckXmlAdapter child : list)
                        saveAdapter(entity, child, true, isAll, isDelete);
                }

    }

    private Object runQueryFromMap(String query, Map<String, Object> paramMap) throws SecurityException, NoSuchMethodException, IllegalArgumentException, IllegalAccessException,
            InvocationTargetException {
        Object result = null;
        if (query.startsWith("#{") && query.endsWith("}")) {
            String q = query.substring(2, query.length() - 1);
            String prop;
            if (q.indexOf(".") > 0) {
                prop = q.substring(0, q.indexOf("."));
                q = q.substring(q.indexOf(".") + 1);
            } else {
                prop = q;
                q = "";
            }
            result = getObjectProperty(paramMap.get(prop), q);
        }
        return result;
    }

    private Object getObjectProperty(Object entity, String property) throws SecurityException, NoSuchMethodException, IllegalArgumentException, IllegalAccessException, InvocationTargetException {
        while (!property.isEmpty()) {
            String prop;
            if (property.indexOf(".") > 0) {
                prop = property.substring(0, property.indexOf("."));
                property = property.substring(property.indexOf(".") + 1);
            } else {
                prop = property;
                property = "";
            }
            String methodName = "get" + prop.substring(0, 1).toUpperCase() + prop.substring(1);
            Method method = entity.getClass().getMethod(methodName);
            entity = method.invoke(entity, new Object[0]);
        }
        return entity;
    }

    /* CHECK. Dependences */
    public void checkDependences(CheckXmlAdapter adapter) {
        if (adapter.isCheck()) {
            for (CheckXmlAdapter child : adapter.getChildren()) {
                child.setCheck();
                checkDependences(child);
            }
            checkDependences0(adapter);
        } else {
            adapter.setUncheck();
        }
    }

    private void checkDependences0(CheckXmlAdapter adapter) {
        for (String uid : adapter.getDependences()) {
            List<CheckXmlAdapter> dependenAdapters = getAdapterByUid(uid);
            if (dependenAdapters != null) {
                for (CheckXmlAdapter adap:dependenAdapters){
                    adap.setCheck();
                    checkDependences0(adap);
                }
            }
            else{
                //xmlLog.addMessageLog("[Предупреждение] для узла ["+adapter.toString()+"] Не найден элемент картотеки с uid:"+ uid+" !");
            }
        }
    }

    public void checkAdapeterUid(String uid, boolean fl){
        List<CheckXmlAdapter> dependenAdapters = getAdapterByUid(uid);
        if (dependenAdapters != null) {
            for (CheckXmlAdapter adap:dependenAdapters){
                if (fl){
                    adap.setCheck();
                    for (CheckXmlAdapter child : adap.getChildren()) {
                        child.setCheck();
                        checkAdapeter(adap, true);
                    }
                }else
                    adap.setUncheck();
            }
        }
    }

    public void checkAdapeter (CheckXmlAdapter adapter, boolean fl){
        if (fl){
            adapter.setCheck();
            for (CheckXmlAdapter child : adapter.getChildren()) {
                child.setCheck();
                checkAdapeter(adapter, true);
            }
        }
        else
            adapter.setUncheck();
    }



    private void refreshCache() {
        cache = null;
    }

    public List<CheckXmlAdapter> getAdapterByUid(String uid) {
        return getCache().get(uid);
    }

    private Map<String, List<CheckXmlAdapter>> getCache() {
        if (cache == null) {
            long start = new Date().getTime();

            cache = new HashMap<String, List<CheckXmlAdapter>>();
            makeCache(getRootList());

            log.info("create cache: #0 ms", (new Date().getTime() - start));
        }
        return cache;
    }

    private void makeCache(List<? extends CheckXmlAdapter> adapters) {
        for (CheckXmlAdapter adapter : adapters) {
            if (cache.get(adapter.getUid()) != null) {
                log.warn("Not unique uid for adapter: " + adapter.getUid());
                cache.get(adapter.getUid()).add(adapter);
            } else {
                List<CheckXmlAdapter> lst = new ArrayList<CheckXmlAdapter>();
                lst.add(adapter);
                cache.put(adapter.getUid(), lst);
            }
            makeCache(adapter.getChildren());
        }
    }

    public InputStream getUploadContent() {
        return uploadContent;
    }

    public void setUploadContent(InputStream uploadContent) {
        this.uploadContent = uploadContent;
    }

    private void refreshUploadContex() {
        uploadContent = null;
    }

    public void importXML() {
        if (uploadContent == null) {
            return;
        }
        try {
            if (uploadFileName != null && uploadFileName.toLowerCase().endsWith(".xml"))//для поддержки старой версии импорта
                listAttachments.put(XmlExport.FILE_NAME, uploadContent);
            else if (uploadFileName != null && uploadFileName.toLowerCase().endsWith(".zip"))
                extractFromArchive();
            else{
                return;
            }

            if (!listAttachments.containsKey(XmlExport.FILE_NAME)){
                return;
            }

            rootAdapter = JAXBUtils.unmarshal(getPathTempImportFolder()+"/"+XmlExport.FILE_NAME, ArrayUtils.concatenateClasses(exportClasses.toArray(new Class<?>[0]), XmlRootAdapter.class));

            listAttachments.remove(XmlExport.FILE_NAME);
            Set<String> usedCardElementIds = new HashSet<String>();
            updateParents(null, getRootList(), usedCardElementIds);
            for (String ceId: usedCardElementIds){
                CardElementAdapter adap = this.mapCardElementAdapter.get(ceId);
                if (adap != null) adap.setUse(true);
            }
            refreshUploadContex();
            initCardElementTree();
        } catch (JAXBException e) {
            log.error("Error at import of data", e);
        } catch (RuntimeException e) {
            log.error("Error of import", e);
        } catch (IllegalAccessException e) {
            log.error("Error of import", e);
        } catch (InvocationTargetException e) {
            log.error("Error of import", e);
        } catch (IOException e) {
            log.error("Error of import", e);
        }
    }

    @SuppressWarnings("unchecked")
    private void updateParents(CheckXmlAdapter parent, List<? extends CheckXmlAdapter> list, Set<String> lstUseCardElementId) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
        if (parent == null) {
            mapOrgUnit.clear();
            mapCardElementAdapter.clear();
        }
        if (parent != null){
            if (parent.getExpOwner() != null && !parent.getExpOwner().isEmpty())
                mapOrgUnit.put(parent.getExpOwner(), null);
            else
                mapOrgUnit.put(AbstractCheckXmlAdapter.superOwner, null);

            if (parent instanceof CardElementAdapter)
                mapCardElementAdapter.put(((CardElementAdapter)parent).getCode(), (CardElementAdapter)parent);
            else if (parent instanceof GossrvcServiceDocAdapter)
                lstUseCardElementId.addAll(((GossrvcServiceDocAdapter)parent).getUseCardElementCode());
            else if (parent instanceof GossrvcServiceDocTreeAdapter)
                lstUseCardElementId.addAll(((GossrvcServiceDocTreeAdapter)parent).getUseCardElementCode());
            else if (parent instanceof RequestTemplateAdapter)
                lstUseCardElementId.addAll(((RequestTemplateAdapter)parent).getUseCardElementCode());
        }
        for (CheckXmlAdapter adapter : list) {
            adapter.setParent(parent);
            adapter.setRootList(getRootList());
            if (adapter.getExpOwner() != null && !adapter.getExpOwner().isEmpty())
                mapOrgUnit.put(adapter.getExpOwner(), null);
            else
                mapOrgUnit.put(AbstractCheckXmlAdapter.superOwner, null);
            updateParents(adapter, adapter.getChildren(), lstUseCardElementId);

        }

        if (parent != null)
            for (Method method : parent.getClass().getMethods())
                if (method.getAnnotation(XmlImportForSaveList.class) != null) {
                    List<? extends CheckXmlAdapter> listA = (List<? extends CheckXmlAdapter>) method.invoke(parent);
                    for (CheckXmlAdapter child : listA) {
                        child.setParent(parent);
                        updateParents(child, child.getChildren(), lstUseCardElementId);
                    }
                }
    }

    public Map<String, OrgUnit> getMapOrgUnit() {
        return mapOrgUnit;
    }

    private void extractFromArchive() throws IOException{
        if (listAttachments == null)
            listAttachments = new HashMap<String, InputStream>();
        else
            listAttachments.clear();
        ZipInputStream in = new ZipInputStream(uploadContent);
        String pathFolder = getPathTempImportFolder();
        FileUtils.createFolder(pathFolder);
        FileUtils.deleteAllFiles(pathFolder);

        while (true) {
            ZipEntry zipExtract = in.getNextEntry();
            if (zipExtract == null)
                break;
            // Create output file and check required directory
            // Extract unzipped file
            FileUtils.writeInFile(pathFolder+"/"+zipExtract.getName(), in);
            listAttachments.put(zipExtract.getName(), null);
            in.closeEntry();
        }

        in.close();
    }
    public void processSelection(TreeSelectionChangeEvent event) {

        List<Object> selection = new ArrayList<Object>(event.getNewSelection());
        if (selection == null || selection.isEmpty()) return;
        Object currentSelectionKey = selection.get(0);
        UITree tree = (UITree) event.getComponent();
        Object storedKey = tree.getRowKey();
        tree.setRowKey(currentSelectionKey);
        Object data = tree.getRowData();
        tree.setRowKey(storedKey);

        XmlImport xmlImport = ((XmlImport)Component.getInstance(XmlImport.class, false));
        if (data instanceof OrgUnit){
            xmlImport.setOrgUnitForTree((OrgUnit)data);
        }
    }

    public void doSelectOrgUnit(){
        this.orgUnit = this.orgUnitForTree;
        this.mapOrgUnit.put(oldOwner, this.orgUnitForTree);
    }

    public void  clearOrgUnit(){
        this.orgUnit = this.orgUnitForTree;
        this.mapOrgUnit.put(oldOwner, null);
    }

    public void autoSelectOrgUnit() {
        List<OrgUnit> lst = DAOBus.getOrgUnitDAO().getAllOrgUnits();
        // entityManager.createQuery("SELECT u FROM "+OrgUnit.class.getName()+" u").getResultList();
        for (OrgUnit el : lst) {
            if (mapOrgUnit.containsKey(el.getOwner())) {
                mapOrgUnit.put(el.getOwner(), el);
            }
        }
    }

    public void clearSelectOrgUnit(){
        for (String key: mapOrgUnit.keySet())
            mapOrgUnit.put(key, null);

    }

    public CardElement getCardElement(String code){
        CardElementAdapter  adap = this.mapCardElementAdapter.get(code);
        return adap != null ? adap.getCardElement() : null;
    }


    public static void main (String[] arg0) throws InterruptedException{
    }

    public void uploadFile(FileUploadEvent event) throws Exception {
        try {
            if (isMonopoly.tryLock()) {
                try {
                    UploadedFile item = event.getUploadedFile();
                    XmlImport xmlImport = ((XmlImport)Component.getInstance(XmlImport.class, false));
                    xmlImport.setUploadContent(item.getInputStream());
                    xmlImport.setUploadFileName(CorrectBug.correctFileName(item.getName()));
                } finally {
                    isMonopoly.unlock();
                }
            } else {
                XmlImport xmlImport = ((XmlImport)Component.getInstance(XmlImport.class, false));
                xmlImport.refreshUploadContex();
                XmlLog xmlLog = (XmlLog)Component.getInstance(XmlLog.class, false);
                if (xmlLog != null)
                    xmlLog.addMessageLog(message_warn_is_monopoly);
            }
        } catch (Exception e) {
            log.error("Ошибка при загрузки файла", e);
            FacesMessages.instance().add(Severity.ERROR, "Ошибка при загрузки файла: "+e.toString());
        }
    }

    public static String getPathTempImportFolder()  {
        String genPath=System.getProperty("jboss.server.temp.dir");
        if (genPath==null)
            genPath=System.getProperty("jboss.domain.temp.dir");
        genPath += folder_import;
        return genPath;
    }

    public String getExportCompleteView() {
        return exportCompleteView;
    }

    public void setExportCompleteView(String exportCompleteView) {
        this.exportCompleteView = exportCompleteView;
    }



    public List<TreeNode<CardElementAdapter>> getCardElementsNodes(){
        return cardElementTreeNodesAsList;
    }

    /**
     * Инифиализирует дерево импортируемых элементов картотеки для вывода в табличном представлении
     */
    private void initCardElementTree() {
        cardElementTrees = new ArrayList<TreeNode<CardElementAdapter>>();
        List<CheckXmlAdapter> elements = getRootList();
        if (elements != null) {
            for (CheckXmlAdapter element : elements) {
                addCardElementTreeChildrens(cardElementTrees, element, null);
            }
        }
        cardElementTreeNodesAsList = getVisibleCardElementTreeNodesAsList();

    }

    /**
     * Формирует список древовидных импортируемых элементов картотеки(объекты класса <code>CardElementAdapter</code>),
     * оборачивая их классом <code>TreeNode</code> для отображения импортируемых элементов в виде treetable на форме
     * @param elements список импортируемых элементов картотеки
     * @param element импортируемый элемент
     * @param parent родительский элемент импортируемого элемента картотеки
     */

    private void addCardElementTreeChildrens(List<TreeNode<CardElementAdapter>> elements, CheckXmlAdapter element, TreeNode<CardElementAdapter> parent) {

        if (element instanceof CardElementAdapter) {
            CardElementAdapter ceAdapter = (CardElementAdapter)element;
            setParentCardCode(ceAdapter);
            TreeNode<CardElementAdapter> treeNode = new DefaultTreeNode<CardElementAdapter>(parent, ceAdapter);
            if (parent == null) {
                elements.add(treeNode);
            }
            parent = treeNode;
        }
        if (element.getChildren() != null) {
            for (CheckXmlAdapter children : element.getChildren()) {
                addCardElementTreeChildrens(elements, children, parent);
            }
        }
    }

    /**
     * Возвращает все импортируемые элементы картотеки, которые видны в данный момент в таблице для переопределения элементов.
     * <p>Условие видимости:
     * <ul><li>Если элемент картотеки является родительским (не имеет родителя такого же типа(в данном случае <code>CardElementAdapter</code>))</li>
     * <li>Если элемент картотеки является дочерним, то необходимо, чтобы у родителя было проставлено значение <code>Expanded</code></li></ul>
     * @return линейный список всех видимых импортируемых элементов картотеки для отрисовки в таблице treeTable,
     */
    private List<TreeNode<CardElementAdapter>> getVisibleCardElementTreeNodesAsList() {
        List<TreeNode<CardElementAdapter>> res = new ArrayList<TreeNode<CardElementAdapter>>();
        for (TreeNode<CardElementAdapter> cardElementTree : cardElementTrees) {
            addExpandedTreeNodeChildrensToList(res, cardElementTree);
        }
        return res;
    }

    /**
     * добавляет древовидный элемент картотеки в список, если у него выполняется условие видимости:
     * treeNode.getParent() == null || treeNode.getParent().getExpanded()
     * @param treeNodeList линейный список импортируемых элементов картотеки для представления в treeTable
     * @param treeNode анализируемый элемент
     */
    private void addExpandedTreeNodeChildrensToList(List<TreeNode<CardElementAdapter>> treeNodeList,
                                                    TreeNode<CardElementAdapter> treeNode) {
        if (treeNode.getParent() == null || treeNode.getParent().getExpanded()) {
            treeNodeList.add(treeNode);
        }
        if (treeNode.getChildrens() != null) {
            for (TreeNode<CardElementAdapter> children : treeNode.getChildrens()) {
                addExpandedTreeNodeChildrensToList(treeNodeList, children);
            }
        }
    }

    /**
     * Переключает состояние элемента дерева (раскрыт/скрыт) и переформирует линенйный список видимых элементов картотеки для
     * вывода в таблице.
     * @param treeNode выбранный импортируемый элемент картотеки с древовидной иерархией
     */
    public void toggleTreeNodeState(TreeNode<CardElementAdapter> treeNode) {
        treeNode.setExpanded(!treeNode.getExpanded());
        cardElementTreeNodesAsList = getVisibleCardElementTreeNodesAsList();
    }


    /**
     * Возвращает пустой массив заданной размерности.
     * <p>Необходим для элемента a4j:repeat для перебора значений от 1 до length
     * @param length длинна массива
     * @return пустой массив <code>Integer</code> заданной размерности
     */
    public Integer[] createArray(int length) {
        return new Integer[length];
    }

    /**
     * Подменяет импортируемый элемент картотеки (везде, где встречается в импортируемом файле) на тот, который выбран из системы.
     * <p> Если подменяется родительский элемент (групповой элемент), то все дочерние элменты не будут импортированы (Дерево элементов заменяется целиком).
     * При этом замена дочерних элементов блокируется до тех пор, пока не будет сброшено соответствие на уровень выше.
     * <p> Если <code>selectedCardElementId</code> не задан, то соответствие сбрасывается и будут разблокированы все дочерние элементы для переопределения.
     *
     */
    public void replaceCardElement() {
        CardElement currentCardElement =
                (selectedCardElementId != null && !"".equals(selectedCardElementId)) ? DAOBus.getCardElementDAO()
                        .getCardElementById(selectedCardElementId) : null;
        if (currentCardElement != null) {
            replaceSameCardElementsAndBlockChildrens(currentAdapterNode.getData().getCode(), currentCardElement,
                    cardElementTrees, false);
        } else {
            resetCardElementsAndChildrens(currentAdapterNode.getData().getCode(), cardElementTrees, true);
        }
        clearSelectedCard();
    }

    public void clearSelectedCard() {
        setSelectedCardElementId(null);
        setSelectedCardElementName(null);
        setCurrentNode(null);
    }

    /**
     * заменяет все импортируемые элементы картотеки с заданным кодом <code>replaceableCardElementId</code> на элемент картотеки <replaceBy> из системы и блокирует переопределение
     * для дочерних элементов.
     * <p> Метод рекурсивный, поэтому некоторые параметры вынесены в сигнатуру метода для передачи их по цепочке рекурсии.
     * @param replaceableCardElementId код заменяемого импортируемого элемента картотеки
     * @param replacedBy элемент справочника, которым будет заменен импортриуемый элемент
     * @param cardElementTreeNodes дерево ипмортируемых элементов картотеки
     * @param isBlocked <true>, если элемент заблокирован для изменения на форме (нужен для блокирования дочерних элементов в рекурсивном вызове)
     */
    private void replaceSameCardElementsAndBlockChildrens(String replaceableCardElementId,  CardElement replacedBy, List<TreeNode<CardElementAdapter>> cardElementTreeNodes, boolean isBlocked) {
        for (TreeNode<CardElementAdapter> cardElementNode : cardElementTreeNodes) {
            boolean isChildrenBlocked = false;
            if (isBlocked) {
                cardElementNode.setBlocked(true);
                cardElementNode.getData().setCardElement(null);
            }
            //Элемент картотеки найден по коду
            if (replaceableCardElementId.equals(cardElementNode.getData().getCode())) {
                //Устанавливается элемент картотеки из системы, которым будет произведена замена
                cardElementNode.getData().setCardElement(replacedBy);
                // Устанавливается флаг, блокирующий изменения элементов в дереве
                isChildrenBlocked = true;
            }
            if (cardElementNode.hasChildrens()) {
                replaceSameCardElementsAndBlockChildrens(replaceableCardElementId, replacedBy, cardElementNode.getChildrens(), isChildrenBlocked);
            }
        }
    }

    /**
     * Сбрасывает замещение между импортируемым элементом и элементом картотеки из системы.
     * @param resetCardElementId код импортируемого элемента картотеки
     * @param cardElementTreeNodes импортируемые элементы картотеки
     * @param resetState <code>true</true>, если элемент доступен для изменений
     */
    private void resetCardElementsAndChildrens(String resetCardElementId,  List<TreeNode<CardElementAdapter>> cardElementTreeNodes, boolean resetState) {
        boolean isChildrenNeedToResetState = false;
        for (TreeNode<CardElementAdapter> cardElementNode : cardElementTreeNodes) {
            if (resetState) {
                cardElementNode.setBlocked(false);
            }
            if (resetCardElementId.equals(cardElementNode.getData().getCode())) {
                cardElementNode.getData().setCardElement(null);
                isChildrenNeedToResetState = true;
            }
            if (cardElementNode.hasChildrens()) {
                resetCardElementsAndChildrens(resetCardElementId, cardElementNode.getChildrens(), isChildrenNeedToResetState);
            }
        }
    }

    public TreeNode<CardElementAdapter> getCurrentAdapterNode() {
        return currentAdapterNode;
    }

    public void setCurrentNode(TreeNode<CardElementAdapter> currentAdapterNode) {
        this.currentAdapterNode = currentAdapterNode;
    }

    /**
     * Получает по списку UID адаптера элементы, которые были предварительно добавлены в хранилище. Возвращает прокси-сущности,
     * если сущности нет в контексте EntityManager или сущность, если есть.
     * Подробнее {@link javax.persistence.EntityManager#getReference(Class<T> entityClass, Object primaryKey)}
     *
     * @param objectClass Класс объекта для получения
     * @param entityManager
     * @param uids список UID адаптеров
     * @param missingElementsAllowed разрешать пропуск элементов, если <b>true</b> то исключения не будут выбрасываться
     * @return список сущностей из хранилища
     */
    public <T> List<T> getObjectsFromWarehouse(Class<T> objectClass, EntityManager entityManager, List<String> uids, boolean missingElementsAllowed) {
        List<T> objects = new ArrayList<T>();
        for (String objectUid : uids) {
            Object primaryKey = persistedIdsWarehouse.get(objectUid);

            if (primaryKey == null) {
                if (missingElementsAllowed) {
                    throw new IllegalStateException(objectClass.getSimpleName() + " with uid " + objectUid + " doesnt persisted yet");
                } else {
                    continue;
                }
            }

            T object = entityManager.getReference(objectClass, primaryKey);

            if (object == null) {
                if (missingElementsAllowed) {
                    throw new IllegalStateException(objectClass.getSimpleName() + " with id " + primaryKey + " not found");
                } else {
                    continue;
                }
            }

            objects.add(object);
        }
        return objects;
    }

    /**
     * Метод обертка над {@link #getObjectsFromWarehouse(Class<T> objectClass, EntityManager entityManager, List<String> uids, boolean missingElementsAllowed)}
     */
    public <T> List<T> getObjectsFromWarehouse(Class<T> objectClass, EntityManager entityManager, List<String> uids) {
        return getObjectsFromWarehouse(objectClass, entityManager, uids, false);
    }

    public void putObjectToWarehouse(String uid, Object primaryKey) {
        if (uid != null) {
            if (persistedIdsWarehouse.containsKey(uid)) {
                throw new IllegalStateException("uid " + uid + " already added to warehouse");
            }
            persistedIdsWarehouse.put(uid, primaryKey);
        }
    }

    public String getSelectedCardElementName() {
        return selectedCardElementName;
    }

    public void setSelectedCardElementName(String selectedCardElementName) {
        this.selectedCardElementName = selectedCardElementName;
    }


}

