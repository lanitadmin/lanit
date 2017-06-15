INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'theme', 'Тема оформления', 'rtk', hibernate_sequence.nextval, owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('theme', 'Тема оформления', 'rtk', hibernate_sequence.nextval, null);



