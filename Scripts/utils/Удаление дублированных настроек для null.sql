delete from app_setting where owner is null and id not in (select min(id) from app_setting where owner is null group by setting_id,owner);