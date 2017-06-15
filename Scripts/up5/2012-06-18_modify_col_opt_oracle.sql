alter table SOAP_OPTIONS_VAR modify (RESTRICTLIST varchar2(512));
update SOAP_OPTIONS set readyForUse=0 where readyForUse is null;
alter table SOAP_CONTEXT drop column testrun;
update SOAP_OPTIONS set realWork=0 where realWork is null;
ALTER TABLE SOAP_OPTIONS_VAR MODIFY PARENT_ID NULL;
ALTER TABLE SOAP_OPTIONS DROP column FROMPROCESS;