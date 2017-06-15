-- Добавление справочника каталогов электронного архива

INSERT INTO card (card_code,card_name,owner,group_code) VALUES ('SCatElArch','Каталоги электронного архива',null,'Услуги');

-- Добавление нового поля в SDocType

INSERT INTO CARD_FIELD (FIELD_ID, FIELD_CAPTION, FIELD_NAME, FIELD_SIZE, FIELD_TYPE, FIELD_VISIBLE, CARD_CODE,  field_ident,field_required,field_max_value,field_min_value,field_readonly,validator_id)
VALUES (nextval('hibernate_sequence'), 'Каталог электронного документа по умолчанию', 'DefCatElArch', '0', 'cardElement=SCatElArch', 'true', 'SDocType', null, false, null, null, false, '');



