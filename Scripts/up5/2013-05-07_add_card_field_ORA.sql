INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (hibernate_sequence.nextval,'isCharging', 'list:integer=0,да;1,нет',1,'Подлежит оплате госпошлины',2,null,'SService',1);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (hibernate_sequence.nextval,'isCharging_SZ', 'list:integer=0,да;1,нет',1,'Оплата госпошлины',2,null,'SZType',1);