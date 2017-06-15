package org.cp.timers.notify;

import org.cp.admin.AppSettingsBean;
import org.cp.bpms.SharkDAO;
import org.cp.common.ObjectGroup;
import org.cp.common.ObjectGroupItem;
import org.cp.gossrvc.GossrvcDocPackage;
import org.cp.lod.SharkAPIService;
import org.cp.lodent.Agent;
import org.cp.lodent.User;
import org.cp.lodent.UserDAO;

import ru.lanit.dto.jms.file.AttachMapDTO;

import org.cp.model.common.Person;
import org.cp.sharkimpl.persistanse.model.ActivityEntity;
import org.cp.soap.ExtFunc;
import org.jboss.seam.Component;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.*;
import org.jboss.seam.log.Log;

import ru.lanit.DAOBus;
import ru.lanit.util.Util;

import javax.jms.*;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.persistence.EntityManager;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Класс ставит отправку почты в очередь
 */
@Scope(ScopeType.STATELESS)
@Name("notifyEmailProvider")
public class NotifyEmailProvider implements Serializable {

    @In(create = true)
    private UserDAO userDAO;

    @In(create = true)
    private SharkAPIService sharkAPIService;

    @In(create = true)
    private AppSettingsBean appSettings;

    /**
     * Шаблон сообщения для отправки email
     */
    public static final String EMAIL_TEMPLATE = "Поступила новая задача. \n"
                                                + "<#if serviceName?has_content>Наименование услуги: ${serviceName}; \n</#if>"
                                                                + "<#if applicantName?has_content>Реквизиты заявителя: ${applicantName}; \n</#if>"
                                                                + "<#if packNum?has_content>Номер комплекта документа: ${packNum}; \n</#if>"
                                                                + "<#if packDate?has_content>Дата создания комплекта документов: ${packDate}; \n</#if>"
                                                                + "<#if planDate?has_content>Плановая дата оказания услуги: ${planDate};\n</#if>"
                                                                + "<#if step?has_content>Наименование этапа оказания услуги: ${step}; \n</#if>"
                                                                + "<#if userFrom?has_content>Дата формирования запроса: ${userFrom}; \n</#if>";

    /**
     * Тема сообщения
     */
    private final static String SUBJECT = "Новая задача. <#if step?has_content>Шаг: ${step}; </#if><#if packNum?has_content>КД: ${packNum};</#if>";

    @Logger
    private Log log;

    /**
     * Метод подписан на событие notify.email.
     * При возникновении события отправляет пользователю с логином userLogin сообщение о состоянии услуги на шаге actId
     * на почту, указанную в карточке пользователя
     *
     * @param userLogin - логин пользователя
     * @param actId - шаг
     */
    @Deprecated
    @SuppressWarnings("unused")
    @Observer("notify.email")
    public void onTest(String userLogin, String actId){
        //Если настройка включена, то отправляем уведомление на почту
        if (!appSettings.isEnableEmailNotification()){
            return;
        }
        User user = userDAO.getUserByLogin(userLogin);
        if (user == null){
            log.warn("Пользователь с логином " + userLogin + " не найден");
            return;
        }
        String emailTo = user.getEmail();

        if (Util.isEmpty(emailTo)){
            log.debug("Для пользователя " + userLogin + " не задан email. Отправка уведомления невозможна");
            return;
        }

        ActivityEntity activityEntity = sharkAPIService.getActivityById(actId);

        if (activityEntity == null){
            log.warn("Не удалось получить задачу по идентификатору " + actId);
            return;
        }

        GossrvcDocPackage docPackage = sharkAPIService.getDocPackageByActivityId(actId);

        if (docPackage == null){
            log.warn("Не удалось получить КД по идентификатору " + actId);
            return;
        }
        EntityManager em=(EntityManager)Component.getInstance("entityManager");
        String actName=SharkDAO.getNameActivity(activityEntity, em);

        String userFrom = "";
        User currentUser = DAOBus.getUserDAO().getCurrentUser();
        if (currentUser != null) {
            userFrom = currentUser.getFio();
        }

        Date packDate = docPackage.getPackDate();

        String docTypeName = "";
        String serviceName = "";
        String packNum = "";
        String applicantName = "";

        serviceName = docPackage.getServiceName();
        packNum = docPackage.getPackNum();
        Date planDate = docPackage.getPlanDate();
        ObjectGroup applicantGroup = docPackage.getApplicantGroup();
        if (applicantGroup != null) {
            ObjectGroupItem objectGroupItem = applicantGroup.getSelectedItem();
            if (objectGroupItem != null) {
                Object object = objectGroupItem.getObject();
                objectGroupItem.updateApplicant();

                if (object instanceof Person) {
                    Person person = (Person) object;
                    applicantName =
                        (Util.isEmpty(person.getLastName()) ? "" : person.getLastName() + " ")
                        + (Util.isEmpty(person.getFirstName()) ? "" : person.getFirstName() + " ")
                        + (Util.isEmpty(person.getMiddleName()) ? "" : person.getMiddleName());
                } else if (object instanceof Agent) {
                    applicantName = ((Agent) object).getName();
                }
            }
        }

        Map<String, Object> data = new HashMap<String, Object>();
        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");

        data.put("serviceName", serviceName);
        data.put("packDate", packDate != null ? sdf.format(packDate) : null);
        data.put("applicantName", applicantName);
        data.put("packNum", packNum);
        data.put("planDate", planDate != null ? sdf.format(planDate) : null);
        data.put("step", actName);
        data.put("userFrom", userFrom);

        String message = ExtFunc.executeFreemarker(EMAIL_TEMPLATE, data);


        String subjectTemplate = Util.isEmpty(appSettings.getSetting("send_email_subject")) ? SUBJECT : appSettings.getSetting("send_email_subject");
        String subject = ExtFunc.executeFreemarker(subjectTemplate, data);


        try {
            InitialContext ctx = new InitialContext();
            Queue queue = (Queue) ctx.lookup("java:jboss/exported/emailQueue");
            QueueConnectionFactory connFactory = (QueueConnectionFactory)ctx.lookup("ConnectionFactory");
            QueueConnection queueConn = connFactory.createQueueConnection();
            QueueSession queueSession = queueConn.createQueueSession(true, Session.AUTO_ACKNOWLEDGE);
            QueueSender queueSender = queueSession.createSender(queue);
            try {
                String emailFrom = Util.isEmpty(appSettings.getSetting("send_email_from")) ? "noreply@samara.lanit.ru" : appSettings.getSetting("send_email_from");
                ObjectMessage objectMessage = queueSession.createObjectMessage();
                log.debug("sending email. Info: emailTo = " + emailTo + ", emailFrom = " + emailFrom + ", message = " + message + ", subject = " + subject);
                objectMessage.setStringProperty("emailTo", emailTo);
                objectMessage.setStringProperty("emailFrom", emailFrom);
                objectMessage.setStringProperty("message", message);
                objectMessage.setStringProperty("subject", subject);
                queueSender.send(objectMessage);
                queueSession.commit();
                log.debug("Сообщение успешно поставлено в очередь на отправку");
            } catch (JMSException e) {
                log.error(e.getMessage());
            } finally {
                queueConn.close();
            }
        } catch (NamingException e) {
            log.error(e.getMessage());
        } catch (JMSException e) {
            log.error(e.getMessage());
        }
    }

    /**
     * Метод подписан на событие notify.email.msg
     * При возникновении события отправляет пользователю с логином userLogin сообщение о состоянии услуги на шаге actId
     * на почту, указанную в карточке пользователя
     *
     * @param emailFrom почта отправителя сообщения
     * @param emailTo почта получателя сообщения
     * @param subject тема сообщения
     * @param msg сообщение
     * @param attachMap вложения
     */
    @SuppressWarnings("unused")
    @Observer("notify.email.msg")
    public void onNotify(String emailFrom, String emailTo, String subject, String msg, AttachMapDTO attachMap){
        if (log.isDebugEnabled()) {
            log.debug("sending email. Info: emailTo = " + emailTo + ", emailFrom = " + emailFrom
                      + ", message = " + msg + ", subject = " + subject);
        }

        if (Util.isEmpty(emailFrom)){
            log.debug("не задан email отправителя. Отправка уведомления невозможна");
            return;
        }

        if (Util.isEmpty(emailTo)){
            log.debug("не задан email получателя. Отправка уведомления невозможна");
            return;
        }

        if (Util.isEmpty(subject)){
            log.debug("Не задана тема сообщения. Отправка уведомления невозможна");
            return;
        }

        if (Util.isEmpty(msg)){
            log.debug("Не задано сообщение. Отправка уведомления невозможна");
            return;
        }

        try {
            InitialContext ctx = new InitialContext();
            Queue queue = (Queue) ctx.lookup("java:jboss/exported/emailQueue");
            QueueConnectionFactory connFactory = (QueueConnectionFactory)ctx.lookup("ConnectionFactory");
            QueueConnection queueConn = connFactory.createQueueConnection();
            QueueSession queueSession = queueConn.createQueueSession(true, Session.AUTO_ACKNOWLEDGE);
            QueueSender queueSender = queueSession.createSender(queue);
            try {
                ObjectMessage objectMessage = queueSession.createObjectMessage();
                objectMessage.setStringProperty("emailTo", emailTo);
                objectMessage.setStringProperty("emailFrom", emailFrom);
                objectMessage.setStringProperty("message", msg);
                objectMessage.setStringProperty("subject", subject);
                objectMessage.setObject(attachMap);
                queueSender.send(objectMessage);
                queueSession.commit();
                log.debug("Сообщение успешно поставлено в очередь на отправку");
            } catch (JMSException e) {
                e.printStackTrace();
                log.error(e.getMessage());
            } finally {
                queueConn.close();
            }
        } catch (NamingException e) {
            log.error(e.getMessage());
        } catch (JMSException e) {
            log.error(e.getMessage());
        }
    }
}
