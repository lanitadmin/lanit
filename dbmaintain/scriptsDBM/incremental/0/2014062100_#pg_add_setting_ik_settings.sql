insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(nextval('hibernate_sequence'), null,'ik_header_size','Размер заголовков в инфокиоске', '20px', null, 'Инфокиоск');
INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'ik_header_size','Размер заголовков в инфокиоске', '20px', nextval('hibernate_sequence'), owner, 'Инфокиоск' FROM org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(nextval('hibernate_sequence'), null,'ik_text_size','Размер текста в инфокиоске', '18px', null, 'Инфокиоск');
INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'ik_text_size','Размер текста в инфокиоске', '18px', nextval('hibernate_sequence'), owner, 'Инфокиоск' FROM org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) values(nextval('hibernate_sequence'), null,'ik_has_barcode_scanner','Поддержка сканера штрих-кода 1-да 0-нет', '1', null, 'Инфокиоск');
INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
SELECT 'ik_has_barcode_scanner','Поддержка сканера штрих-кода 1-да 0-нет', '1', nextval('hibernate_sequence'), owner, 'Инфокиоск' FROM org_unit;