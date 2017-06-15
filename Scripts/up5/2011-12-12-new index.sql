ALTER TABLE PERMISSION_REF
ADD CONSTRAINT UNQ1_PERMISSION_REF
UNIQUE (AACTION,AOBJECT);

insert into app_setting (ID, SETTING_ID, SETTING_NAME, SETTING_VALUE) 
values (gen_id(hibernate_sequence, 1), 'rtk_http_url_for_applet', 'HTTP Url приложения для загрузки applet-ов', '');

select gen_id(GEN_BPMS_ACTIVITY, max(oid)+1-gen_id(GEN_BPMS_ACTIVITY,0)) from BPMS_ACTIVITY;
select gen_id(GEN_BPMS_ACTIVITY_VARIABLE, max(oid)+1-gen_id(GEN_BPMS_ACTIVITY_VARIABLE,0)) from BPMS_ACTIVITY_VARIABLE;
select gen_id(GEN_BPMS_AND_JOIN_ENTRY, max(oid)+1-gen_id(GEN_BPMS_AND_JOIN_ENTRY,0)) from BPMS_AND_JOIN_ENTRY;
select gen_id(GEN_BPMS_ASSIGNMENT, max(oid)+1-gen_id(GEN_BPMS_ASSIGNMENT,0)) from BPMS_ASSIGNMENT;
select gen_id(GEN_BPMS_DEADLINE, max(oid)+1-gen_id(GEN_BPMS_DEADLINE,0)) from BPMS_DEADLINE;
select gen_id(GEN_BPMS_GLOBAL_DATA, max(oid)+1-gen_id(GEN_BPMS_GLOBAL_DATA,0)) from BPMS_GLOBAL_DATA;
select gen_id(GEN_BPMS_PARTICIPANT_MAP, max(oid)+1-gen_id(GEN_BPMS_PARTICIPANT_MAP,0)) from BPMS_PARTICIPANT_MAP;
select gen_id(GEN_BPMS_PROCESS, max(oid)+1-gen_id(GEN_BPMS_PROCESS,0)) from BPMS_PROCESS;
select gen_id(GEN_BPMS_PROCESS_MGR, max(oid)+1-gen_id(GEN_BPMS_PROCESS_MGR,0)) from BPMS_PROCESS_MGR;
select gen_id(GEN_BPMS_PROCESS_VARIABLE, max(oid)+1-gen_id(GEN_BPMS_PROCESS_VARIABLE,0)) from BPMS_PROCESS_VARIABLE;
select gen_id(GEN_BPMS_RESOURCE, max(oid)+1-gen_id(GEN_BPMS_RESOURCE,0)) from BPMS_RESOURCE;
select gen_id(GEN_BPMS_XPDL, max(oid)+1-gen_id(GEN_BPMS_XPDL,0)) from BPMS_XPDL;
select gen_id(GEN_HIST_ACTIVITY_VARIABLE, max(oid)+1-gen_id(GEN_HIST_ACTIVITY_VARIABLE,0)) from HIST_ACTIVITY_VARIABLE;
select gen_id(G_BPMS_ACTIVITY_VARIABLE_HIST, max(oid)+1-gen_id(G_BPMS_ACTIVITY_VARIABLE_HIST,0)) from BPMS_ACTIVITY_VARIABLE_HIST;
