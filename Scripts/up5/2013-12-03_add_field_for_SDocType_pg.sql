--1)добавление дополнительного поля  'TypeDay' в картотеку услуга, поле не обязательно для заполения
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,field_required,field_max_value,field_min_value,field_readonly,validator_id)
VALUES (nextval('hibernate_sequence'),'isPayment','list:integer=0,Нет;1,Да',true,'Платежный документ',1,null,'SDocType', false, null, null, false, '');

