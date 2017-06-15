ALTER TABLE SOAP_CONTEXT MODIFY INPUTVARS VARCHAR2(1000) NULL;
update soap_options_var set required=1 where required is null;