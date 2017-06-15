package org.cp.timers.notify;

import org.cp.admin.AppSettingsBean;
import ru.lanit.dto.jms.file.AttachEntryDTO;
import ru.lanit.dto.jms.file.AttachMapDTO;
import org.jboss.seam.annotations.In;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.annotation.Resource;
import javax.ejb.ActivationConfigProperty;
import javax.ejb.MessageDriven;
import javax.ejb.MessageDrivenContext;
import javax.jms.*;
import javax.jms.Message;
import javax.mail.*;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
import java.io.*;
import java.util.logging.Logger;


/**
 * Created by vtsapaev on 29.07.14.
 */
@SuppressWarnings("unused")
@MessageDriven(name = "NotifyEmailMDB", activationConfig =  {
        @ActivationConfigProperty(propertyName = "destination", propertyValue = "queue/emailQueue"),
        @ActivationConfigProperty(propertyName = "acknowledgeMode", propertyValue = "Auto-acknowledge"),
        @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "javax.jms.Queue")
})
public class NotifyEmailMDB implements MessageListener, Serializable {

    public static final String EMAIL_FROM = "noreply@samara.lanit.ru";
    @Resource
    private MessageDrivenContext mdc;

    @Resource(mappedName = "java:jboss/mail/Default")
    private Session mailSession;

    @In(create = true)
    AppSettingsBean appSettings;

    private Logger logger = Logger.getLogger(NotifyEmailMDB.class.getName());



    /**
     * Метод ожидает MapMessage с заполненными свойствами:
     * emailTo - получатель почты
     * subject - тема почты
     * message - сообщение
     * @param message
     */
    @Override
    public void onMessage(Message message) {
        try {

            ObjectMessage mapMessage = (ObjectMessage) message;

            String emailTo = mapMessage.getStringProperty("emailTo");
            String emailFrom = mapMessage.getStringProperty("emailFrom");
            javax.mail.Message emailMessage = new MimeMessage(mailSession);

            emailMessage.setFrom(new InternetAddress(emailFrom));
            Address toAddress = new InternetAddress(emailTo);
            emailMessage.addRecipient(javax.mail.Message.RecipientType.TO, toAddress);
            emailMessage.setSubject(mapMessage.getStringProperty("subject"));

            Multipart mimeMultipart = new MimeMultipart();

            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(mapMessage.getStringProperty("message"), "text/plain; charset=UTF-8");
            mimeMultipart.addBodyPart(messageBodyPart);

            //добавляем к письму аттачи, если они есть
            AttachMapDTO attachMap = (AttachMapDTO) mapMessage.getObject();
            if (attachMap != null && attachMap.getAttachEntries() != null) {
                for (AttachEntryDTO entry: attachMap.getAttachEntries()) {
                    if (entry == null) {
                        continue;
                    }

                    String fileName = entry.getFilename();
                    DataSource source = new ByteArrayDataSource(entry.getBytes(), "application/octet-stream");
                    MimeBodyPart attachPart = new MimeBodyPart();
                    attachPart.setDataHandler(new DataHandler(source));
                    attachPart.setFileName(fileName);
                    mimeMultipart.addBodyPart(attachPart);
                }
            }
            emailMessage.setContent(mimeMultipart);
            Transport.send(emailMessage);
        } catch (JMSException e) {
            e.printStackTrace();
            mdc.setRollbackOnly();
        } catch (Throwable te) {
            mdc.setRollbackOnly();
            te.printStackTrace();
        }
    }
}
