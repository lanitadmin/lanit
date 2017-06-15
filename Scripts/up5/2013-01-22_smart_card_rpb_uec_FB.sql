INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, IS_PASS)
VALUES ('sm_card_rpb_uec_WSDL', 'URL для запроса личных данных по УЭК', 'http://192.168.61.52:83/RUEC.asmx?WSDL', gen_id( hibernate_sequence, 1), NULL, 0);

update app_setting set setting_id = 'sm_card_krasnodar_uec_api' where setting_id = 'sm_card_uec_api'