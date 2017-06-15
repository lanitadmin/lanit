insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(gen_id(hibernate_sequence, 1), null,'show_comments','Видимость кнопки "Оставить отзыв" в ИК: 1-вкл, 0-выкл', '1', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select gen_id(hibernate_sequence, 1), ou.owner,'show_comments','Видимость кнопки "Оставить отзыв" в ИК: 1-вкл, 0-выкл', '1', false  from org_unit ou;