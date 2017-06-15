INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'additionalInfoForServices', 'string',1,'Информация о дополнительных или сопутсвующих услугах',1000,null,'SService');

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'orderOfAppeal', 'string',1,'Порядок обжалования',1000,null,'SService');

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'infoResposobilityOfOfficals', 'string',1,'Информация об ответственности должностных лиц',1000,null,'SService');

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'infoOfCompensationForDamage', 'string',1,'Информация о порядке возмещения вреда',1000,null,'SService');

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'ReestrId', 'string',1,'Идентификатор в реестре',20,null,'SGosOrg');