insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass) values(nextval('hibernate_sequence'), null,'show_actual_card_element_only','Отображать только актуальные записи при выборе картотеки, 1-да, 0-нет', '0', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'show_actual_card_element_only','Отображать только актуальные записи при выборе картотеки, 1-да, 0-нет', '0', false  from org_unit ou;