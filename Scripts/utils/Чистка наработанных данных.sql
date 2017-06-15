delete from BPMS_ACTIVITY_VARIABLE;
delete from BPMS_ACTIVITY;
delete from BPMS_AND_JOIN_ENTRY;
delete from BPMS_ASSIGNMENT;
delete from BPMS_DEADLINE;
delete from BPMS_PROCESS_VARIABLE;
delete from BPMS_PROCESS;

--truncate table BPMS_ACTIVITY_VARIABLE;
--truncate table BPMS_ACTIVITY;
--truncate table BPMS_AND_JOIN_ENTRY;
--truncate table BPMS_ASSIGNMENT;
--truncate table BPMS_DEADLINE;
--truncate table BPMS_PROCESS_VARIABLE;
--truncate table BPMS_PROCESS;

--Пакеты - если надо
--delete from BPMS_XPDL;
--delete from BPMS_PROCESS_MGR;
--Остальные таблицы

delete from FORK_PROCESS_VARIABLE;
delete from FORK_PROCESS;
delete from FORK_PROCESS_SETUP;
--#2
delete from GOSSRVC_APPLICATION;
delete from GOSSRVC_IN_OUT_DOCUMENT_JOURNL;

delete from jcr_attach where mfc_doc_id in (select id from GOSSRVC_DOC_PACKAGE_ITEM);
delete from GOSSRVC_DOC_TO_SELECT;
update GOSSRVC_DOC_PACKAGE_ITEM set parent_id=null;

update JCR_ATTACH set MFC_DOC_ID=null;
update JCR_ATTACH set GOSSRVCDOCPACKAGE_ID=null;
delete from GOSSRVC_DOC_TO_SELECT;
delete from obj_gr_item_appl_ref;
delete from object_group_item_ta;
delete from jcr_attach;
delete from obj_gr_itm_issue_places;
delete from object_group_item;

delete from GOSSRVC_DOC_PACKAGE_ITEM;
delete from GOSSRVC_REGISTRATOR_JOURNAL;

--удаление ресстра оценок
delete from GOSSRVC_RATING_ANSWER;
delete from GOSSRVC_RATING;
delete from GOSSRVC_PACK_RATING;

update print_doc set GOSSRVC_REQUEST_ID=null;
delete from GOSSRVC_REQUEST;
update GOSSRVC_DOC_PACKAGE_ATTR_VAL set PARENT_ID=null;
delete from GOSSRVC_DOC_PACKAGE_ATTR_VAL;
update REQUEST_ATTR_VAL set PARENT_ID=null;
delete from REQUEST_ATTR_VAL;
delete from REQUEST;
delete from print_doc;
delete from kontroller;
delete from pack_variable;
commit;
update GOSSRVC_DOC_PACKAGE set pack_status_id = null;
commit;

delete from pack_status;
update GOSSRVC_DOC_PACKAGE set SOAP_CONTEXT_ID=null;
delete from electronic_queue;

--Удаление переназначений
update REASSIGNED_WORK_ITEM set GOSSRVC_DOC_PACKAGE = null;
update REASSIGNED_WORK_ITEM set REASSIGNS_INFO = null;
delete from REASSIGNED_WORK_ITEM;
delete from REASSIGNS_INFO;

delete from gossrvc_select_service;
delete from gossrvc_doc_package_draft;
delete from GOSSRVC_DOC_PACKAGE;

delete  from OBJ_GR_ITEM_APPL_REF ;

delete from object_group_item_ta;
delete from object_group_item;

delete from gossrvc_appeal;
delete from object_group;

delete from GOSSRVC_OGV_AREA;

--Если чистили пакеты
--delete from xpdl_visability;

delete from SOAP_CONTEXT_VAR;
update SOAP_CONTEXT set LAST_CALC_CONTEXT_ID=null, PARENT_CONTEXT_ID=null;
update SOAP_OPTIONS set CONTEXT_ID=null;
delete from SOAP_CONTEXT_HIST;
delete from SOAP_CONTEXT;

--Логирование
delete from ev_list_attributes;
delete from ev_list;

--Удаление физ и юр лиц
update agent set person_id=null;
update agent set user_id=null;
update USER_REF set agent_id=null;
-- Юр лица
delete from agent;
--Физ лица

delete from RELATIVE_TYPE_PAYMENT;
delete from relative;
delete from person_cased_fullname;
delete from agrm_of_pers_data_proc;
delete from p_identifier;
delete from person;

delete from phone_call_params;

delete from cons_rep_collect_task;
delete from report_fact_param;
delete from cons_history;
