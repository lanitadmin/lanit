INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED) 
VALUES (hibernate_sequence.nextval, 'queue_process', 'string', 1, 'ID процесса (ID пакета,ID процесса)', 255, NULL, 'SService', NULL);