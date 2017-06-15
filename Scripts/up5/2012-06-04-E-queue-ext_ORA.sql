INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'integration_queue_template_soap', 'интеграция с электронной очередью, шаблон saop запроса', '', hibernate_sequence.nextval, owner from org_unit;


INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('integration_queue_template_soap', 'интеграция с электронной очередью, шаблон saop запроса', '', hibernate_sequence.nextval, null);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval, 'DamaskServiceId', 'string',1,'Код услуги в электронной очереди ',2,null,'SService');



