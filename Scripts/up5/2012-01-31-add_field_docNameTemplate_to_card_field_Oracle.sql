--Добавление поля docNameTemplate (Шаблон наменования документов) для картотеки "Типы документов", тикет 2496
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE, FIELD_REQUIRED)
VALUES (hibernate_sequence.nextval,'docNameTemplate','string',1,'Шаблон наименования документа',500,null,'SDocType', 0);