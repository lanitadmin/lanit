update gossrvc_doc_package pack
set terminated = true
from bpms_process proc
where proc.bpms_id = pack.proc_inst_id
and proc.bpms_state = 'closed.terminated';

update gossrvc_doc_package pack
set completed_date = TO_CHAR(TO_TIMESTAMP(bpms_last_state_time / 1000), 'YYYY-MM-DD HH24:MI:SS')::timestamp
from bpms_process proc
where proc.bpms_id = pack.proc_inst_id
and proc.bpms_state = 'closed.terminated'
and pack.completed_date is null;