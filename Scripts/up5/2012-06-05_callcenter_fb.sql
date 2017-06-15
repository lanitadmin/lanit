-- Интеграция с call центром, тикет 2680
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_sound_dir', 'Путь к звуковым файлам Asterisk', '/opt/jboss-mfc/sounds/', gen_id(hibernate_sequence, 1), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_agi_port', 'AGI, порт сервера, по умолчанию 4573(запускается на сервере приложений)', '4573', gen_id(hibernate_sequence, 1), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_asterisk_host', 'IP адрес Asterisk по умолчанию (127.0.0.1)', '127.0.0.1', gen_id(hibernate_sequence, 1), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_ami_remote_port', 'Asterisk AMI порт ', '5038', gen_id(hibernate_sequence, 1), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_ami_username', ' Asterisk AMI, Имя пользователя (manager.conf)', 'user', gen_id(hibernate_sequence, 1), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_ami_pwd', 'Asterisk AMI, пароль', '1' , gen_id(hibernate_sequence, 1), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_start_on_deploy', 'Запускать модули подсистемы обработки звонков при старте приложения(0-нет, 1-да)', '0', gen_id(hibernate_sequence, 1), null);
     
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_callerid', 'Идентификатор исходящего звонка', '30800', gen_id(hibernate_sequence, 1), null);     

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_permit_call_interval_begin_hour', 'Начало интервала обзвона, в часах (по умолчанию 10)', '10', gen_id(hibernate_sequence, 1), null);     

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_permit_call_interval_end_hour', 'Конец интервала обзвона, в часах (по умолчанию 19)', '19', gen_id(hibernate_sequence, 1), null);    

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_permit_call_days_of_week', 'Допустимые для обзвона дни недели,через запятую(по умолчанию:1,1,1,1,1,0,0), 1-й день пон.', '1,1,1,1,1,0,0', gen_id(hibernate_sequence, 1), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER) 
    VALUES ('integration_callcenter_repeat_call_after_hour', 'Перезванивать через, в часах (по умолчанию 24)', '24', gen_id(hibernate_sequence, 1), null);
