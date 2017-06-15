-- !!!!!!! Применять с осторожностью
-- Вместо 'SovetRn' необходимо указать оргюнит, дела которого будем удалять
delete from GOSSRVC_DOC_TO_SELECT where parent_doc_id in (select id from GOSSRVC_DOC_PACKAGE_ITEM where doc_package_id in (select id from securable where owner = 'SovetRn'));
delete from JCR_ATTACH where mfc_doc_id in (select id from GOSSRVC_DOC_PACKAGE_ITEM where doc_package_id in (select id from securable where owner = 'SovetRn'));
delete from JCR_ATTACH where gossrvcdocpackage_id in (select id from securable where owner = 'SovetRn');
delete from GOSSRVC_IN_OUT_DOCUMENT_JOURNL where doc_packageitem_id in (select id from GOSSRVC_DOC_PACKAGE_ITEM where doc_package_id in (select id from securable where owner = 'SovetRn'));
delete from GOSSRVC_DOC_PACKAGE_ITEM where doc_package_id in (select id from securable where owner = 'SovetRn');
delete from GOSSRVC_REGISTRATOR_JOURNAL where doc_package_id in (select id from securable where owner = 'SovetRn');
update GOSSRVC_DOC_PACKAGE set pack_status_id = null where id in (select id from securable where owner = 'SovetRn');
delete from PACK_VARIABLE where pack_status_id in (select id from PACK_STATUS where doc_package_id in (select id from securable where owner = 'SovetRn'));
delete from PACK_STATUS where doc_package_id in (select id from securable where owner = 'SovetRn');
delete from GOSSRVC_APPLICATION where doc_package_id in (select id from securable where owner = 'SovetRn');
delete from KONTROLLER where doc_package_id in (select id from securable where owner = 'SovetRn');
delete from FORK_PROCESS_VARIABLE where fork_process_id in (select id from FORK_PROCESS where fork_process_setup_id in (select id from FORK_PROCESS_SETUP where doc_package_id in (select id from securable where owner = 'SovetRn')));
delete from FORK_PROCESS where fork_process_setup_id in (select id from FORK_PROCESS_SETUP where doc_package_id in (select id from securable where owner = 'SovetRn'));
delete from FORK_PROCESS_SETUP where doc_package_id in (select id from securable where owner = 'SovetRn');
delete from REQUEST_ATTR_VAL where request_id in (select id from REQUEST where doc_package_id in (select id from securable where owner = 'SovetRn'))
delete from REQUEST where doc_package_id in (select id from securable where owner = 'SovetRn');
delete from PRINT_DOC where gossrvc_request_id in (select id from GOSSRVC_REQUEST where doc_package_id in (select id from securable where owner = 'SovetRn'));
delete from GOSSRVC_REQUEST where doc_package_id in (select id from securable where owner = 'SovetRn');
delete from GOSSRVC_RATING_ANSWER where parent_id in (select id from GOSSRVC_RATING where parent_id in (select id from GOSSRVC_PACK_RATING where gossrvc_doc_package_id in (select id from securable where owner = 'SovetRn')))
delete from GOSSRVC_RATING where parent_id in (select id from GOSSRVC_PACK_RATING where gossrvc_doc_package_id in (select id from securable where owner = 'SovetRn'));
delete from GOSSRVC_PACK_RATING where gossrvc_doc_package_id in (select id from securable where owner = 'SovetRn');
delete from GOSSRVC_DOC_PACKAGE_MSG where doc_package_id in (select id from securable where owner = 'SovetRn');
delete from GOSSRVC_DOC_PACKAGE_ATTR_VAL where doc_package_id in (select id from securable where owner = 'SovetRn');
delete from GOSSRVC_DOC_PACKAGE where id in (select id from securable where owner = 'SovetRn');
delete from BPMS_ASSIGNMENT where owner = 'SovetRn';

