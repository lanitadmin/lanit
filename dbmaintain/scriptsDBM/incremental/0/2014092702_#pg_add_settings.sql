--скрипт прогонять нет необходимости


--insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
--values(nextval('hibernate_sequence'), null,'issue_place_is_multiply','Множественный выбор места выдачи результата (0 - нет, 1 - да)', '0', false);

--insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
--select nextval('hibernate_sequence'), ou.owner,'issue_place_is_multiply','Множественный выбор места выдачи результата (0 - нет, 1 - да)', '0', false  from org_unit ou;*/
