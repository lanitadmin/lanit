insert into card_group(group_code, owner) VALUES ('Reestr', null);
insert into card(card_code, card_name, group_code, owner) VALUES ('RTypeForm','Печатные формы для регистрационного учета','Reestr', null);
insert into card(card_code, card_name, group_code, owner) VALUES ('ROrgFrom','Органы назначения','Reestr', null);

INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (gen_id( hibernate_sequence, 1 ), 'pathReport', 'string', true, 'Путь до печатной формы', 200, NULL, 'RTypeForm', NULL);

INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (gen_id( hibernate_sequence, 1 ), 'fromAddress', 'string', true, 'Место назначения', 2047, NULL, 'ROrgFrom', NULL);