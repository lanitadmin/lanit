insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'hide_FL_UL_for_OGV','Скрывать реестр ФЛ и ЮЛ для ОГВ (0-нет,1-да)', '0', null);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'hide_FL_UL_for_OGV','Скрывать реестр ФЛ и ЮЛ для ОГВ (0-нет,1-да)', '0', hibernate_sequence.nextval, owner FROM org_unit;