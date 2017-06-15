INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('idp_server_create_type_applicant', 'Имя атрибута СИА, задающего тип заявителя (физ. лицо, юр. лицо)', '', hibernate_sequence.nextval, NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('idp_server_create_agent', 'Значение атрибута СИА, соответствующее типу юр. лицо', '', hibernate_sequence.nextval, NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('idp_server_create_person_attr', 'Соответствие полей сущности Person и атрибутов СИА (поле,аттрибут;поле,аттрибут и т.д.)', '', hibernate_sequence.nextval, NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('idp_server_create_agent_attr', 'Соответствие полей сущности Agent и атрибутов СИА (поле,аттрибут;поле,аттрибут и т.д.)', '', hibernate_sequence.nextval, NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('idp_server_attr_person', 'Соответствие полей сущности Person и атрибутов СИА (поле,аттрибут;поле,аттрибут и т.д.)', '', hibernate_sequence.nextval, NULL);