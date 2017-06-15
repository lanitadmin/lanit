--можно пока не прогонять
INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('SIdentType', 'Типы удостоверяющих документов', 'Услуги', NULL);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('passport','пасспорт','SIdentType',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('militaryID','военный билет','SIdentType',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('birthСertificate','свидетельство о рождении','SIdentType',null);

INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('SRelType', 'Типы родства', 'Услуги', NULL);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('husband','муж','SRelType',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('wife','жена','SRelType',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('daughter','дочь','SRelType',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('son','сын','SRelType',null);

