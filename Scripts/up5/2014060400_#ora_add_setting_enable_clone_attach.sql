insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass) values(hibernate_sequence.nextval, null,'pack_enable_clone_attach','Включить копирование скана при клонировании документа, 1-да, 0-нет', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'pack_enable_clone_attach','Включить копирование скана при клонировании документа, 1-да, 0-нет', '0', 0  from org_unit ou;