INSERT INTO CARD_FIELD 
(FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION,
FIELD_SIZE, FIELD_IDENT, CARD_CODE) 
VALUES (gen_id(hibernate_sequence, 1), 'validity', 'integer', 1, 'Срок действия', 20, 4, 'SDocType');