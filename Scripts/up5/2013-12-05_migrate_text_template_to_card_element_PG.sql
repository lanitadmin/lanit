INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'), 'tempTextDocType', 'cardElement=STextTempl', true, 'Шаблон текста', 0, NULL, 'SDocType', NULL);


INSERT INTO CARD_ELEMENT_FIELD_VALUE(ID, CARD_ELEMENT_ID, FIELD_ID, FIELD_STRING_VALUE)
Select nextval('hibernate_sequence'), t.col1, t.col2, t.col3 
	from (
		SELECT  Distinct  
			dc.DOC_TYPE_ID col1, 
			cf.FIELD_ID col2, 
			(select TEMPLATE_ID from PRINT_DOC_TYPE_TEMPLATE where DOC_TYPE_ID = dc.DOC_TYPE_ID LIMIT 1) col3
  		FROM CARD_FIELD cf,
  		 	PRINT_DOC_TYPE_TEMPLATE dc 
		WHERE cf.FIELD_NAME='tempTextDocType' 
   			and cf.CARD_CODE ='SDocType') t
   	where   t.col1 in (select cs.id from CArd_element cs where cs.card_code = 'SDocType');

INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (nextval('hibernate_sequence'), 'tempTextOgv', 'cardElement=STextTempl', true, 'Шаблон текста', 0, NULL, 'SGosOrg', NULL);

		
INSERT INTO CARD_ELEMENT_FIELD_VALUE(ID, CARD_ELEMENT_ID, FIELD_ID, FIELD_STRING_VALUE)
Select nextval('hibernate_sequence'), t.col1, t.col2, t.col3 
	from (
		SELECT  Distinct  
			dc.OGV_ID col1, 
			cf.FIELD_ID col2, 
			(select TEMPLATE_ID from GOSSRVC_OGV_TEMPLATE where OGV_ID = dc.OGV_ID LIMIT 1) col3
  		FROM CARD_FIELD cf,
  		 	GOSSRVC_OGV_TEMPLATE dc 
		WHERE cf.FIELD_NAME='tempTextOgv' 
   			and cf.CARD_CODE ='SGosOrg') t
   	where   t.col1 in (select cs.id from CArd_element cs where cs.card_code = 'SGosOrg');