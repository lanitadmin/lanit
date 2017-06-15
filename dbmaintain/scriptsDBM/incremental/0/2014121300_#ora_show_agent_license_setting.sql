insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(hibernate_sequence.nextval, null,'show_tab_license','Отображать/скрывать вкладку «Лицензии» в карточке «Юридические лица»', '0', 0, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select hibernate_sequence.nextval, ou.owner,'show_tab_license','Отображать/скрывать вкладку «Лицензии» в карточке «Юридические лица»', '0', 0, null from org_unit ou;

