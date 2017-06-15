INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'theme_ik', 'Тема оформления инфокиоска', null, nextval('hibernate_sequence'), owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('theme_ik', 'Тема оформления инфокиоска', null, nextval('hibernate_sequence'), null);



