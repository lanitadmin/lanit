CREATE INDEX GOSSRVC_DOC_PACKAGE_IDX1
ON GOSSRVC_DOC_PACKAGE (PACK_NUM);

CREATE INDEX AGENT_IDX1
ON AGENT (NAME);

CREATE INDEX PERSON_IDX1
ON PERSON (LAST_NAME);

create index BPMS_PROCESS_VARIABLE_IDX2 on BPMS_PROCESS_VARIABLE (BPMS_DEFINITION_ID, BPMS_VALUE_LONG);
--create index BPMS_PROCESS_VARIABLE_IDX3 on BPMS_PROCESS_VARIABLE (BPMS_VALUE_STRING);  

!!!!!!!!!!!!!!!!
CREATE INDEX FORK_PROCESS_AID_IDX ON FORK_PROCESS (PARENT_ACT_INST_ID);

-- ADDITIONAL_FIELD 
update ADDITIONAL_FIELD 
set model=replace(model,'org.comsoft.', 'org.cp.');
update ADDITIONAL_FIELD 
set model=replace(model,'org.lanit.samara.', 'org.cp.');
update ADDITIONAL_FIELD 
set model=replace(model,'ru.lanit.samara', 'org.cp.');
update ADDITIONAL_FIELD 
set model=replace(model,'org.lanit.', 'org.cp.');
--OBJECT_GROUP_ITEM
update OBJECT_GROUP_ITEM
set OBJECT_CLASS=replace(OBJECT_CLASS,'org.comsoft.', 'org.cp.');
update OBJECT_GROUP_ITEM 
set OBJECT_CLASS=replace(OBJECT_CLASS,'org.lanit.samara.', 'org.cp.');
update OBJECT_GROUP_ITEM 
set OBJECT_CLASS=replace(OBJECT_CLASS,'ru.lanit.samara', 'org.cp.');
update OBJECT_GROUP_ITEM 
set OBJECT_CLASS=replace(OBJECT_CLASS,'org.lanit.', 'org.cp.');
--OBJECT_PROPERTY
update OBJECT_PROPERTY
set OBJECTCLASSNAME=replace(OBJECTCLASSNAME,'org.comsoft.', 'org.cp.');
update OBJECT_PROPERTY 
set OBJECTCLASSNAME=replace(OBJECTCLASSNAME,'org.lanit.samara.', 'org.cp.');
update OBJECT_PROPERTY 
set OBJECTCLASSNAME=replace(OBJECTCLASSNAME,'ru.lanit.samara', 'org.cp.');
update OBJECT_PROPERTY 
set OBJECTCLASSNAME=replace(OBJECTCLASSNAME,'org.lanit.', 'org.cp.');


