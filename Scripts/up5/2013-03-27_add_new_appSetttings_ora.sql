INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_smev_CEOUI', 'Идентификатор Главного Администратора начислений Федерального Казначейства', '', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_smev_CEOUI', 'Идентификатор Главного Администратора начислений Федерального Казначейства', '', hibernate_sequence.nextval, owner FROM org_unit;


INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_smev_AUI', 'Идентификатор Администратора начислений Федерального Казначейства', '', hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_smev_AUI', 'Идентификатор Администратора начислений Федерального Казначейства', '', hibernate_sequence.nextval, owner FROM org_unit;