drop table gossrvc_service_doc_attr_val;
ALTER TABLE GOSSRVC_DOC_PACKAGE_ATTR_VAL modify (stringvalue varchar2(512));
ALTER TABLE request_attr_val modify (stringvalue varchar2(512));