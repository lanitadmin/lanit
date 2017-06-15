insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'integration_callcenter_use_agi_channel_events','Использовать agi скрипт для обработки сообщений о состоянии звонка(требует настройки диал плана)', '', false, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'integration_callcenter_repeat_call_NO_ANSWER','Перезвонить, через n часов, если заявитель не ответил', '24', false, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'integration_callcenter_repeat_call_BUSY','Перезвонить, через n часов, если занято', '24', false, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'integration_callcenter_max_tries_call_count','Число попыток дозвона до заявителя(-1 не используется)', '-1', false, null);

