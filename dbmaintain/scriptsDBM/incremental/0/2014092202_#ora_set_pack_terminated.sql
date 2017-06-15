UPDATE 
(SELECT pack.completed_date as OLD, TO_DATE('19700101','yyyymmdd') + ((proc.bpms_last_state_time/1000)/24/60/60) as NEW
 FROM gossrvc_doc_package pack
 INNER JOIN bpms_process proc
 ON pack.proc_inst_id = proc.bpms_id
 WHERE proc.bpms_state = 'closed.terminated' and pack.completed_date is not null
) t
SET t.OLD = t.NEW;

UPDATE
(SELECT pack.terminated as value
 FROM gossrvc_doc_package pack
 INNER JOIN bpms_process proc
 ON pack.proc_inst_id = proc.bpms_id
 WHERE proc.bpms_state = 'closed.terminated'
) t
SET t.terminated = 1;