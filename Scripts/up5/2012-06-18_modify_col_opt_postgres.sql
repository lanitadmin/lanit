ALTER TABLE SOAP_OPTIONS_VAR ALTER COLUMN restrictlist TYPE VARCHAR(512);
update SOAP_OPTIONS set readyForUse=false where readyForUse is null;
alter table SOAP_CONTEXT drop column testrun;
update SOAP_OPTIONS set realWork=false where realWork is null;
ALTER TABLE SOAP_OPTIONS_VAR ALTER COLUMN PARENT_ID DROP NOT NULL;
ALTER TABLE SOAP_OPTIONS DROP column FROMPROCESS;