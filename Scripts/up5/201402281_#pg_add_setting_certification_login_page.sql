insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('show_certification_login_page', 'Отображать страницу входа по сертификату (0-нет,1-да)', '0', nextval('hibernate_sequence'), null);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'show_certification_login_page', 'Отображать страницу входа по сертификату (0-нет,1-да)', '0', nextval('hibernate_sequence'), owner from org_unit;