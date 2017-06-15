INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('gisgmp_archive_count_days', 'Количество дней до попадания начислений и платежей в архив', '365', nextval('hibernate_sequence'), NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'gisgmp_archive_count_days', 'Количество дней до попадания начислений и платежей в архив', '365', nextval('hibernate_sequence'),owner from org_unit;
