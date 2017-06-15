INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('idp_server_create_type_applicant', 'Атрибут СИА задающий тип заявителя (физ. лицо, юр. лицо)', '', gen_id( hibernate_sequence, 1), NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('idp_server_create_agent', 'Значение атрибута СИА соответствующее агенту', '', gen_id( hibernate_sequence, 1), NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('idp_server_create_person_attr', 'Соответствие полей сущности Person и атрибутов СИА (поле,аттрибут;поле,аттрибут и т.д.)', '', gen_id( hibernate_sequence, 1), NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('idp_server_create_agent_attr', 'Соответствие полей сущности Agent и атрибутов СИА (поле,аттрибут;поле,аттрибут и т.д.)', '', gen_id( hibernate_sequence, 1), NULL);
INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('idp_server_attr_person', 'Соответствие полей сущности Person и атрибутов СИА (поле,аттрибут;поле,аттрибут и т.д.)', '', gen_id( hibernate_sequence, 1), NULL);
