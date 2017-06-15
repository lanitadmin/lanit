update bpms_assignment
set activitydefinitionid=substring(bpms_activity_id from position(bpms_process_id in bpms_activity_id)+length(bpms_process_id)+1)
where activitydefinitionid is null;