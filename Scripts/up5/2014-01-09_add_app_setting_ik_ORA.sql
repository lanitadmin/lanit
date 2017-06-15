insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'ik_home_uri','URI домашней страницы', '', 0, 'Инфокиоск');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, ou.owner,'ik_home_uri','URI домашней страницы', '', 0, 'Инфокиоск'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(hibernate_sequence.nextval, null,'ik_home_button_name','Наименование кнопки перехода на домашнюю страницу', '', 0, 'Инфокиоск');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select hibernate_sequence.nextval, ou.owner,'ik_home_button_name','Наименование кнопки перехода на домашнюю страницу', '', 0, 'Инфокиоск'  from org_unit ou;