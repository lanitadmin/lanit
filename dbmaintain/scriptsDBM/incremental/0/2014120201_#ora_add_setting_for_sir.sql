insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(hibernate_sequence.nextval, null,'list_process_for_adapter','Список процессов пакета адаптера формат(код процесса 1,наименование 1;код процесса 2,наименование 2)', 'mfc,mfc;mfc2,mfc2;sir,sir', 0, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(hibernate_sequence.nextval, null,'is_auto_transfer_to_root_process','Автоматический переход в родительский процесс (0 -нет, 1 - да)', '1', 0, null);


insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select hibernate_sequence.nextval, ou.owner,'list_process_for_adapter','Список процессов пакета адаптера формат(код процесса 1,наименование 1;код процесса 2,наименование 2)', 'mfc,mfc;mfc2,mfc2;sir,sir', 0, null from org_unit ou;

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select hibernate_sequence.nextval, ou.owner,'is_auto_transfer_to_root_process','Автоматический переход в родительский процесс (0 -нет, 1 - да)', '1', 0, null from org_unit ou;