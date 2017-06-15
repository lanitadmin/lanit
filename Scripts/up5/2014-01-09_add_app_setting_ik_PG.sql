insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'ik_home_uri','URI домашней страницы', '', false, 'Инфокиоск');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select nextval('hibernate_sequence'), ou.owner,'ik_home_uri','URI домашней страницы', '', false, 'Инфокиоск'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'ik_home_button_name','Наименование кнопки перехода на домашнюю страницу', '', false, 'Инфокиоск');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select nextval('hibernate_sequence'), ou.owner,'ik_home_button_name','Наименование кнопки перехода на домашнюю страницу', '', false, 'Инфокиоск'  from org_unit ou;