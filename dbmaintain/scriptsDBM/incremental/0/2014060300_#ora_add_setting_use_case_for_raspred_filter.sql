insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass) values(hibernate_sequence.nextval, null,'use_case_for_raspred_filter','Отображать на странице <Мои задачи> фильтр <Отображать дела на распределении>, 1-да, 0-нет', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'use_case_for_raspred_filter','Отображать на странице <Мои задачи> фильтр <Отображать дела на распределении>, 1-да, 0-нет', '0', 0  from org_unit ou;