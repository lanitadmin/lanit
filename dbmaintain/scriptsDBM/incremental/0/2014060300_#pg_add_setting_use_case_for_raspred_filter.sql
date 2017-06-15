insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass) values(nextval('hibernate_sequence'), null,'use_case_for_raspred_filter','Отображать на странице <Мои задачи> фильтр <Отображать дела на распределении>, 1-да, 0-нет', '0', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'use_case_for_raspred_filter','Отображать на странице <Мои задачи> фильтр <Отображать дела на распределении>, 1-да, 0-нет', '0', false  from org_unit ou;