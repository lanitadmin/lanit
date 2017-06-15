INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('sLicense', 'Статус лицензии', 'Услуги', NULL); 
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('lsActive','Действующая','sLicense',null); 
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('lsSuspended','Приостановленная','sLicense',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('lsCanceled','Аннулированная','sLicense',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('lsLapsed','Истекла','sLicense',null);

INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('tLicense', 'Вид лицензии', 'Услуги', NULL); 
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('tlAlcohol','розничной продажи алкогольной продукции','tLicense',null); 
