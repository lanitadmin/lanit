INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (nextval('hibernate_sequence'),'typeResult', 'list:integer=0,не выбрано;1,отказ;2,положительный;',true,'Тип результата',1,null,'SDocType');