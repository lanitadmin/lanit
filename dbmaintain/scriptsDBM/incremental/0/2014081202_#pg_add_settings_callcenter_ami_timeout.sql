insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
	values(nextval('hibernate_sequence'), null,'integration_callcenter_ami_ping_thread_enabled','Активировать поток для пинга ami(используется совместно с integration_callcenter_ami_socket_read_timeout)', '0', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
	values(nextval('hibernate_sequence'), null,'integration_callcenter_ami_ping_thread_interval','Интервал пинга ami', '0', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
	values(nextval('hibernate_sequence'), null,'integration_callcenter_ami_socket_read_timeout','таймаут на чтение ami, после которого производится реконнект, используется совместно с integration_callcenter_ami_ping_thread_enabled', '0', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
	values(nextval('hibernate_sequence'), null,'integration_callcenter_ami_socket_timeout','таймаут ami подключения', '0', false);


	