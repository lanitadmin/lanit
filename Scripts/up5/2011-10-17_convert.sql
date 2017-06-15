CREATE INDEX PACK_STATUS_IDX1 ON PACK_STATUS (DOC_PACKAGE_ID,BEGINS,ENDS);
CREATE INDEX GOSSRVC_REQUEST_IDX1 ON GOSSRVC_REQUEST (OGV_ID);
CREATE INDEX PACK_VARIABLE_IDX1 ON PACK_VARIABLE (DEFINITION_ID, VALUE_STRING);
CREATE INDEX GOSSRVC_DOC_PACKAGE_IDX2 ON GOSSRVC_DOC_PACKAGE (SERVICE_ID);
CREATE INDEX GOSSRVC_DOC_PACKAGE_ITEM_IDX1 ON GOSSRVC_DOC_PACKAGE_ITEM (IS_RESULT);
CREATE INDEX GOSSRVC_DOC_PACKAGE_ITEM_IDX2 ON GOSSRVC_DOC_PACKAGE_ITEM (DOC_LEVEL);
/*
insert into kontroller
select gen_id(HIBERNATE_SEQUENCE,1),p.id,u.id
from GOSSRVC_DOC_PACKAGE p, user_ref u
where not exists(select 1 from kontroller k where k.doc_package_id=p.id) and
exists (select 1 from bpms_process_variable v, bpms_process_variable v1
where v.bpms_definition_id='Komplekt_doc' and v.bpms_value_long=p.id
and v1.bpms_definition_id='Kontr_part' and v1.bpms_value_string=u.login
and v.bpms_process_id=v1.bpms_process_id);
*/