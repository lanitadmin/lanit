-- Срок оказания услуги теперь обязателен для заполнения
update CARD_FIELD set FIELD_REQUIRED = true where FIELD_NAME = 'ddlSrv' and CARD_CODE = 'SService';

update CARD_ELEMENT_FIELD_VALUE set FIELD_INTEGER_VALUE = 0
where FIELD_INTEGER_VALUE is null
and FIELD_ID = (select FIELD_ID from CARD_FIELD where FIELD_NAME = 'ddlSrv' and CARD_CODE = 'SService');



