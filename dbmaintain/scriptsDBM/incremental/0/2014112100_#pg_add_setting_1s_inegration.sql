insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
values(nextval('hibernate_sequence'), null,'1s_gisgmp_pack_id','Код пакета для интеграции 1С и модулем', '', null);


insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
values(nextval('hibernate_sequence'), null,'1s_gisgmp_process_id','Код процесса для интеграции 1С и с модулем для импорта начисления', '', null);