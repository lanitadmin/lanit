insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(hibernate_sequence.nextval, null,'alcohol_license_blank','Шаблон печатной формы лицензии на розничную продажу алкогольной продукции', 'lodint/mfc/Test/alkohol_license.rptdesign', 0, null);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
select hibernate_sequence.nextval, ou.owner,'alcohol_license_blank','Шаблон печатной формы лицензии на розничную продажу алкогольной продукции', 'lodint/mfc/Test/alkohol_license.rptdesign', 0, null from org_unit ou;
