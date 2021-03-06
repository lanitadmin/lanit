insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('frgu_timer_period', 'Интервал запуска таймера запроса данных по услугам из РРГУ', '60', nextval('hibernate_sequence'), null);

insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('frgu_send_auto_service_start_time', 'Время начала запроса данных по услугам из РРГУ (с 0 до 24 ч)', '19', nextval('hibernate_sequence'), null);

insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('frgu_send_auto_service_end_time', 'Время окончания запроса данных по услугам из РРГУ (с 0 до 24 ч)', '6', nextval('hibernate_sequence'), null);

insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('frgu_send_auto_service_enable', 'Включить автоматический запрос данных по услугам из РРГУ (0 - выкл., 1 - вкл.)', '0', nextval('hibernate_sequence'), null);

insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('frgu_send_auto_service', 'Код адаптера для запроса данных по услугам из РРГУ', 'integrationFrgu', nextval('hibernate_sequence'), null);