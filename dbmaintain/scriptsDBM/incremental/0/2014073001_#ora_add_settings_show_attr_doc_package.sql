insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass) values(hibernate_sequence.nextval, null,'show_attr_doc_package','Разворачивать по умолчанию панель дополнительных аттрибутов, 1-да, 0-нет', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'show_attr_doc_package','Разворачивать по умолчанию панель дополнительных аттрибутов, 1-да, 0-нет', '0', 0  from org_unit ou;
