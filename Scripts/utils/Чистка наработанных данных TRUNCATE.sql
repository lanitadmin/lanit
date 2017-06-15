truncate table BPMS_ACTIVITY_VARIABLE;
truncate table BPMS_ACTIVITY;
truncate table BPMS_AND_JOIN_ENTRY;
truncate table BPMS_ASSIGNMENT;
truncate table BPMS_DEADLINE;
truncate table BPMS_PROCESS_VARIABLE;
truncate table BPMS_PROCESS;

--Пакеты - если надо
--delete from BPMS_XPDL;
--delete from BPMS_PROCESS_MGR;
--Остальные таблицы

truncate table FORK_PROCESS_VARIABLE;
truncate table FORK_PROCESS;
truncate table FORK_PROCESS_SETUP;
--#2
truncate table GOSSRVC_APPLICATION;
truncate table GOSSRVC_IN_OUT_DOCUMENT_JOURNL;

truncate table GOSSRVC_DOC_TO_SELECT;

truncate table GOSSRVC_DOC_TO_SELECT;
truncate table obj_gr_item_appl_ref;
truncate table object_group_item_ta;
truncate table jcr_attach;
truncate table obj_gr_itm_issue_places;
truncate table object_group_item;

truncate table GOSSRVC_DOC_PACKAGE_ITEM;
truncate table GOSSRVC_REGISTRATOR_JOURNAL;

--удаление ресстра оценок
truncate table GOSSRVC_RATING_ANSWER;
truncate table GOSSRVC_RATING;
truncate table GOSSRVC_PACK_RATING;

truncate table GOSSRVC_REQUEST;
truncate table GOSSRVC_DOC_PACKAGE_ATTR_VAL;
truncate table REQUEST_ATTR_VAL;
truncate table REQUEST;
truncate table print_doc;
truncate table kontroller;
truncate table pack_variable;

truncate table pack_status;
truncate table electronic_queue;

--Удаление переназначений
truncate table REASSIGNED_WORK_ITEM;
truncate table REASSIGNS_INFO;

truncate table GOSSRVC_DOC_PACKAGE;

truncate table OBJ_GR_ITEM_APPL_REF ;

truncate table object_group_item_ta;
truncate table object_group_item;

truncate table gossrvc_appeal;
truncate table object_group;

truncate table GOSSRVC_OGV_AREA;

--Если чистили пакеты
--delete from xpdl_visability;

truncate table SOAP_CONTEXT_VAR;
truncate table SOAP_CONTEXT_HIST;
truncate table SOAP_CONTEXT;

--Логирование
truncate table ev_list_attributes;
truncate table ev_list;

--Удаление физ и юр лиц
update USER_REF set agent_id=null;
-- Юр лица
truncate table agent;
--Физ лица

truncate table RELATIVE_TYPE_PAYMENT;
truncate table relative;
truncate table person_cased_fullname;
truncate table agrm_of_pers_data_proc;
truncate table p_identifier;
truncate table person;

truncate table phone_call_params;

truncate table cons_rep_collect_task;
truncate table report_fact_param;
truncate table cons_history;
