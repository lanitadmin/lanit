alter table BPMS_PROCESS_VARIABLE add bpms_value_string_1 clob;

update BPMS_PROCESS_VARIABLE
set bpms_value_string_1 = bpms_value_string;

alter table BPMS_PROCESS_VARIABLE rename COLUMN bpms_value_string to bpms_value_string_2;

alter table BPMS_PROCESS_VARIABLE rename COLUMN bpms_value_string_1 to bpms_value_string;

alter table BPMS_ACTIVITY_VARIABLE add bpms_value_string_1 clob;

update BPMS_ACTIVITY_VARIABLE
set bpms_value_string_1 = bpms_value_string;

alter table BPMS_ACTIVITY_VARIABLE rename COLUMN bpms_value_string to bpms_value_string_2;

alter table BPMS_ACTIVITY_VARIABLE rename COLUMN bpms_value_string_1 to bpms_value_string;