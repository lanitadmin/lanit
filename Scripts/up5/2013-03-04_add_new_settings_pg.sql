INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('rating_card_report', 'Путь к очтету для карточки оцнеки качества оказания улуги (через ; имя шаблона)', null, nextval('hibernate_sequence'), NULL);


INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'rating_card_report', 'Путь к очтету для карточки оцнеки качества оказания улуги (через ; имя шаблона)', null, nextval('hibernate_sequence'), owner FROM org_unit;
