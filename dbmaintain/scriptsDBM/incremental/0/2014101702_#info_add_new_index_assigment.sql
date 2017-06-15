1) Удалить индекс с таблицы bpms_process_variable по полю "bpms_value_string"
postgres
DROP INDEX <имя индекса> RESTRICT;
oracle
DROP INDEX <имя индекса>;

2) Создать индекс для таблицы bpms_process_variable по двум полям "bpms_definition_id", "bpms_value_string"
postgres
CREATE INDEX bpms_process_variable_idx_5 ON bpms_process_variable USING btree ("bpms_definition_id", "bpms_value_string");

oracle
CREATE INDEX bpms_process_variable_idx_5 ON bpms_process_variable (bpms_definition_id, bpms_value_string);

3) Под пользователем max, открыть страницу /admin/ddc.seam и нажать кнопку
"Заполнить названия объектов XPDL (Мои задачи)"