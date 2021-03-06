---прогоняется если не был прогнан скрипт от 2012-01-23 -!!!!
SET TERM ^ ;

create or alter procedure EXTENSIONIDFORCARDELEMENT
as
declare variable P_SQL varchar(255);
declare variable TABLE_NAME varchar(255);
declare variable CONSTR_NAME varchar(255);
begin

  for  SELECT I.RDB$INDEX_NAME as CONSTR_NAME, I.RDB$RELATION_NAME as TABLE_NAME FROM RDB$INDICES  I, RDB$RELATION_CONSTRAINTS T  where I.RDB$RELATION_NAME in (
        'CARD_ELEMENT_DEPENDENCE', 'CARD_ELEMENT_FIELD_VALUE',
        'DOC_TO_DOC_TEMPLATE', 'DOC_TYPE_TEMPALTE_MAP', 'GOSSRVC_OGV_DOC',
        'GOSSRVC_SERVICE_DOC', 'GOSSRVC_SERVICE_DOC_TREE', 
        'LIC_EXT_JOBS', 'LIC_EXT_WASTE', 'OBJ_GR_ITEM_APPL_REF', 'OGV_TO_DOC_TEMPLATE',
        'REQUEST_TEMPLATE', 'SERVICE_DOC_APPLICANTS_REF', 'SERVICE_DOC_TREE_APPLICANTS_RF',
        'SERVICE_DOC_TREE_OGVS_REF', 'SERVICE_DOC_APPLICANTS_REF', 'SERVICE_DOC_TREE_APPLICANTS_RF',
        'TYPE_APPLICATION_TREE')
        and I.RDB$FOREIGN_KEY is null  and  T.RDB$CONSTRAINT_NAME  =  I.RDB$INDEX_NAME

        into :CONSTR_NAME, :TABLE_NAME

  do
  begin
    P_SQL = 'ALTER TABLE '|| :TABLE_NAME||' DROP CONSTRAINT '||:CONSTR_NAME;
    EXECUTE STATEMENT :P_SQL;
  end


  for   select F.RDB$CONSTRAINT_NAME as CONSTR_NAME, F.RDB$RELATION_NAME as table_NAME
        from RDB$REF_CONSTRAINTS C, RDB$RELATION_CONSTRAINTS F, RDB$RELATION_CONSTRAINTS T
        where C.RDB$CONSTRAINT_NAME = F.RDB$CONSTRAINT_NAME and
        T.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ and
        F.RDB$RELATION_NAME in ('CARD_ELEMENT_DEPENDENCE', 'CARD_ELEMENT_FIELD_VALUE',
        'DOC_TO_DOC_TEMPLATE', 'DOC_TYPE_TEMPALTE_MAP', 'GOSSRVC_OGV_DOC',
        'GOSSRVC_SERVICE_DOC', 'GOSSRVC_SERVICE_DOC_TREE', 
        'LIC_EXT_JOBS', 'LIC_EXT_WASTE', 'OBJ_GR_ITEM_APPL_REF', 'OGV_TO_DOC_TEMPLATE',
        'REQUEST_TEMPLATE', 'SERVICE_DOC_APPLICANTS_REF', 'SERVICE_DOC_TREE_APPLICANTS_RF',
        'SERVICE_DOC_TREE_OGVS_REF', 'SERVICE_DOC_APPLICANTS_REF', 'SERVICE_DOC_TREE_APPLICANTS_RF', 'TYPE_APPLICATION_TREE'
      )
      and
      T.RDB$RELATION_NAME = 'CARD_ELEMENT'
      into :CONSTR_NAME, :TABLE_NAME
  do
  begin
    P_SQL = 'ALTER TABLE '|| :TABLE_NAME || ' DROP CONSTRAINT ' || :CONSTR_NAME;
    EXECUTE STATEMENT :P_SQL;
  end

  for select rc.rdb$relation_name as table_NAME, rc.rdb$constraint_name as CONSTR_NAME
        from rdb$relation_constraints rc, rdb$index_segments rs
        where (rc.rdb$constraint_type = 'PRIMARY KEY') and
        (rs.rdb$index_name=rc.rdb$index_name)
        and   rc.rdb$relation_name = 'CARD_ELEMENT'
        into :TABLE_NAME, :CONSTR_NAME
  do
  begin
    P_SQL = 'ALTER TABLE '|| :TABLE_NAME || ' DROP CONSTRAINT ' || :CONSTR_NAME;
    EXECUTE STATEMENT :P_SQL;
  end


   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'CARD_ELEMENT') and (RDB$FIELD_NAME = 'ID'));

   P_SQL = 'ALTER TABLE CARD_ELEMENT ADD PRIMARY KEY (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'CARD_ELEMENT_DEPENDENCE') and (RDB$FIELD_NAME = 'ELEMENT_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'CARD_ELEMENT_DEPENDENCE') and (RDB$FIELD_NAME = 'PARENT_ELEMENT_ID'));

   P_SQL =  'ALTER TABLE CARD_ELEMENT_DEPENDENCE ADD CONSTRAINT FK_CARD_ELEM_100 FOREIGN KEY (ELEMENT_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   P_SQL =  'ALTER TABLE CARD_ELEMENT_DEPENDENCE ADD CONSTRAINT UNQ1_CARD_ELEMENT_DEPENDENCE UNIQUE (ELEMENT_ID, PARENT_ELEMENT_ID, OWNER)';
   EXECUTE STATEMENT :P_SQL;

   P_SQL =  'ALTER TABLE CARD_ELEMENT_DEPENDENCE ADD CONSTRAINT FK_CARD_ELEM_101 FOREIGN KEY (PARENT_ELEMENT_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'CARD_ELEMENT_FIELD_VALUE') and (RDB$FIELD_NAME = 'CARD_ELEMENT_ID'));

   P_SQL =  'ALTER TABLE CARD_ELEMENT_FIELD_VALUE ADD CONSTRAINT UNQ1_CARD_ELEMENT_FIELD_VALUE UNIQUE (CARD_ELEMENT_ID, FIELD_ID)';
   EXECUTE STATEMENT :P_SQL;


   P_SQL =  'ALTER TABLE CARD_ELEMENT_FIELD_VALUE ADD CONSTRAINT FK_CARD_ELEM_102 FOREIGN KEY (CARD_ELEMENT_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'DOC_TO_DOC_TEMPLATE') and (RDB$FIELD_NAME = 'DOC_TEMP_ID'));


    P_SQL =  'ALTER TABLE DOC_TO_DOC_TEMPLATE ADD CONSTRAINT FK_CARD_ELEM_103 FOREIGN KEY (DOC_TEMP_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'DOC_TO_DOC_TEMPLATE') and (RDB$FIELD_NAME = 'DOC_CLASS_ID'));

   P_SQL =  'ALTER TABLE DOC_TO_DOC_TEMPLATE ADD CONSTRAINT FK_CARD_ELEM_104 FOREIGN KEY (DOC_CLASS_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'DOC_TYPE_TEMPALTE_MAP') and (RDB$FIELD_NAME = 'DOC_TYPE_ID'));

   P_SQL =  'ALTER TABLE DOC_TYPE_TEMPALTE_MAP ADD CONSTRAINT FK_CARD_ELEM_105 FOREIGN KEY (DOC_TYPE_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'GOSSRVC_OGV_DOC') and (RDB$FIELD_NAME = 'DOC_TYPE_ID'));

   P_SQL =  'ALTER TABLE GOSSRVC_OGV_DOC ADD CONSTRAINT FK_CARD_ELEM_106 FOREIGN KEY (DOC_TYPE_ID) REFERENCES CARD_ELEMENT (ID) ON DELETE NO ACTION ON UPDATE NO ACTION';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'GOSSRVC_OGV_DOC') and (RDB$FIELD_NAME = 'DOC_CLASS_ID'));

    P_SQL =  'ALTER TABLE GOSSRVC_OGV_DOC ADD CONSTRAINT FK_CARD_ELEM_107 FOREIGN KEY (DOC_CLASS_ID) REFERENCES CARD_ELEMENT (ID) ON DELETE NO ACTION ON UPDATE NO ACTION';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC') and (RDB$FIELD_NAME = 'SERVICE_ID'));

    P_SQL =  'ALTER TABLE GOSSRVC_SERVICE_DOC ADD CONSTRAINT FK_CARD_ELEM_110 FOREIGN KEY (SERVICE_ID) REFERENCES CARD_ELEMENT (ID) ON DELETE NO ACTION ON UPDATE NO ACTION';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC') and (RDB$FIELD_NAME = 'DOC_TYPE_ID'));

    P_SQL =  'ALTER TABLE GOSSRVC_SERVICE_DOC ADD CONSTRAINT FK_CARD_ELEM_111 FOREIGN KEY (DOC_TYPE_ID) REFERENCES CARD_ELEMENT (ID) ON DELETE NO ACTION ON UPDATE NO ACTION';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC') and (RDB$FIELD_NAME = 'DOC_CLASS_ID'));

    P_SQL =  'ALTER TABLE GOSSRVC_SERVICE_DOC ADD CONSTRAINT FK_CARD_ELEM_112 FOREIGN KEY (DOC_CLASS_ID) REFERENCES CARD_ELEMENT (ID) ON DELETE NO ACTION ON UPDATE NO ACTION';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC_TREE') and (RDB$FIELD_NAME = 'DOC_CLASS_ID'));

    P_SQL =  'ALTER TABLE GOSSRVC_SERVICE_DOC_TREE ADD CONSTRAINT FK_CARD_ELEM_113 FOREIGN KEY (DOC_CLASS_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC_TREE') and (RDB$FIELD_NAME = 'SERVICE_ID'));

    P_SQL =  'ALTER TABLE GOSSRVC_SERVICE_DOC_TREE ADD CONSTRAINT FK_CARD_ELEM_114 FOREIGN KEY (SERVICE_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC_TREE') and (RDB$FIELD_NAME = 'DOC_TYPE_ID'));

    P_SQL =  'ALTER TABLE GOSSRVC_SERVICE_DOC_TREE ADD CONSTRAINT FK_CARD_ELEM_115 FOREIGN KEY (DOC_TYPE_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'LIC_EXT_JOBS') and (RDB$FIELD_NAME = 'JOB'));

    P_SQL =  'ALTER TABLE LIC_EXT_JOBS ADD CONSTRAINT FK_CARD_ELEM_120 FOREIGN KEY (JOB) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'LIC_EXT_WASTE') and (RDB$FIELD_NAME = 'TYPE_WASTE'));

    P_SQL =  'ALTER TABLE LIC_EXT_WASTE ADD CONSTRAINT FK_CARD_ELEM_121 FOREIGN KEY (TYPE_WASTE) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'OBJ_GR_ITEM_APPL_REF') and (RDB$FIELD_NAME = 'CARD_ELEMENT_ID'));

    P_SQL =  'ALTER TABLE OBJ_GR_ITEM_APPL_REF ADD CONSTRAINT FK_CARD_ELEM_122 FOREIGN KEY (CARD_ELEMENT_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'OGV_TO_DOC_TEMPLATE') and (RDB$FIELD_NAME = 'DOC_OGV_TYPE_ID'));

    P_SQL =  'ALTER TABLE OGV_TO_DOC_TEMPLATE ADD CONSTRAINT FK_CARD_ELEM_123 FOREIGN KEY (DOC_OGV_TYPE_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'REQUEST_TEMPLATE') and (RDB$FIELD_NAME = 'DOC_TYPE_ID'));

    P_SQL =  'ALTER TABLE REQUEST_TEMPLATE ADD CONSTRAINT FK_CARD_ELEM_124 FOREIGN KEY (DOC_TYPE_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'SERVICE_DOC_APPLICANTS_REF') and (RDB$FIELD_NAME = 'CARD_ELEMENT_ID'));

    P_SQL =  'ALTER TABLE SERVICE_DOC_APPLICANTS_REF ADD CONSTRAINT FK_CARD_ELEM_125 FOREIGN KEY (CARD_ELEMENT_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'SERVICE_DOC_TREE_APPLICANTS_RF') and (RDB$FIELD_NAME = 'CARD_ELEMENT_ID'));

    P_SQL =  'ALTER TABLE SERVICE_DOC_TREE_APPLICANTS_RF ADD CONSTRAINT FK_CARD_ELEM_126 FOREIGN KEY (CARD_ELEMENT_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'SERVICE_DOC_TREE_OGVS_REF') and (RDB$FIELD_NAME = 'CARD_ELEMENT_ID'));

   P_SQL =  'ALTER TABLE SERVICE_DOC_TREE_OGVS_REF ADD CONSTRAINT FK_CARD_ELEM_127 FOREIGN KEY (CARD_ELEMENT_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;


   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'SERVICE_DOC_APPLICANTS_REF') and (RDB$FIELD_NAME = 'CARD_ELEMENT_ID'));

   P_SQL =  'ALTER TABLE SERVICE_DOC_APPLICANTS_REF ADD CONSTRAINT FK_CARD_ELEM_128 FOREIGN KEY (CARD_ELEMENT_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'SERVICE_DOC_TREE_APPLICANTS_RF') and (RDB$FIELD_NAME = 'CARD_ELEMENT_ID'));

   P_SQL =  'ALTER TABLE SERVICE_DOC_TREE_APPLICANTS_RF ADD CONSTRAINT FK_CARD_ELEM_129 FOREIGN KEY (CARD_ELEMENT_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'TYPE_APPLICATION_TREE') and (RDB$FIELD_NAME = 'SERVICE_ID'));

   P_SQL =  'ALTER TABLE TYPE_APPLICATION_TREE ADD CONSTRAINT FK_CARD_ELEM_130 FOREIGN KEY (SERVICE_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS where (RDB$RELATION_NAME = 'TYPE_APPLICATION_TREE') and (RDB$FIELD_NAME = 'TYPE_APPLICANT_ID'));

   P_SQL =  'ALTER TABLE TYPE_APPLICATION_TREE ADD CONSTRAINT FK_CARD_ELEM_131 FOREIGN KEY (TYPE_APPLICANT_ID) REFERENCES CARD_ELEMENT (ID)';
   EXECUTE STATEMENT :P_SQL;





  update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'AGENT_CASE') and (RDB$FIELD_NAME = 'CASE_TYPE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'CONSULT_JOURNAL') and (RDB$FIELD_NAME = 'TYPE'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'DECLARATION_ITEM') and (RDB$FIELD_NAME = 'PROD_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'DECLARATION_ITEM_AUD') and (RDB$FIELD_NAME = 'PROD_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_DOC_PACKAGE') and (RDB$FIELD_NAME = 'SERVICE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_DOC_PACKAGE_ITEM') and (RDB$FIELD_NAME = 'DOC_TYPE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_DOC_PACKAGE_ITEM') and (RDB$FIELD_NAME = 'GOS_ORGAN'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_DOC_PACKAGE_ITEM') and (RDB$FIELD_NAME = 'DOC_CLASS_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_DOC_PACKAGE_ITEM') and (RDB$FIELD_NAME = 'DOC_CLASS_ID'));


   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_OGV_TEMPLATE') and (RDB$FIELD_NAME = 'OGV_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_OGV_TEMPLATE') and (RDB$FIELD_NAME = 'TEMPLATE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_REGISTRATOR_JOURNAL') and (RDB$FIELD_NAME = 'SERVICE'));


   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_REQUEST') and (RDB$FIELD_NAME = 'OGV_ID'));


   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC') and (RDB$FIELD_NAME = 'SERVICE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC') and (RDB$FIELD_NAME = 'DOC_TYPE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC') and (RDB$FIELD_NAME = 'DOC_CLASS_ID'));


   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_TEMPLATE') and (RDB$FIELD_NAME = 'SERVICE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_TEMPLATE') and (RDB$FIELD_NAME = 'TEMPLATE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'IN_DOC') and (RDB$FIELD_NAME = 'DOC_TYPE'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'LICENSE') and (RDB$FIELD_NAME = 'STATUS_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'LIC_OBJECT') and (RDB$FIELD_NAME = 'OBJ_TYPE'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'LIC_OBJECT') and (RDB$FIELD_NAME = 'OBJ_PLACE_TYPE'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'LIC_OBJECT') and (RDB$FIELD_NAME = 'ACTIVITY_TYPE'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'LIC_OBJECT_AUD') and (RDB$FIELD_NAME = 'OBJ_TYPE'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'LIC_OBJECT_AUD') and (RDB$FIELD_NAME = 'OBJ_PLACE_TYPE'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'LIC_OBJECT_AUD') and (RDB$FIELD_NAME = 'ACTIVITY_TYPE'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'LIC_OBJECT_OPERS') and (RDB$FIELD_NAME = 'OPERATION_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'LIC_OBJECT_PAC') and (RDB$FIELD_NAME = 'ACTIVITY_TYPE'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'LIC_OBJECT_PAC') and (RDB$FIELD_NAME = 'ACTIVITY_TYPE'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'OBJECT_GROUP') and (RDB$FIELD_NAME = 'SERVICE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'OBJECT_GROUP') and (RDB$FIELD_NAME = 'MAIN_SERVCIE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'PRINT_DOC') and (RDB$FIELD_NAME = 'DOC_TYPE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'PRINT_DOC_TYPE_TEMPLATE') and (RDB$FIELD_NAME = 'DOC_TYPE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'PRINT_DOC_TYPE_TEMPLATE') and (RDB$FIELD_NAME = 'TEMPLATE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'REMOTE_SYSTEM') and (RDB$FIELD_NAME = 'OGV_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'REQUEST') and (RDB$FIELD_NAME = 'OGV_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'RESULT_JOURNAL') and (RDB$FIELD_NAME = 'ACTIVITY_TYPE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'RESULT_JOURNAL') and (RDB$FIELD_NAME = 'ACTIVITY_TYPE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'SERVICE_DOC_VAL') and (RDB$FIELD_NAME = 'SERVICE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'SERVICE_DOC_VAL') and (RDB$FIELD_NAME = 'DOC_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'SERVICE_INTEGRATION') and (RDB$FIELD_NAME = 'OGV_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'SERVICE_INTEGRATION') and (RDB$FIELD_NAME = 'SERVICE_ID'));

   update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
   where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
   where (RDB$RELATION_NAME = 'SERVICE_TARIF_VAL') and (RDB$FIELD_NAME = 'SERVICE_TARIF_ID'));

   EXIT;
end^

SET TERM ; ^

GRANT EXECUTE ON PROCEDURE EXTENSIONIDFORCARDELEMENT TO SYSDBA;