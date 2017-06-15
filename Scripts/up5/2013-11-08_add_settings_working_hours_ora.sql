INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('working_hours', 'Рабочие часы', '8,9,10,11,12,13,14,15,16,17', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'working_hours', 'Рабочие часы', '8,9,10,11,12,13,14,15,16,17', hibernate_sequence.nextval, owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('working_hours', 'Рабочие часы', '8,9,10,11,12,13,14,15,16,17', hibernate_sequence.nextval, NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'working_hours', 'Рабочие часы', '8,9,10,11,12,13,14,15,16,17', hibernate_sequence.nextval, owner from org_unit;