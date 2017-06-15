INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('show_card_ratings', 'Отображать кнопку "Карточка оценки" (1-отображать; 0-скрыть)', '1', nextval('hibernate_sequence'), NULL);
insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'show_card_ratings', 'Отображать кнопку "Карточка оценки" (1-отображать; 0-скрыть)', '1', nextval('hibernate_sequence'), owner from org_unit;