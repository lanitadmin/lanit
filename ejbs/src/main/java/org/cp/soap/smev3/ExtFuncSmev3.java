package org.cp.soap.smev3;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.net.MalformedURLException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.SignatureException;
import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import java.security.cert.CertificateExpiredException;
import java.security.cert.CertificateFactory;
import java.security.cert.CertificateNotYetValidException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;
import org.apache.xml.security.exceptions.XMLSecurityException;
import org.apache.xml.security.transforms.Transforms;
import org.cp.admin.AppSettingsBean;
import org.cp.gossrvc.GossrvcDocPackageItem;
import org.cp.jcr.AttachedFile;
import org.cp.model.doc.JcrAttach;
import org.cp.sign.wss4j.WSS4J_SignVerifySOAP;
import org.cp.soap.DataSign;
import org.cp.soap.ExtFunc;
import org.cp.soap.FileInfo;
import org.cp.soap.MyException;
import org.cp.soap.SoapContext;
import org.cp.soap.SoapContextFile;
import org.cp.soap.SoapOptions;
import org.cp.soap.SoapQueueResponse;
import org.cp.soap.syncsign.DataSignObjectsFactory;
import org.cp.soap.syncsign.XMLSignatureWrapper;
import org.cp.utils.FileUtil;
import org.jboss.seam.log.Log;
import org.jboss.seam.Component;
import org.jboss.seam.log.Logging;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import ru.lanit.util.Util;
import ru.voskhod.crypto.exceptions.DocumentIsNotSignedException;
import ru.voskhod.crypto.exceptions.SignatureProcessingException;
import ru.voskhod.crypto.exceptions.SignatureValidationException;
import ru.voskhod.smev.message_exchange.autogenerated.service.v1_1.AttachmentSizeLimitExceededException;
import ru.voskhod.smev.message_exchange.autogenerated.service.v1_1.BusinessDataTypeIsNotSupportedException;
import ru.voskhod.smev.message_exchange.autogenerated.service.v1_1.DestinationOverflowException;
import ru.voskhod.smev.message_exchange.autogenerated.service.v1_1.InvalidContentException;
import ru.voskhod.smev.message_exchange.autogenerated.service.v1_1.RecipientIsNotFoundException;
import ru.voskhod.smev.message_exchange.autogenerated.service.v1_1.SMEVFailureException;
import ru.voskhod.smev.message_exchange.autogenerated.service.v1_1.SenderIsNotRegisteredException;
import ru.voskhod.smev.message_exchange.autogenerated.service.v1_1.SignatureVerificationFaultException;
import ru.voskhod.smev.message_exchange.autogenerated.types.v1_1.GetResponseResponse;
import ru.voskhod.smev.message_exchange_service_client.InAttachment;
import ru.voskhod.smev.message_exchange_service_client.OutAttachment;
import ru.voskhod.smev.message_exchange_service_client.SMEVCertificateStore;
import ru.voskhod.smev.message_exchange_service_client.WebServiceClientException;
import ru.voskhod.smev.message_exchange_service_client.datatypes.MessageMetaDataAndSMEVSignature;
import ru.voskhod.smev.message_exchange_service_client.impl.PersonalSignerImpl;

public class ExtFuncSmev3 {
  
  private static Log log=Logging.getLog(ExtFuncSmev3.class);
  public static final String soap_queue_smev3_url="soap_queue_smev3_url";
  public static final String soap_queue_smev3_ftp="soap_queue_smev3_ftp";
  
  private static DataSignObjectsFactory getXMLSignatureFactory(){
    return DataSignObjectsFactory.instance(ExtFunc.getProviderType().name());
  }
  
  public static String signXMLDSigDetached(byte[] xml, PrivateKey argPrivateKey, Certificate argCertificate) 
      throws ParserConfigurationException, SAXException, IOException, TransformerException, XMLSecurityException{

    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    factory.setNamespaceAware(true);
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document argDocument = builder.parse(new ByteArrayInputStream(xml));
    
    Element el=signXMLDSigDetached(argDocument, argPrivateKey, argCertificate);      
    
    DOMSource domSource = new DOMSource(el);
    StringWriter writer = new StringWriter();
    StreamResult result1 = new StreamResult(writer);
    TransformerFactory tf = TransformerFactory.newInstance();
    Transformer transformer = tf.newTransformer();
    transformer.transform(domSource, result1);
    return writer.toString();
  }
  
  /**
   * Отсоедиення подпись XML
   * @param xml
   * @param argPrivateKey
   * @param argCertificate
   * @return
   * @throws ParserConfigurationException
   * @throws SAXException
   * @throws IOException
   * @throws XMLSecurityException
   * @throws TransformerException
   */
  public static Element signXMLDSigDetached(Document argDocument, PrivateKey argPrivateKey, Certificate argCertificate) 
      throws XMLSecurityException{
    ExtFunc.initXmlSign();     
    
    String referenceURI = argDocument.getDocumentElement().getAttribute("Id");

    /* Добавление узла подписи <ds:Signature> в загруженный XML-документ */

    // инициализация объекта формирования ЭЦП в соответствии с алгоритмом ГОСТ Р 34.10-2001
    XMLSignatureWrapper xmlSignature =
        getXMLSignatureFactory().createXmlSignature(argDocument, "", ExtFunc.signMethod,
            Transforms.TRANSFORM_C14N_EXCL_OMIT_COMMENTS);

    /* Определение правил работы с XML-документом и добавление в узел подписи этих правил */

    // создание узла преобразований <ds:Transforms> обрабатываемого XML-документа
    Transforms transforms = new Transforms(argDocument);

    // добавление в узел преобразований правил работы с документом
    transforms.addTransform(Transforms.TRANSFORM_C14N_EXCL_OMIT_COMMENTS);
    transforms.addTransform(SmevTransformSpi.ALGORITHM_URN);

    // добавление в узел подписи ссылок (узла <ds:Reference>), определяющих правила работы с
    // XML-документом (обрабатывается текущий документ с заданными в узле <ds:Transforms> правилами
    // и заданным алгоритмом хеширования)
    String refURI = referenceURI;
    if (!refURI.isEmpty() && !refURI.startsWith("#")) {
      refURI = "#" + refURI;
    }
    xmlSignature.addDocument(refURI, transforms, ExtFunc.digestMethod);

    /*
     * Создание подписи всего содержимого XML-документа на основе закрытого ключа, заданных правил и
     * алгоритмов
     */

    // создание внутри узла подписи узла <ds:KeyInfo> информации об открытом ключе на основе
    // сертификата
    xmlSignature.addKeyInfo((X509Certificate) argCertificate);

    // создание подписи XML-документа
    xmlSignature.sign(argPrivateKey);

    return xmlSignature.getElement();
  }
  
  public static byte[] signPKCS7Detached(byte[] digestedContent, PrivateKey privateKey,
      X509Certificate certificate) throws InvalidKeyException, NoSuchAlgorithmException, SignatureException, IOException {
    PKCS7Tools tools=DataSignObjectsFactory.instance(ExtFunc.getProviderType().name()).createPKCS7Detached();
    return tools.signPKCS7SunSecurity(digestedContent, privateKey, certificate);
  }
  
  public enum TypeRequest {
    sendRequest, getRequest, sendResponse, getResponse, ask;
  }

  /**
   * Полученные файлы
   * @param context
   * @param em
   * @return
   */
  public static List<FileInfo> getResponseFiles(String messageId, SoapContext context, EntityManager em){
    List<FileInfo> list=new ArrayList<FileInfo>();
    for(SoapContextFile i:context.getFiles()){
      if (Util.isEmpty(messageId)||messageId.equals(i.getMessageId()))
        list.add(new FileInfo(i.getName(), i.getMimeType(), i.getUid()));
    }
    return list;
  }
  
  public static Document stringToDocument(String xml) throws ParserConfigurationException, SAXException, IOException{
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    factory.setNamespaceAware(true);
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document argDocument = builder.parse(new ByteArrayInputStream(xml.getBytes()));
    return argDocument;
  }
  
  public static String elementToString(Element el) throws TransformerException{
    DOMSource domSource = new DOMSource(el);
    StringWriter writer = new StringWriter();
    StreamResult result1 = new StreamResult(writer);
    TransformerFactory tf = TransformerFactory.newInstance();
    Transformer transformer = tf.newTransformer();
    transformer.transform(domSource, result1);
    return writer.toString();
  }

  /**
   * Отправка запроса в очередь
   * @param url
   * @param ftp
   * @param attachmentList
   * @param contentString
   * @param context
   * @param em
   * @return
   * @throws Exception
   */
  public static String sendRequestWithDocPackItem(String xml, List<GossrvcDocPackageItem> attachmentList, 
      SoapContext context, EntityManager em) throws Exception{
    List<FileInfo> list=new ArrayList<FileInfo>();
    if (attachmentList!=null){
      for (GossrvcDocPackageItem i:attachmentList){
        for(JcrAttach j:i.getJcrAttachs()){
          AttachedFile af=j.getAttachedFile();
          FileInfo f=new FileInfo(i.getDocTypeId(), j.getFileName(), af.getContentType(), af.getContent());
          list.add(f);
        }
      }
    }
    return sendRequest(xml, list, context, em);
  }
  
  /**
   * Отправка запроса в очередь
   * @param url
   * @param ftp
   * @param attachmentList
   * @param contentString
   * @param context
   * @param em
   * @return
   * @throws Exception
   */
  public static String sendRequest(String xml, List<FileInfo> attachmentList, 
      SoapContext context, EntityManager em) throws Exception{
    SoapOptions soapOptions=context.getParent();
    List<InAttachment> attach=null;
    PersonalSignerImpl signPersonal=null;
    Document doc=null;
    if (xml!=null){
      doc=stringToDocument(xml);
      if (!SoapOptions.TypeSign.none.equals(soapOptions.getTypeSign2())){
        doc.getDocumentElement().setAttribute("Id", "PERSONAL_SIGNATURE");
        doc.getDocumentElement().setIdAttribute("Id", true);
      }
    }
    if (attachmentList!=null)
      attach=new ArrayList<InAttachment>();
    if (SoapOptions.TypeSign.manual.equals(soapOptions.getTypeSign2())){
      if (xml!=null&&!"".equals(xml))
        context.setSystemStatus(null);
      //Подпись на клиенте
      if (context.getSystemStatus()==null){
          if (context.getUid()!=null&&!"".equals(context.getUid())){
              //Чистим предыдущий запрос в JackRabbit
              ExtFunc.deleteAllSoap(context);
          }
          //Сохраняем в JackRabbit для последующей подписи на клиенте
          //context.setXmlId(xmlId);
          context.setXmlExtParam("");
          context.setSystemStatus(SoapContext.SystemStatus.signSMEV3);
          
          //Запакуем
          ByteArrayOutputStream baos = new ByteArrayOutputStream();
          ZipArchiveOutputStream zout = new ZipArchiveOutputStream(baos);
          zout.setLevel(ExtFunc.levelCompressZip);
          //
          String content=elementToString(doc.getDocumentElement());
          //
          ZipArchiveEntry entry = new ZipArchiveEntry("MessagePrimaryContent");
          entry.setSize(content.length());
          zout.putArchiveEntry(entry);
          zout.write(content.getBytes());
          zout.closeArchiveEntry();
          //
          if (attachmentList!=null)
            for(FileInfo i:attachmentList){
              entry = new ZipArchiveEntry(i.getFileName());
              entry.setSize(i.getContentFile().length);
              zout.putArchiveEntry(entry);
              zout.write(ExtFunc.createDigest(i.getContentFile()));
              zout.closeArchiveEntry();
            }
          //
          zout.close();
          String uid=ExtFunc.saveFileToRepo(baos.toByteArray(), "zipForSign"+context.getId(), "zipForSign", "", true);
          context.setUid(uid);
          if (context.getId()!=null)
              em.persist(context);
          return null;
      }
      if (!ExtFunc.existsSignSoap(context.getUid())){
          //Запрос не подписан
          context.setLastError("Контент (данные, файлы) необходимо подписать!");
          if (context.getId()!=null)
              em.persist(context);
          return null;
      }
      //
      if (SoapContext.SystemStatus.signSMEV3.equals(context.getSystemStatus())){
          context.setSystemStatus(SoapContext.SystemStatus.signSoapComlete);
          if (context.getId()!=null)
              em.persist(context);
      }
      Map<String,byte[]> map=ExtFunc.extractFilesFromZip(ExtFunc.fromBase64Byte(ExtFunc.getSignSoap(context.getUid())));
      //Отсоединенная подпись
      if (attachmentList!=null)
        for(FileInfo i:attachmentList){
          FileAttachmentExtImpl f=new FileAttachmentExtImpl(i.getContentFile(),i.getContentType());
          String key=i.getFileName()+".sig";
          if (map.containsKey(key))
            f.setPersonalSignature(map.get(key));
          if (!Util.isEmpty(i.getFileCode()))
            f.setId(i.getFileCode());
          attach.add(f);
        }
      //Подписанный ВС
      String sign = new String(map.get("MessagePrimaryContent.sig"));
      signPersonal = new PersonalSignerImpl(stringToDocument(sign).getDocumentElement());
      //Получим исходный документ
      doc=stringToDocument(new String(map.get("MessagePrimaryContent")));
    }else if (SoapOptions.TypeSign.auto.equals(soapOptions.getTypeSign2())){
      //Автоподпись
      DataSign data = ExtFunc.checkKey(soapOptions, true);
      Certificate cert = data.getCert();
      PrivateKey key = data.getKey();
      //Подпись файлов
      if (attachmentList!=null)
        for(FileInfo i:attachmentList){
          FileAttachmentExtImpl f=new FileAttachmentExtImpl(i.getContentFile(),i.getContentType());
          f.setPersonalSignature(
              signPKCS7Detached(ExtFunc.createDigest(i.getContentByte()), key, (X509Certificate)cert));
          if (!Util.isEmpty(i.getFileCode()))
            f.setId(i.getFileCode());
          attach.add(f);
        }
      //Подпись ВС
      signPersonal = new PersonalSignerImpl(
          signXMLDSigDetached(doc, key, (X509Certificate)cert));
    }
    return baseOperations(TypeRequest.sendRequest, 
        doc.getDocumentElement(), attach, signPersonal, context, em);
  }

  /**
   * Проверка ответа на запрос в очереди
   * @param url
   * @param ftp
   * @param messageId
   * @param context
   * @param em
   * @return
   * @throws Exception
   */
  public static String getResponse(SoapContext context, EntityManager em) throws Exception{
    return baseOperations(TypeRequest.getResponse, 
        null, null, null, context, em);
  }
  
  private static String baseOperations(TypeRequest typeRequest,  
      Element content, List<InAttachment> attachmentList, PersonalSignerImpl signPersonal,  
      SoapContext context, EntityManager em) throws Exception{
    SoapOptions soapOptions=context.getParent();
    
    String url="";
    String ftp="";
    if (soapOptions.getRealWork()){
      url=soapOptions.getUrlReal();
      ftp=soapOptions.getFtpReal();
    }else{
      url=soapOptions.getUrl();
      ftp=soapOptions.getFtp();
    }
    
    DataSign data = ExtFunc.checkKey(soapOptions, true);
    Certificate cert = data.getCert();
    PrivateKey key = data.getKey();
    
    MessageExchangeEndpointExt messageExchange = MessageExchangeEndpointExt.create(
        url, ftp, key, (X509Certificate)cert);

    // отправляем сообщение
    boolean exception=false;
    String err="";
    String request="";
    String response="";
    boolean existsResponse=true;
    try {
        InterceptorStorage.getRequest().setIntercept(true);
        InterceptorStorage.getResponse().setIntercept(true);
      
        if (TypeRequest.sendRequest.equals(typeRequest)){
          // генерация ID сообщения
          String messageID = messageExchange.generateMessageID();

          //
          MessageMetaDataAndSMEVSignature resp=null;
          if (soapOptions.getRealWork())
            resp=messageExchange.sendRequest(messageID, content, signPersonal, null, attachmentList);
          else
            resp=messageExchange.sendTestRequest(messageID, content, signPersonal, null, attachmentList);
          //!!! Проверить - что есть идентификатор - По которому потом можно сопоставлять ответы 
          context.setMessageId(messageID);
          //
          request=InterceptorStorage.getRequest().getString();
          response=InterceptorStorage.getResponse().getString();
        }else if (TypeRequest.getResponse.equals(typeRequest)){
          try{
            //Проверим очередь
            SoapQueueResponse resp=(SoapQueueResponse)
                em.createQuery("SELECT dm FROM SoapQueueResponse dm WHERE dm.messageId=:messageId")
                .setParameter("messageId", context.getMessageId())
                .getSingleResult();
            request=resp.getRequest();
            response=resp.getResponse();
            //
            for(String uid:resp.getMapFiles().keySet()){
              SoapContextFile f=new SoapContextFile();
              String[] arr=resp.getMapFiles().get(uid);
              f.setName(arr[0]);
              f.setMimeType(arr[1]);
              f.setParentContext(context);
              f.setUid(uid);
              f.setMessageId(context.getMessageId());
              em.persist(f);
            }
            em.remove(resp);
          }catch(NoResultException e){
            int j=1;
            while(true){
              if (j>10)
                return null;
              j++;
              GetResponseResponse resResp = messageExchange.getResponse(null);
              if ((resResp == null) || (resResp.getResponseMessage() == null)) {
                //Очередь пуста. Зафиксируем обращение
                request=InterceptorStorage.getRequest().getString();
                response=InterceptorStorage.getResponse().getString();
                existsResponse=false;
                break;
              }
              String idd=resResp.getResponseMessage().getResponse().getOriginalMessageId();
              if (context.getMessageId().equals(idd)){
                //Мой ответ
                request=InterceptorStorage.getRequest().getString();
                response=InterceptorStorage.getResponse().getString();
              }
              //подтверждаем получение ответа
              messageExchange.ack(resResp); 
              //resResp.getResponseMessage().getResponse();
              //!!!!!!!!!!!!!!!!!   Здесь может быть что-то другое
              if (context.getMessageId().equals(idd)){
                //Мой ответ
                List<OutAttachment> attachments = messageExchange.getAttachments(resResp);
                for(OutAttachment i:attachments){
                  ByteArrayOutputStream out=new ByteArrayOutputStream(); 
                  if (i.getContent().retrieve(out)){
                    String uid=FileUtil.saveFileToRepo(out.toByteArray(), i.getName(), null, i.getMimeType());
                    //
                    SoapContextFile f=new SoapContextFile();
                    f.setMimeType(i.getMimeType());
                    f.setName(i.getName());
                    f.setParentContext(context);
                    f.setUid(uid);
                    f.setMessageId(idd);
                    em.persist(f);
                    context.getFiles().add(f);
                  }  
                }
                break;
              }else{
                //Не мой запрос
                Long count=(Long)
                    em.createQuery("SELECT count(dm) FROM SoapQueueResponse dm WHERE dm.messageId=:messageId")
                    .setParameter("messageId", idd)
                    .getSingleResult();
                if (count==0){
                  SoapQueueResponse resp=new SoapQueueResponse();
                  resp.setRequest(InterceptorStorage.getRequest().getString());
                  resp.setResponse(InterceptorStorage.getResponse().getString());
                  resp.setMessageId(idd);
                  List<OutAttachment> attachments = messageExchange.getAttachments(resResp);
                  for(OutAttachment i:attachments){
                    ByteArrayOutputStream out=new ByteArrayOutputStream(); 
                    if (i.getContent().retrieve(out)){
                      String uid=FileUtil.saveFileToRepo(out.toByteArray(), i.getName(), null, i.getMimeType());
                      resp.getMapFiles().put(uid, new String[]{i.getName(),i.getMimeType()});
                    }  
                  }
                  em.persist(resp);
                }  
              }
            }  
          }  
        }
    } catch (Exception e) {
      err=catchException(e);      
      exception=true;
    }

    if (Util.isEmpty(request))
      request=InterceptorStorage.getRequest().getString();
    if (Util.isEmpty(response))
      response=InterceptorStorage.getResponse().getString();
    
    if (context!=null&&em!=null){
      if (context.getLastSendSoap()!=null||!exception)
        context.setLastSendSoap(new Date());
      Boolean checkEdsResponse=true;
      if ("".equals(err)&&context.getParent().getCheckEdsResponse()!=null&&context.getParent().getCheckEdsResponse()){
        //Ошибок нет, проверяем подпись
        try{
          X509Certificate smevCertificate=ExtFunc.signDocVer(response, "SMEVSignature");
          smevCertificate.checkValidity();
          //
          //!!!! Здесь еще можно проверить что сертификат именно СМЭВ (сравнить с сертификатом из хранилища)
          //SMEVCertificateStore.getInstance().isKnown(smevCertificate)
          //
          ExtFunc.checkCertificate(context, response);
        } catch (CertificateExpiredException e) {
          checkEdsResponse=false;
          err="Срок действия сертификата истек";
        } catch (CertificateNotYetValidException e) {
          checkEdsResponse=false;
          err="Сертификат не валиден";
        }catch(Exception e){
          checkEdsResponse=false;
          err="Ошибка при проверке ответа: "+e.getMessage();
        }
      }
      if (context.getId()!=null){
          em.merge(context);
          //
          ExtFunc.saveHistRequest(request, response, !"".equals(err), checkEdsResponse, context, em);
      }
    }
    if (!"".equals(err))
      throw new MyException(err);
    else
      context.setShowBeginButton(false);
    return existsResponse ? response : null;
  }
  
  public static String catchException(Exception e){
    if (e instanceof SenderIsNotRegisteredException)
      return "Система с указанным сертификатом органа власти не зарегистрирована в СМЭВ";
    else if (e instanceof SignatureVerificationFaultException)
      return "Ошибка верификации цифровой подписи";
    else if (e instanceof SMEVFailureException)
      return "Внутренняя ошибка СМЭВ";
    else if (e instanceof RecipientIsNotFoundException)
      return "Ошибка идентификации получателя данных. Возможно неверно указано пространство имен в запросе";
    else if (e instanceof InvalidContentException)
      return "Бизнес-данные не прошли валидацию по схеме вида сведений";
    else if (e instanceof BusinessDataTypeIsNotSupportedException)
      return "Схема для бизнес-данных не зарегистрирована в СМЭВ";
    else if (e instanceof AttachmentSizeLimitExceededException)
      return "Общий размер приложенных файлов превышает ограничение СМЭВ";
    else if (e instanceof ru.voskhod.smev.message_exchange.autogenerated.service.v1_1.AccessDeniedException)
      return "Вашей ИС запрещено посылать запросы такого типа";
    else if (e instanceof DestinationOverflowException)
      return "Очередь запросов к сервису переполнена";
    else {
      e.printStackTrace(System.err);
      return "Внутренняя ошибка клиентской библиотеки";
    }
  }  
  
  /**
   * Получение параметров подписи, url-ов и ftp-адресов
   * @return
   * @throws MyException
   * @throws MalformedURLException
   * @throws WebServiceClientException
   */
  public static MessageExchangeEndpointExt  createMessageExchange() 
      throws MyException, MalformedURLException, WebServiceClientException{
    AppSettingsBean appSettings=(AppSettingsBean)Component.getInstance("appSettings");    
    String url=appSettings.getSetting(ExtFuncSmev3.soap_queue_smev3_url);
    String ftp=appSettings.getSetting(ExtFuncSmev3.soap_queue_smev3_ftp);
    if (Util.isEmpty(url)){
      log.error("Для чтения из очереди запросов СМЭВ3 не задан параметр 'soap_queue_smev3_url'");
      return null;
    }
    if (Util.isEmpty(ftp)){
      log.error("Для чтения из очереди запросов СМЭВ3 не задан параметр 'soap_queue_smev3_ftp'");
      return null;
    }
    DataSign dataSign = DataSign.getInstanceForOrgUnitSettings();
    String keyStoreType = dataSign != null ? dataSign.getKeyStoreType() : System.getProperty("soap_crypto_auto_keyStoreType");
    String alias = dataSign != null ? dataSign.getAlias() : System.getProperty("soap_crypto_auto_alias");
    String password = dataSign != null ? dataSign.getPassword() : System.getProperty("soap_crypto_auto_password");
    //
    DataSign data = ExtFunc.checkKey(keyStoreType, alias, password);
    Certificate cert = data.getCert();
    PrivateKey key = data.getKey();
    //
    MessageExchangeEndpointExt messageExchange = MessageExchangeEndpointExt.create(
        url, ftp, key, (X509Certificate)cert);
    
    return messageExchange;
  }
  
  /**
   * Извлекаем сертификат в формате X509Certificate 
   * @param textSoap
   * @return
   * @throws CertificateException
   */
  public static X509Certificate getCertificateFromXML(String textSoap)
      throws CertificateException {
    String res=getCertificateBase64FromXML(textSoap);
    return ExtFunc.getCertificateFromBASE64(res);
  }

  /**
   * Извлекаем сертификат в формате BASE64
   * @param textSoap
   * @return
   * @throws CertificateException
   */
  public static String getCertificateBase64FromXML(String textSoap)
      throws CertificateException {
    if (textSoap == null || "".equals(textSoap))
      return null;
    
    String key="";
    if (textSoap.indexOf("CallerInformationSystemSignature")!=-1)
      key="CallerInformationSystemSignature";
    else if (textSoap.indexOf("SenderInformationSystemSignature")!=-1)
      key="SenderInformationSystemSignature";
    else if (textSoap.indexOf("SMEVSignature")!=-1)
      key="SMEVSignature";
    else
      return null;
    
    Pattern pattern =
        Pattern
            .compile(
                "<[^<>]*[:]{0,1}"+key+"[^<>]*>.*"+
                "<[^<>]*[:]{0,1}X509Certificate[^<>]*>"+
                    "(.*?)"+
                 "</[^<>]*[:]{0,1}X509Certificate>.*"+                
                 "</[^<>]*[:]{0,1}"+key+">",
                Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);

    Matcher m = pattern.matcher(textSoap);
    if (m.find())
      // Сертификат
      return m.group(1);
    else
      return null;
  }
  
  private void validateSMEVSignature(Element smevSignature, Element content2validate) throws SignatureProcessingException, 
    SignatureValidationException, DocumentIsNotSignedException, ParserConfigurationException {
    if (smevSignature == null)
        throw new SignatureProcessingException("Signature is missing");
    X509Certificate smevCertificate = null;//validateXMLDSig(content2validate, smevSignature);

    // Проверим сертификат СМЭВ на срок действия.
    try {
        smevCertificate.checkValidity();
    } catch (CertificateExpiredException e) {
        throw new SignatureProcessingException("SMEV certificate is expired", e);
    } catch (CertificateNotYetValidException e) {
        throw new SignatureProcessingException("SMEV certificate is not yet valid", e);
    }

    // Проверим сертификат СМЭВ на соответствие тому, который хранится локально.
    try {
        if (!SMEVCertificateStore.getInstance().isKnown(smevCertificate)) {
            throw new SignatureValidationException("SMEV certificate obtained from signature is not identified as one belonging to SMEV");
        }
    } catch (CertificateException e) {
        throw new SignatureProcessingException("SMEV certificate store malfunction", e);
    } catch (IOException e) {
        throw new SignatureProcessingException("SMEV certificate store malfunction", e);
    }
  }
  

  
  
}
