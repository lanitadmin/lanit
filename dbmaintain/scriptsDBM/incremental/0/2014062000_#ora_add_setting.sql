insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'create_and_attach_document_to_kd','Сохранять в файл дополнительные аттрибуты и прикреплять к КД 1-да, 0-нет', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'create_and_attach_document_to_kd','Сохранять в файл дополнительные аттрибуты и прикреплять к КД 1-да, 0-нет', '0', 0  from org_unit ou;