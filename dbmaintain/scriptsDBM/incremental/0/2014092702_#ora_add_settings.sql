--скрипт прогонять нет необходимости

--insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
--values(hibernate_sequence.nextval, null,'issue_place_is_multiply','Множественный выбор места выдачи результата (0 - нет, 1 - да)', '0', 0);

--insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
--select hibernate_sequence.nextval, ou.owner,'issue_place_is_multiply','Множественный выбор места выдачи результата (0 - нет, 1 - да)', '0', 0  from org_unit ou;insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
