insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'ecm_incoming_number_format','Шаблон нумерации входящих документов', '', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'ecm_incoming_number_format','Шаблон нумерации входящих документов', '', false  from org_unit ou;


insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'ecm_internal_number_format','Шаблон нумерации внутренних документов', '', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'ecm_internal_number_format','Шаблон нумерации внутренних документов', '', false  from org_unit ou;


insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'ecm_outgoing_number_format','Шаблон нумерации исходящих документов', '', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'ecm_outgoing_number_format','Шаблон нумерации исходящих документов', '', false  from org_unit ou;


insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'ecm_project_number_format','Шаблон нумерации проектов документов', '', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'ecm_project_number_format','Шаблон нумерации проектов документов', '', false  from org_unit ou;


insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'ecm_report_url','Адрес отчета регистрационной карточки', '', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'ecm_report_url','Адрес отчета регистрационной карточки', '', false  from org_unit ou;
