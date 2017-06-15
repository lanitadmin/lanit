INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'isCharging', 'list:integer=0,да;1,нет',true,'Подлежит оплате госпошлины',2,null,'SService',true);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'isCharging_SZ', 'list:integer=0,да;1,нет',true,'Оплата госпошлины',2,null,'SZType',true);