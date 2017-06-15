insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
values ('auto_queue_free_win', 'Автоматический запуск Свободного окна (1-да, 0-нет)', '0', gen_id( hibernate_sequence, 1 ), null, null);

insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
values ('auto_queue_free_win_period', 'Период автоматического запуска Свободного окна (в секундах)', '30',gen_id( hibernate_sequence, 1 ), null, null);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
select 'auto_queue_free_win', 'Автоматический запуск Свободного окна (1-да, 0-нет)', '0', gen_id( hibernate_sequence, 1 ), owner, null from org_unit;

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
select 'auto_queue_free_win_period', 'Период автоматического запуска Свободного окна (в секундах)', '30', gen_id( hibernate_sequence, 1 ), owner, null from org_unit;