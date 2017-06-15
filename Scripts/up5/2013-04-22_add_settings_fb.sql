INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('rep_providers', 'Путь к печатной форме информации о поставщиках услуг (через ; имя шаблона)', '&__locale=ru_RU&__format=PDF&__report=lodint/mfc/Standard/providersReport.rptdesign;Список поставщиков',gen_id(hibernate_sequence, 1), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'rep_providers', 'Путь к печатной форме информации о поставщиках услуг (через ; имя шаблона)', '&__locale=ru_RU&__format=PDF&__report=lodint/mfc/Standard/providersReport.rptdesign;Список поставщиков',gen_id(hibernate_sequence, 1),owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('rep_consultII', 'Путь к печатной форме информации о консультировании (через ; имя шаблона)', '&__report=lodint/mfc/Standard/consultII.rptdesign; Информация об услуге',gen_id(hibernate_sequence, 1), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'rep_consultII', 'Путь к печатной форме информации о консультировании (через ; имя шаблона)', '&__report=lodint/mfc/Standard/consultII.rptdesign; Информация об услуге',gen_id(hibernate_sequence, 1),owner from org_unit;