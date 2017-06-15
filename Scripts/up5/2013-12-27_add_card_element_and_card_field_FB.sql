-- Добавление справочника каталогов электронного архива

INSERT INTO card (card_code,card_name,owner,group_code) VALUES ('SCatElArch','Каталоги электронного архива',null,'Услуги');

-- Добавление нового поля в SDocType

INSERT INTO CARD_FIELD (FIELD_ID, FIELD_CAPTION, FIELD_NAME, FIELD_SIZE, FIELD_TYPE, FIELD_VISIBLE, CARD_CODE,  field_ident)
VALUES (gen_id( hibernate_sequence, 1 ), 'Каталог электронного документа по умолчанию', 'DefCatElArch', '0', 'cardElement=SCatElArch', 'true', 'SDocType', null);