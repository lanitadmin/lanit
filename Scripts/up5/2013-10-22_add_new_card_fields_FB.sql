INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (gen_id( hibernate_sequence, 1),'additionalInfoForServices', 'string',true,'Информация о дополнительных или сопутсвующих услугах',1000,null,'SService');

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (gen_id( hibernate_sequence, 1),'orderOfAppeal', 'string',true,'Порядок обжалования',1000,null,'SService');

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (gen_id( hibernate_sequence, 1),'infoResposobilityOfOfficals', 'string',true,'Информация об ответственности должностных лиц',1000,null,'SService');

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (gen_id( hibernate_sequence, 1),'infoOfCompensationForDamage', 'string',true,'Информация о порядке возмещения вреда',1000,null,'SService');