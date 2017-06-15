package org.cp.toolsimpl;

import org.cp.cardsystem.CardElement;
import org.cp.dao.RequestTemplateDAO;
import org.cp.gossrvc.*;
import org.cp.gossrvc.applicstatus.ApplicantScope;
import org.cp.sir.dao.ForkProcessDAO;
import org.jboss.seam.Component;
import org.jboss.seam.annotations.AutoCreate;
import org.jboss.seam.annotations.Install;
import org.jboss.seam.annotations.Name;
import ru.lanit.util.Util;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by shubanev on 06.10.15.
 */

@Name("entityToolsBean")
@AutoCreate
@Install(precedence = Install.DEPLOYMENT)
public class EntityToolsBeanExt extends EntityToolsBean {

    /**
     * Временное решение, пока краснодар не обновят до 8.1.*
     *
     * @param docPackageId
     * @param docsFromOgv
     * @return
     */
    public Integer isElectroTransferPossible(Long docPackageId,
        String docsFromOgv) {
        final Integer possible = 1;
        final Integer impossible = 0;

        //если документы перечислены через ',', то это автоматически означает, что документы не имеют электронную интеграцию, т.к. объединяться могут только такие запросы
        if (docsFromOgv.contains(",")) return impossible;

        String[] currRequestDoc = docsFromOgv.split(":");

        if (currRequestDoc.length < 2) {
            return impossible;
        }

        TransferDocStrParser transferDocStr = new TransferDocStrParser();
        transferDocStr.decode(docsFromOgv);

        String currentDocType =  transferDocStr.getDocTypeId();
        String currentDocClass = transferDocStr.getDocClassId();
        Long currentDocPackageItemId = transferDocStr.getRequestedDocPackItemId();


        GossrvcDocPackage docPackage = em.find(GossrvcDocPackage.class,
            docPackageId);

        GossrvcDocPackageItem docPackageItem = null;
        if (transferDocStr.getRequestedDocPackItemId() != null){
            docPackageItem = em.find(GossrvcDocPackageItem.class, transferDocStr.getRequestedDocPackItemId());
        }


        try {
            if (docPackage.getGoal() != null) {
                List<CardElement> applicantType = null;
                List<ApplicantScope> listApplicantScope = null;
                if (docPackageItem != null && docPackageItem.getApplicantOfDocItem() !=null){
                    applicantType = new ArrayList<CardElement>(docPackageItem.getApplicantOfDocItem().getTypeApplicants());
                    listApplicantScope = new ArrayList<ApplicantScope>();
                    listApplicantScope.add(docPackageItem.getApplicantOfDocItem().getApplicantScope());
                }else if (docPackage.getApplicantGroup().isHaveApplicScopeBinds()){
                    listApplicantScope = docPackage.getApplicantGroup().getCurrApplicantScopes();
                    applicantType = new ArrayList<CardElement>(
                        docPackage.getApplicantGroup().getSelectedItem()
                            .getTypeApplicants());
                }else {
                    applicantType = new ArrayList<CardElement>(
                        docPackage.getApplicantGroup().getSelectedItem()
                            .getTypeApplicants());
                }
                // получаем все запросы, отфильтрованные по жизненным ситуациям
                List<GossrvcServiceDocTree> allRequests =
                    GossrvcServiceDocTreeHelper
                        .getRequests(true, docPackage.getGoal(), applicantType, listApplicantScope);

                GossrvcServiceDocTree currentRequest = null;

                // ищем в запросах соответствующий виду и типу документа
                // текущего запроса
                for (GossrvcServiceDocTree request : allRequests) {
                    if (currentDocClass.equals(request.getDocClassId().getId())
                        && currentDocType.equals(request.getDocTypeId()
                        .getId())) {
                        currentRequest = request;
                        break;
                    }
                }


                if (currentRequest != null && Util.isNotTrue(currentRequest.getIntegration())) {
                    return impossible;
                }

                if (currentRequest != null && Util.isEmpty(currentRequest.getProcAdapterId())) {
                    return impossible;
                }

                if (currentRequest != null) {
                    return currentRequest.isIntegr() ? possible : impossible;
                }

                // поиск по шаблонам запросов типов документов, к которым может быть привязан документ
                RequestTemplateDAO
                    requestTemplateDAO = (RequestTemplateDAO) Component.getInstance(RequestTemplateDAO.class, true);
                RequestTemplate template = requestTemplateDAO.getTemplate(currentDocType);

                if (template != null) {
                    return template.isIntegr() ? possible : impossible;
                }

                // поиск адаптера у запроса
                ForkProcessDAO forkProcessDAO = new ForkProcessDAO(em);
                if (forkProcessDAO.isHaveAdapter(currentDocPackageItemId)) {
                    return possible;
                }

                return impossible;
            } else {
                return impossible;
            }
        } catch (Exception e) {
            log.error("error on trying to define possibility of electro transfer, set electro transfer to possible. Error:"
                + e.getMessage());
            e.printStackTrace();

            return impossible;
        }
    }

}
