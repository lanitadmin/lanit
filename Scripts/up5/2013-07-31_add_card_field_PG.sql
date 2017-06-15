--1.1)добавление дополнительного поля 'Платная услуга' в картотеку услуга, поле обязательно для заполения
--если тип услуги =0 то услуга платная
--если 1 - оплата услуги не требуется
--!!! Такой скрипт уже был 07-05-2013. Если данное поле уже есть, его необходимо переименовать


--Создание поля

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'isCharging', 'list:integer=0,да;1,нет',true,'Платная услуга',2,null,'SService',true);

--Переименование существующего поля

UPDATE card_field SET FIELD_CAPTION = 'Платная услуга' WHERE FIELD_NAME = 'isCharging'

--1.2)добавление дополнительного поля 'Наименование начисления' (String-255 символов) в картотеку услуга, поле обязательно для заполения

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'bill_for', 'string',true,'Наименование начисления',254,null,'SService', true);

--1.3)добавление дополнительного поля 'Полная сумма начисления' (String-10 символов) в картотеку услуга, поле обязательно для заполения

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'amount', 'string',true,'Полная сумма начисления',10,null,'SService', true);

--1.4)добавление дополнительного поля 'КБК' (String-17 символов) в картотеку услуга, поле обязательно для заполения

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'kbk', 'string',true,'КБК',17,null,'SService', true);


--==========================================================================================================

--2.1) Добавление дополнительного поля в картотеку "Орган государственной власти"

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_inn', 'string',true,'ИНН',10,null,'SGosOrg', true);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_kpp', 'string',true,'КПП',9,null,'SGosOrg', true);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_ogrn', 'string',true,'ОГРН',13,null,'SGosOrg', true);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_okato', 'string',true,'OKATO',11,null,'SGosOrg', true);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_kgadb', 'string',true,'Код главного администратора доходов бюджета',3,null,'SGosOrg', true);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_bankacctype', 'list:integer=1,расчетный;2,текущий;3,корреспондентский',true,'Тип банковского счета',2,null,'SGosOrg',true);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_bankaccount', 'string',true,'Номер банковского счета',20,null,'SGosOrg', true);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_banksubaccount', 'string',true,'Номер субсчета',20,null,'SGosOrg', false);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_bankname', 'string',true,'Наименование Банка, в котором открыт счет',255,null,'SGosOrg', false);


INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_bancorracc', 'string',true,'Номер корреспондентского счета Банка в ЦБ РФ',20,null,'SGosOrg', false);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_bankId', 'list:string=BIK,БИК;SWIFT,SWIFT',true,'Идентификатор банка',6,null,'SGosOrg',true);


INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_bik', 'string',true,'БИК',9,null,'SGosOrg', false);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_swift', 'string',true,'SWIFT',12,null,'SGosOrg', false);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_licacc', 'string',true,'Номер лицевого счета',20,null,'SGosOrg', false);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'),'ogv_ufkname', 'string',true,'Сокращенное наименование органа Федерального казначейства',255,null,'SGosOrg', false);
