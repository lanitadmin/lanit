---Добавление и заполнение справочника "Суть обращения"---------
INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('SKonsult', 'Суть обращения', 'Услуги', NULL); 
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES (nextval('hibernate_sequence'),'Справочная информация о МФЦ','SKonsult',null); 
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES (nextval('hibernate_sequence'),'Вопросы,относящиеся к деятельности Росреестра','SKonsult',null); 
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES (nextval('hibernate_sequence'),'Вопросы,относящиеся к деятельности кадастровой палаты Росреестра','SKonsult',null); 
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES (nextval('hibernate_sequence'),'Вопросы,относящиеся к деятельности БТИ','SKonsult',null); 
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES (nextval('hibernate_sequence'),'Прочие ГМУ,не входящие в перечень услуг,предоставляемых МФЦ','SKonsult',null); 
