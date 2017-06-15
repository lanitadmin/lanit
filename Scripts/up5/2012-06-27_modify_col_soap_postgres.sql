ALTER TABLE SOAP_CONTEXT ALTER COLUMN INPUTVARS TYPE VARCHAR(1000);
update soap_options_var set required=true where required is null;