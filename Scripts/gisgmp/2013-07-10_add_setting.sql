INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('gisgmp_process_ct_id', 'Код процесса для запуска формирования шаблона начисления', 'Create_charging_form', nextval('hibernate_sequence'), NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'gisgmp_process_ct_id', 'Код процесса для запуска формирования шаблона начисления', 'Create_charging_form', nextval('hibernate_sequence'),owner from org_unit;
