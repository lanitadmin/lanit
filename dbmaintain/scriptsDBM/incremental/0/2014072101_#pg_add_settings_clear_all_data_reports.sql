insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'clear_all_data_reports','Возможность чистить все наработанные данные в отчетах', '0', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
select nextval('hibernate_sequence'), ou.owner,'clear_all_data_reports','Возможность чистить все наработанные данные в отчетах', '0', false  from org_unit ou;