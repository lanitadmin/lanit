INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('soap_mkgu_vendor_id', 'Идентификатор вендора', null, hibernate_sequence.nextval, NULL);

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'soap_mkgu_vendor_id', 'Идентификатор вендора', null, hibernate_sequence.nextval, owner FROM org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('send_rating_soap_template', 'шаблон запроса отсылки оценок', 'sendRatingMKGU',  hibernate_sequence.nextval, NULL);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'ReestrId', 'string',1,'Идентификатор в реестре',20,null,'SGosOrg');
