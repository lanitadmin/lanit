INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, IS_PASS)
VALUES ('sm_card_uec_provider_password_tyumen', 'Пароль провайдера для работы апплета УЭК, Тюмень', 'test', hibernate_sequence.nextval, NULL, 1);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('sm_card_tyumen_uec_api', 'параметр serviceURL для апплета УЭК, Тюмень', 'http://uec.i-teco.ru:8080/cardservice-card-terminal-uecard-service/authorize', hibernate_sequence.nextval, NULL);
