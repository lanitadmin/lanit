update app_setting 
set setting_group = 'АРМ'
where setting_id like 'arm_%';

delete FROM app_setting
where setting_id in ('arm_webservice_transmitDocPackage_wsdl', 'arm_webservice_export_wsdl');

update app_setting 
set setting_id = 'arm_webservice_timeout_receive' , setting_name = 'Время ожидания ответа веб-сервиса' 
where setting_id = 'arm_webservice_timeout_min';

update app_setting 
set setting_name = 'Время выполнения веб-сервиса' 
where setting_id = 'arm_webservice_timeout';