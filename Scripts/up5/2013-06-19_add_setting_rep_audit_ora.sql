set define off;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('journal_rep_url', 'Путь к печатной форме журнала аудита системы (через ; имя шаблона)', '&__locale=ru_RU&__format=XLS&__report=lodint/mfc/Standard/audit_journal_report.rptdesign;Журнал аудита системы', hibernate_sequence.nextval, NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'journal_rep_url', 'Путь к печатной форме журнала аудита системы (через ; имя шаблона)', '&__locale=ru_RU&__format=XLS&__report=lodint/mfc/Standard/audit_journal_report.rptdesign;Журнал аудита системы', hibernate_sequence.nextval,owner from org_unit;


