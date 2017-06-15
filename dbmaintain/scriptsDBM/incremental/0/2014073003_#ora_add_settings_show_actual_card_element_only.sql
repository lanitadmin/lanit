insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass) values(hibernate_sequence.nextval, null,'show_actual_card_element_only','Отображать только актуальные записи при выборе картотеки, 1-да, 0-нет', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'show_actual_card_element_only','Отображать только актуальные записи при выборе картотеки, 1-да, 0-нет', '0', 0  from org_unit ou;
