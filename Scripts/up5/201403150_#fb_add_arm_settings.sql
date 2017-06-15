insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('arm_is_server', 
'АРМ в режиме сервера (0 - выкл., 1 - вкл.)', '1', gen_id( hibernate_sequence, 1 ), null);
insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('arm_max_try_pack_send', 
'максимальное число попыток отсылаемых дел', '3', gen_id( hibernate_sequence, 1 ), null);
insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('arm_max_try_import', 
'максимальное число попыток сохранения импортируемых данных', '3', gen_id( hibernate_sequence, 1 ), null);
insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('arm_max_doc_package_receive', 
'максимальное число передаваемых дел на выдачу', '30', gen_id( hibernate_sequence, 1 ), null);
insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('arm_max_doc_package_receive', 
'максимальное число отсылаемых новых дел', '15', gen_id( hibernate_sequence, 1 ), null);
insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('arm_max_doc_package_receive', 
'максимальное число передаваемых дел на выдачу', '30', gen_id( hibernate_sequence, 1 ), null);
insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('arm_receive_doc_package_timer_period', 
'Период вызова таймера приема документов на выдачу (в мин.)', '30', gen_id( hibernate_sequence, 1 ), null);
insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('arm_remote_owner', 
'Код удаленной орг. единицы', null, gen_id( hibernate_sequence, 1 ), null);
insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('arm_send_doc_package_timer_period', 
'Период вызова таймера отсылки новых документов и закрытия дела на выдачу (в мин.)', '10', gen_id( hibernate_sequence, 1 ), null);
insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('arm_import_settings_timer_period', 
'период запуска таймера импорта настроек (в мин.)', '60', gen_id( hibernate_sequence, 1 ), null);