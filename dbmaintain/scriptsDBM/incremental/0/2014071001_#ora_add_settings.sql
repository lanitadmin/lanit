insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
values(hibernate_sequence.nextval, null,'show_online_users','Отображать таблицу онлайн пользователей (0-нет, 1-да)', '0', null);
insert into app_setting (setting_id, setting_name, setting_value, id, owner)
select 'show_online_users','Отображать таблицу онлайн пользователей (0-нет, 1-да)', '0', hibernate_sequence.nextval, owner from org_unit;