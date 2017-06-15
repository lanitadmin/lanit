insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(gen_id( hibernate_sequence, 1), null,'path_report_from_adapter','Путь до печатной формы, предназначенной для вывода результата запроса', '', null);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select gen_id( hibernate_sequence, 1), ou.owner,'path_report_from_adapter','Путь до печатной формы, предназначенной для вывода результата запроса', '', null from org_unit ou;