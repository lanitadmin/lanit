insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('ik_header', 'Заголовок инфокиоска', '', nextval('hibernate_sequence'), null);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'ik_header', 'Заголовок инфокиоска', '', nextval('hibernate_sequence'), owner from org_unit;