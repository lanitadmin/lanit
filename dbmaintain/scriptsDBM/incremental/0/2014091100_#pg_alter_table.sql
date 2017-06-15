update COLLECT_DATA_SCHEDULES
set TIME_TRIGGER = trigger;

alter table COLLECT_DATA_SCHEDULES drop column trigger;