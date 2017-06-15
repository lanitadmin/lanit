insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(hibernate_sequence.nextval, null,'allow_extradition','Разрешить передачу дел между орг. ед.', '0', 0, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select hibernate_sequence.nextval, ou.owner,'allow_extradition','Разрешить передачу дел между орг. ед.', '0', 0, null from org_unit ou;



insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(hibernate_sequence.nextval, null,'extradition_package','Пакет для передачи дела', 'MFC_plus', 0, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select hibernate_sequence.nextval, ou.owner,'extradition_package','Пакет для передачи дела', 'MFC_plus', 0, null  from org_unit ou;;



insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(hibernate_sequence.nextval, null,'extradition_process','Процесс для передачи дела', 'Vidacha', 0, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select hibernate_sequence.nextval, ou.owner,'extradition_process','Процесс для передачи дела', 'Vidacha', 0, null from org_unit ou;