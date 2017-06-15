INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('STypeWork', 'Виды взаимодействия', 'Услуги', NULL); 

INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('sElectroWork','Электронный','STypeWork',null); 
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('sPaperWork','Бумажный','STypeWork',null);

INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'), 'workType', 'cardElement=STypeWork', true, 'Вид взаимодействия', 0, NULL, 'SService', NULL);