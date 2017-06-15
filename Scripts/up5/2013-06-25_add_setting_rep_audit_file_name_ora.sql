set define off;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('journal_rep_file_name', 'Имя файла при выгрузке журнала аудита в .xls', 'audit_journal.xls', hibernate_sequence.nextval, NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'journal_rep_file_name', 'Имя файла при выгрузке журнала аудита в .xls', 'audit_journal.xls', hibernate_sequence.nextval,owner from org_unit;
