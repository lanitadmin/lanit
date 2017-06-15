insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'clear_all_data_reports','Возможность чистить все наработанные данные в отчетах', '0', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
select hibernate_sequence.nextval, ou.owner,'clear_all_data_reports','Возможность чистить все наработанные данные в отчетах', '0', 0  from org_unit ou;