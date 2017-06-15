INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('address_pattern', 'Шаблон заполнения полей Адрес', '', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'address_pattern', 'Шаблон заполнения полей Адрес', '', nextval('hibernate_sequence'), owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('phone_pattern', 'Шаблон заполнения полей Телефон', '', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'phone_pattern', 'Шаблон заполнения полей Телефон', '', nextval('hibernate_sequence'), owner from org_unit;