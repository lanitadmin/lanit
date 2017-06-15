insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
values(nextval('hibernate_sequence'), null,'hide_FL_UL_for_OGV','Скрывать реестр ФЛ и ЮЛ для ОГВ (0-нет,1-да)', '0', null);

insert into app_setting (setting_id, setting_name, setting_value, id, owner)
select 'hide_FL_UL_for_OGV','Скрывать реестр ФЛ и ЮЛ для ОГВ (0-нет,1-да)', '0', nextval('hibernate_sequence'), owner from org_unit;