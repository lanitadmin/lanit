INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                 VALUES ('arm_mode', 'режим работы АРМ-а(0 -выкл/ 1 - вкл.)', '0', hibernate_sequence.nextval, NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                 VALUES ('arm_id', 'индентификатор АРМ-а', NULL, hibernate_sequence.nextval, NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                 VALUES ('arm_master_host', 'IP адрес мастер хоста', '0', hibernate_sequence.nextval, NULL);
             
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                VALUES ('arm_webservice_export_wsdl', 'wsdl веб-сервиса экспорта настроек', 'http://127.0.0.1:8080/core-process-coreps-webservices-2.1.1-SNAPSHOT/ExportSetting?wsdl', hibernate_sequence.nextval, NULL);
                
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
                VALUES ('arm_webservice_transmitDocPackage_wsdl', 'wsdl веб-сервиса передачи дела', 'http://127.0.0.1:8080/core-process-coreps-webservices-2.1.1-SNAPSHOT/ManageService?wsdl', hibernate_sequence.nextval, NULL);
                
commit;
