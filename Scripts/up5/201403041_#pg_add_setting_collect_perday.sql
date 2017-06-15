insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('pentaho_collect_perday', 'Собирать статистику по дням (0-нет,1-да)', '0', nextval('hibernate_sequence'), null);