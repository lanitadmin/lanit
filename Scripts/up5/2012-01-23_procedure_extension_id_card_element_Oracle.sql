alter table CARD_ELEMENT  modify (ID varchar2(31));
begin
for i in (select 'alter table '||a.owner||'.'||a.table_name||'  modify ('||ucc1.column_name||' varchar2(31))' as col1
           from all_constraints a, all_constraints b, user_cons_columns ucc1
           where a.constraint_type = 'R'
           and a.r_constraint_name = b.constraint_name
            and a.r_owner  = b.owner
            and b.table_name = 'CARD_ELEMENT'
            and a.constraint_name = ucc1.constraint_name)
loop
  EXECUTE IMMEDIATE i.col1;
  --dbms_output.put_line(i.col1);
end loop;
end;
/
alter table AGENT_CASE  modify (CASE_TYPE_ID varchar2(31));
alter table CONSULT_JOURNAL  modify (TYPE varchar2(31));
alter table DECLARATION_ITEM  modify (PROD_ID varchar2(31));
alter table DECLARATION_ITEM_AUD  modify (PROD_ID varchar2(31));
alter table GOSSRVC_DOC_PACKAGE  modify (SERVICE_ID varchar2(31));
alter table GOSSRVC_DOC_PACKAGE_ITEM  modify (DOC_TYPE_ID varchar2(31));
alter table GOSSRVC_DOC_PACKAGE_ITEM  modify (GOS_ORGAN varchar2(31));
alter table GOSSRVC_DOC_PACKAGE_ITEM  modify (DOC_CLASS_ID varchar2(31));
alter table GOSSRVC_OGV_TEMPLATE  modify (OGV_ID varchar2(31));
alter table GOSSRVC_OGV_TEMPLATE  modify (TEMPLATE_ID varchar2(31));
alter table GOSSRVC_REGISTRATOR_JOURNAL  modify (SERVICE varchar2(31));
alter table GOSSRVC_REQUEST  modify (OGV_ID varchar2(31));
alter table GOSSRVC_SERVICE_DOC  modify (SERVICE_ID varchar2(31));
alter table GOSSRVC_SERVICE_DOC  modify (DOC_TYPE_ID varchar2(31));
alter table GOSSRVC_SERVICE_DOC  modify (DOC_CLASS_ID varchar2(31));
alter table GOSSRVC_SERVICE_TEMPLATE  modify (SERVICE_ID varchar2(31));
alter table GOSSRVC_SERVICE_TEMPLATE  modify (TEMPLATE_ID varchar2(31));
alter table IN_DOC  modify (DOC_TYPE varchar2(31));
alter table LICENSE  modify (STATUS_ID varchar2(31));
alter table LIC_OBJECT  modify (OBJ_TYPE varchar2(31));
alter table LIC_OBJECT  modify (OBJ_PLACE_TYPE varchar2(31));
alter table LIC_OBJECT  modify (ACTIVITY_TYPE varchar2(31));
alter table LIC_OBJECT_AUD  modify (OBJ_TYPE varchar2(31));
alter table LIC_OBJECT_AUD  modify (OBJ_PLACE_TYPE varchar2(31));
alter table LIC_OBJECT_AUD  modify (ACTIVITY_TYPE varchar2(31));
alter table LIC_OBJECT_OPERS  modify (OPERATION_ID varchar2(31));
alter table LIC_OBJECT_PAC  modify (ACTIVITY_TYPE varchar2(31));
alter table OBJECT_GROUP  modify (SERVICE_ID varchar2(31));
alter table OBJECT_GROUP  modify (MAIN_SERVCIE_ID varchar2(31));
alter table PRINT_DOC  modify (DOC_TYPE_ID varchar2(31));
alter table PRINT_DOC_TYPE_TEMPLATE  modify (DOC_TYPE_ID varchar2(31));
alter table PRINT_DOC_TYPE_TEMPLATE  modify (TEMPLATE_ID varchar2(31));
alter table REMOTE_SYSTEM  modify (OGV_ID varchar2(31));
alter table REQUEST  modify (OGV_ID varchar2(31));
alter table RESULT_JOURNAL  modify (ACTIVITY_TYPE_ID varchar2(31));
alter table SERVICE_DOC_VAL  modify (SERVICE_ID varchar2(31));
alter table SERVICE_DOC_VAL  modify (DOC_ID varchar2(31));
alter table SERVICE_INTEGRATION  modify (OGV_ID varchar2(31));
alter table SERVICE_INTEGRATION  modify (SERVICE_ID varchar2(31));
alter table SERVICE_TARIF_VAL  modify (SERVICE_TARIF_ID varchar2(31));