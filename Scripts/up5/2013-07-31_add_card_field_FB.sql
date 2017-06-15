--1)добавление дополнительного поля 'Платная услуга' в картотеку услуга, поле обязательно для заполения
--если тип услуги =0 то услуга платная
--если 1 - оплата услуги не требуется
--!!! Такой скрипт уже был 07-05-2013. Если данное поле уже есть, его необходимо переименовать


--Создание поля

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'isCharging', 'list:integer=0,да;1,нет',1,'Платная услуга',2,null,'SService',1);

--Переименование существующего поля

UPDATE card_field SET FIELD_CAPTION = 'Платная услуга' WHERE FIELD_NAME = 'isCharging'

--2)добавление дополнительного поля 'Наименование начисления' (String-255 символов) в картотеку услуга, поле обязательно для заполения

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'bill_for', 'string',1,'Наименование начисления',254,null,'SService', 1);

--3)добавление дополнительного поля 'Полная сумма начисления' (String-10 символов) в картотеку услуга, поле обязательно для заполения

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'amount', 'string',1,'Полная сумма начисления',10,null,'SService', 1);

--4)добавление дополнительного поля 'КБК' (String-17 символов) в картотеку услуга, поле обязательно для заполения

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'kbk', 'string',1,'КБК',17,null,'SService', 1);

--====================================================================================================

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_inn', 'string',1,'ИНН',10,null,'SGosOrg', 1);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_kpp', 'string',1,'КПП',9,null,'SGosOrg', 1);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_ogrn', 'string',1,'ОГРН',13,null,'SGosOrg', 1);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_okato', 'string',1,'OKATO',11,null,'SGosOrg', 1);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_kgadb', 'string',1,'Код главного администратора доходов бюджета',3,null,'SGosOrg', 1);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_bankacctype', 'list:integer=1,расчетный;2,текущий;3,корреспондентский',1,'Тип банковского счета',2,null,'SGosOrg',1);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_bankaccount', 'string',1,'Номер банковского счета',20,null,'SGosOrg', 1);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_banksubaccount', 'string',1,'Номер субсчета',20,null,'SGosOrg', 0);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_bankname', 'string',1,'Наименование Банка, в котором открыт счет',255,null,'SGosOrg', 0);


INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_bancorracc', 'string',1,'Номер корреспондентского счета Банка в ЦБ РФ',20,null,'SGosOrg', 0);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_bankId', 'list:string=BIK,БИК;SWIFT,SWIFT',1,'Идентификатор банка',6,null,'SGosOrg',1);


INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_bik', 'string',1,'БИК',9,null,'SGosOrg', 0);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_swift', 'string',1,'SWIFT',12,null,'SGosOrg', 0);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_licacc', 'string',1,'Номер лицевого счета',20,null,'SGosOrg', 0);

INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE,FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence,1),'ogv_ufkname', 'string',1,'Сокращенное наименование органа Федерального казначейства',255,null,'SGosOrg', 0);
