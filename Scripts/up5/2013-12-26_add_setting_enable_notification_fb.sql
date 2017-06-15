insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
values ('enable_notification', '1 - принимать сообщения клиентом, 0 - нет', '0', gen_id( hibernate_sequence, 1 ), null, null);
