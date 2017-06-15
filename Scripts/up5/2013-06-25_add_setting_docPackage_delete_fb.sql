INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('service_doc_package_delete', 'Отображать кнопку удалить на документе в комплекте документов (0-нет, 1-да)', '1', gen_id(hibernate_sequence, 1), NULL);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'service_doc_package_delete', 'Отображать кнопку удалить на документе в комплекте документов (0-нет, 1-да)', '1', gen_id(hibernate_sequence, 1),owner from org_unit;
