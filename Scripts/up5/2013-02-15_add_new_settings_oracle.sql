INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_smev_FKID', 'Уникальный идентификатор отправителя для работы с Федеральным Казначейством', '', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_smev_FKID', 'Уникальный идентификатор отправителя для работы с Федеральным Казначейством', '', hibernate_sequence.nextval, owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_smev_SystemID', 'Идентификатор системы', '', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_smev_SystemID', 'Идентификатор системы', '', hibernate_sequence.nextval, owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_smev_SystemName', 'Наименование системы', '', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_smev_SystemName', 'Наименование системы', '', hibernate_sequence.nextval, owner FROM org_unit;