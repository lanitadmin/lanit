insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'show_tab_license','Отображать/скрывать вкладку «Лицензии» в карточке «Юридические лица»', '0', false, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select nextval('hibernate_sequence'), ou.owner,'show_tab_license','Отображать/скрывать вкладку «Лицензии» в карточке «Юридические лица»', '0', false, null from org_unit ou;

