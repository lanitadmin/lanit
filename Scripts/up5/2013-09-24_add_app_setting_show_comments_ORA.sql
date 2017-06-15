insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'show_comments','Видимость кнопки "Оставить отзыв" в ИК: 1-вкл, 0-выкл', '1', null);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'show_comments','Видимость кнопки "Оставить отзыв" в ИК: 1-вкл, 0-выкл', '1', null  from org_unit ou;