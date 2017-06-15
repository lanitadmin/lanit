insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass) values(nextval('hibernate_sequence'), null,'pack_enable_clone_attach','Включить копирование скана при клонировании документа, 1-да, 0-нет', '0', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'pack_enable_clone_attach','Включить копирование скана при клонировании документа, 1-да, 0-нет', '0', false  from org_unit ou;