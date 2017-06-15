update bpms_assignment
set activitydefinitionid=substr(bpms_activity_id, instr(bpms_activity_id,bpms_process_id)+length(bpms_process_id)+1)
where activitydefinitionid is null;