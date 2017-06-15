drop table gossrvc_service_doc_attr_val;
ALTER TABLE GOSSRVC_DOC_PACKAGE_ATTR_VAL ALTER COLUMN stringvalue TYPE VARCHAR(512);
ALTER TABLE request_attr_val ALTER COLUMN stringvalue TYPE VARCHAR(512);