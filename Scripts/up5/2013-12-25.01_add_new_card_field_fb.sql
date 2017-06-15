INSERT INTO CARD_FIELD (FIELD_ID, FIELD_CAPTION, FIELD_NAME, FIELD_SIZE, FIELD_TYPE, FIELD_VISIBLE, CARD_CODE,  field_ident)
VALUES (gen_id( hibernate_sequence, 1 ), 'Период действия с', 'beginActive', '2', 'date', 'true', 'SService', 10);
INSERT INTO CARD_FIELD (FIELD_ID, FIELD_CAPTION, FIELD_NAME, FIELD_SIZE, FIELD_TYPE, FIELD_VISIBLE, CARD_CODE,  field_ident)
VALUES (gen_id( hibernate_sequence, 1 ), 'Период действия по', 'endActive', '2', 'date', 'true', 'SService', 11);

