INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, IS_PASS)
VALUES ('sm_card_uec_provider_password_tyumen', 'Пароль провайдера для работы апплета УЭК, Тюмень', 'test', nextval('hibernate_sequence'), NULL, true);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('sm_card_tyumen_uec_api', 'параметр serviceURL для апплета УЭК, Тюмень', 'http://uec.i-teco.ru:8080/cardservice-card-terminal-uecard-service/authorize', nextval('hibernate_sequence'), NULL);
