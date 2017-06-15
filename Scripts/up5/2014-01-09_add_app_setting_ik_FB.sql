insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(gen_id( hibernate_sequence, 1 ), null,'ik_home_uri','URI домашней страницы', '', false, 'Инфокиоск');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select gen_id( hibernate_sequence, 1 ), ou.owner,'ik_home_uri','URI домашней страницы', '', false, 'Инфокиоск'  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(gen_id( hibernate_sequence, 1 ), null,'ik_home_button_name','Наименование кнопки возрата на домашнюю страницу', '', false, 'Инфокиоск');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
select gen_id( hibernate_sequence, 1 ), ou.owner,'ik_home_button_name','Наименование кнопки возрата на домашнюю страницу', '', false, 'Инфокиоск'  from org_unit ou;