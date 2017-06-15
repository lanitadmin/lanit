insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'list_process_for_adapter','Список процессов пакета адаптера формат(код процесса 1,наименование 1;код процесса 2,наименование 2)', 'mfc,mfc;mfc2,mfc2;sir,sir', false, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'is_auto_transfer_to_root_process','Автоматический переход в родительский процесс (0 -нет, 1 - да)', '1', false, null);


insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select nextval('hibernate_sequence'), ou.owner,'list_process_for_adapter','Список процессов пакета адаптера формат(код процесса 1,наименование 1;код процесса 2,наименование 2)', 'mfc,mfc;mfc2,mfc2;sir,sir', false, null from org_unit ou;

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select nextval('hibernate_sequence'), ou.owner,'is_auto_transfer_to_root_process','Автоматический переход в родительский процесс (0 -нет, 1 - да)', '1', false, null from org_unit ou;