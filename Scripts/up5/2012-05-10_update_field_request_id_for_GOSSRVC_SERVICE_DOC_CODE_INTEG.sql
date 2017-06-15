--1)
--необходимо удалить обязательность поля
update RDB$RELATION_FIELDS set
RDB$NULL_FLAG = NULL
where (RDB$FIELD_NAME = 'REQUEST_ID') and
(RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC_CODE_INTEG'); 
 

