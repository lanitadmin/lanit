insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'alcohol_license_blank','Шаблон печатной формы лицензии на розничную продажу алкогольной продукции', 'lodint/mfc/Test/alkohol_license.rptdesign', false, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select nextval('hibernate_sequence'), ou.owner,'alcohol_license_blank','Шаблон печатной формы лицензии на розничную продажу алкогольной продукции', 'lodint/mfc/Test/alkohol_license.rptdesign', false, null from org_unit ou;

