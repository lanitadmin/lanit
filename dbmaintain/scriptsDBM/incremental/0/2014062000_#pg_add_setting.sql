insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'create_and_attach_document_to_kd','Сохранять в файл дополнительные аттрибуты и прикреплять к КД 1-да, 0-нет', '0', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'create_and_attach_document_to_kd','Сохранять в файл дополнительные аттрибуты и прикреплять к КД 1-да, 0-нет', '0', false  from org_unit ou;