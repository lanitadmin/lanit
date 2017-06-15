insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'show_comments','Видимость кнопки "Оставить отзыв" в ИК: 1-вкл, 0-выкл', '1', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'show_comments','Видимость кнопки "Оставить отзыв" в ИК: 1-вкл, 0-выкл', '1', false  from org_unit ou;