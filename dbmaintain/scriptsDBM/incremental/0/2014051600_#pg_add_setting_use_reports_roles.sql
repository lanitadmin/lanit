insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'use_reports_roles','Возможность выгружать отчет только по своей учетной записи, 1-да, 0-нет', '0', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'use_reports_roles','Возможность выгружать отчет только по своей учетной записи, 1-да, 0-нет', '0', false  from org_unit ou;