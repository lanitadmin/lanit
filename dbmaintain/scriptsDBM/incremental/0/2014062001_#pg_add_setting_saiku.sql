INSERT INTO app_setting (id,owner,setting_id,setting_name,setting_value,is_pass) VALUES (nextval('hibernate_sequence'),null,'cons_rep_bi_system_saiku_url','cons_rep_bi_system_saiku_url','',false);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'cons_rep_bi_system_saiku_url','cons_rep_bi_system_saiku_url', '', nextval('hibernate_sequence'), owner, 'Общие' FROM org_unit;


insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(nextval('hibernate_sequence'), null,'integration_saiku','Интеграция с аналитической системой Сайку 1-да 0-нет', '0', null, 'Общие');
INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'integration_saiku','Интеграция с аналитической системой Сайку 1-да 0-нет', '0', nextval('hibernate_sequence'), owner, 'Общие' FROM org_unit;