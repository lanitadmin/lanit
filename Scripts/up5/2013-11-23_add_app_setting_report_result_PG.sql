insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'path_report_from_adapter','Путь до печатной формы, предназначенной для вывода результата запроса', '', null);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence') , ou.owner,'path_report_from_adapter','Путь до печатной формы, предназначенной для вывода результата запроса', '', null from org_unit ou;