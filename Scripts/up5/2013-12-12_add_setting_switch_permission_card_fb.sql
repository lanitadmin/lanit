insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
values ('isPermissionCard', '0-не проверять, 1-проверять права на операции над картотекой', '0', gen_id( hibernate_sequence, 1), null, null);
