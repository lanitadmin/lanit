INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('product_operator', 'Возможность настройки времени работы опреаторов для вычисления продуктивности', '0', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'product_operator', 'Возможность настройки времени работы опреаторов для вычисления продуктивности', '0', hibernate_sequence.nextval, owner FROM org_unit;