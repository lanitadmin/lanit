INSERT INTO PERMISSION_REF (id, AOBJECT, AACTION)
VALUES (gen_id( hibernate_sequence, 1 ),'Эл.Oчередь','разрешена');

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'integration_queue', 'интеграция с электронной очередью', '0', gen_id( hibernate_sequence, 1 ), owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'integration_queue_pack_id', 'интеграция с электронной очередью, id пакета', 'MFC_plus', gen_id( hibernate_sequence, 1 ), owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'integration_queue_process_id', 'интеграция с электронной очередью, id процесса', 'Reg_lichno', gen_id( hibernate_sequence, 1 ), owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'integration_queue_responce', 'интеграция с электронной очередью, WSDL сервиса внешней очереди', 'none', gen_id( hibernate_sequence, 1 ), owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'integration_queue_responce_local', 'интеграция с электронной очередью, WSDL сервиса добавления в очередь системы', 'http://192.168.1.102/core-process-coreps-webservices-2.1.1-SNAPSHOT/QueueState?wsdl', gen_id( hibernate_sequence, 1 ), owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'integration_queue_type_sequence', 'интеграция с электронной очередью, тип последователности из таблицы [DOC_NUM_GEN]', 'numberQueue', gen_id( hibernate_sequence, 1 ), owner from org_unit;

update  doc_num_gen set date_update = current_date;

INSERT INTO DOC_NUM_GEN (ID, OWNER, DOC_NAME, DOC_NO_FORMAT, DOC_NO_VALUE, DOC_TYPE, "VERSION", PARENT_ID, DATE_UPDATE) 
VALUES (gen_id( hibernate_sequence, 1 ), NULL, 'Номер талона', '[DAY].[MONTH].[YEAR]/[COUNTER]', 1, 'numberQueue', 1, null, current_date);



INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('integration_queue', 'интеграция с электронной очередью', '0', gen_id( hibernate_sequence, 1 ), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('integration_queue_pack_id', 'интеграция с электронной очередью, id пакета', 'MFC_plus', gen_id( hibernate_sequence, 1 ), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('integration_queue_process_id', 'интеграция с электронной очередью, id процесса', 'Reg_lichno', gen_id( hibernate_sequence, 1 ), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('integration_queue_responce', 'интеграция с электронной очередью, WSDL сервиса внешней очереди', 'none', gen_id( hibernate_sequence, 1 ), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('integration_queue_responce_local', 'интеграция с электронной очередью, WSDL сервиса добавления в очередь системы', 'http://192.168.1.102/core-process-coreps-webservices-2.1.1-SNAPSHOT/QueueState?wsdl', gen_id( hibernate_sequence, 1 ), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('integration_queue_type_sequence', 'интеграция с электронной очередью, тип последователности из таблицы [DOC_NUM_GEN]', 'numberQueue', gen_id( hibernate_sequence, 1 ), null);

