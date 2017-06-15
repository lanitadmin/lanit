INSERT INTO PERMISSION_REF (id, AOBJECT, AACTION)
VALUES (hibernate_sequence.nextval,'Карточка.оценки','разрешена');

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('card_rating', 'Включение создание карточки оценки услуги  (0-откл. 1-вкл.)', '0', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'card_rating', 'Включение создание карточки оценки услуги  (0-откл. 1-вкл.)', '0', hibernate_sequence.nextval, owner FROM org_unit;
