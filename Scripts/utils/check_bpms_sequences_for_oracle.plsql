DECLARE
   seq integer;
   seq_in_table integer;
   n integer;
   test_Var integer;
BEGIN
  select max(oid) into seq_in_table from bpms_activity;
  select gen_bpms_activity.nextval into seq from dual;
  n := seq_in_table - seq;
  DBMS_OUTPUT.PUT_LINE('gen_bpms_activity, n = ' || n);

  select max(oid) into seq_in_table from bpms_activity_variable;
  select gen_bpms_activity_variable.nextval into seq from dual;
  n := seq_in_table - seq;
  DBMS_OUTPUT.PUT_LINE('gen_bpms_activity_variable, n = ' || n);

  select max(oid) into seq_in_table from bpms_assignment;
  select gen_bpms_assignment.nextval into seq from dual;
  n := seq_in_table - seq;

  DBMS_OUTPUT.PUT_LINE('gen_bpms_assignment, n = ' || n);

  select max(oid) into seq_in_table from bpms_deadline;
  select gen_bpms_deadline.nextval into seq from dual;
  n := seq_in_table - seq;

  DBMS_OUTPUT.PUT_LINE('gen_bpms_deadline, n = ' || n);

  select max(oid) into seq_in_table from bpms_global_data;
  select gen_bpms_global_data.nextval into seq from dual;
  n := seq_in_table - seq;

  DBMS_OUTPUT.PUT_LINE('bpms_global_data, n = ' || n);

  select max(oid) into seq_in_table from bpms_participant_map;
  select gen_bpms_participant_map.nextval into seq from dual;
  n := seq_in_table - seq;

  DBMS_OUTPUT.PUT_LINE('bpms_participant_map, n = ' || n);

  select max(oid) into seq_in_table from bpms_process;
  select gen_bpms_process.nextval into seq from dual;
  n := seq_in_table - seq;

  DBMS_OUTPUT.PUT_LINE('bpms_process, n = ' || n);

  select max(oid) into seq_in_table from bpms_process_mgr;
  select gen_bpms_process_mgr.nextval into seq from dual;
  n := seq_in_table - seq;

  DBMS_OUTPUT.PUT_LINE('bpms_process_mgr, n = ' || n);

  select max(oid) into seq_in_table from bpms_process_variable;
  select gen_bpms_process_variable.nextval into seq from dual;
  n := seq_in_table - seq;

  DBMS_OUTPUT.PUT_LINE('bpms_process_variable, n = ' || n);

  select max(oid) into seq_in_table from bpms_resource;
  select gen_bpms_resource.nextval into seq from dual;
  n := seq_in_table - seq;

  DBMS_OUTPUT.PUT_LINE('gen_bpms_resource, n = ' || n);

  select max(oid) into seq_in_table from bpms_xpdl;
  select gen_bpms_xpdl.nextval into seq from dual;
  n := seq_in_table - seq;
  DBMS_OUTPUT.PUT_LINE('gen_bpms_xpdl, n = ' || n);

END;