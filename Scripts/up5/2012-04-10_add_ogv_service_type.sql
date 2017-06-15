INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('SGovLevel', 'Уровень власти', 'Услуги', NULL);

INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence, 1), 'gosOrgGovLevel', 'cardElement=SGovLevel', 1, 'Уровень власти ОГВ', 0, NULL, 'SGosOrg', 0);
INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (gen_id(hibernate_sequence, 1), 'serviceGovLevel', 'cardElement=SGovLevel', 1, 'Уровень власти услуги', 0, NULL, 'SService', 0);

INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('Municip','муниципальный','SGovLevel',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('Feder','федеральный','SGovLevel',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('Regional','региональный','SGovLevel',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('Respub','республиканский','SGovLevel',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('Other','иной','SGovLevel',null);