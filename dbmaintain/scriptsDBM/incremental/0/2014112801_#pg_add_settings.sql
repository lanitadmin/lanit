insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'allow_extradition','Разрешить передачу дел между орг. ед.', '0', false, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select nextval('hibernate_sequence'), ou.owner,'allow_extradition','Разрешить передачу дел между орг. ед.', '0', false, null from org_unit ou;



insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'extradition_package','Пакет для передачи дела', 'MFC_plus', false, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select nextval('hibernate_sequence'), ou.owner,'extradition_package','Пакет для передачи дела', 'MFC_plus', false, null  from org_unit ou;



insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'extradition_process','Процесс для передачи дела', 'Vidacha', false, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select nextval('hibernate_sequence'), ou.owner,'extradition_process','Процесс для передачи дела', 'Vidacha', false, null from org_unit ou;