insert into app_setting (ID, SETTING_ID, SETTING_NAME, SETTING_VALUE) 
values (gen_id(hibernate_sequence, 1), 'rtk_service_responce', 'Адрес сервиса для отправки статуса', 'http://127.0.0.1:8080/core-process-coreps-webservices-2.1.1-SNAPSHOT/StateService?wsdl');

insert into app_setting (ID, SETTING_ID, SETTING_NAME, SETTING_VALUE) 
values (gen_id(hibernate_sequence, 1), 'rtk_service_pack_id', 'Код пакета для запуска услуги', 'MFC_plus');

insert into app_setting (ID, SETTING_ID, SETTING_NAME, SETTING_VALUE) 
values (gen_id(hibernate_sequence, 1), 'rtk_service_process_id', 'Код процесса для запуска услуги', 'Reg_lichno');