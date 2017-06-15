--Добавление справочника "Вопросы для консультирования" и его наполнение
INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('SConsult', 'Вопросы для консультирования', 'Услуги', NULL);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('q1','Вопрос1','SConsult',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('q2','Вопрос2','SConsult',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('q3','Вопрос3','SConsult',null);