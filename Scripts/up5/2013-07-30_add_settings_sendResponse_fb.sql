INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_send_response_pack_id_default', 'Пакет XPDL через который идет отправка ответа (по умочанию)', 'adapter', gen_id(hibernate_sequence, 1), null);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_send_response_process_id_default', '	Процесс XPDL через который идет отправка ответа (по умолчанию)', 'mfc2', gen_id(hibernate_sequence, 1), null);