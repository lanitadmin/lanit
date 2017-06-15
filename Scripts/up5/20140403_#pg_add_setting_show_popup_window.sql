insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('show_popup_window_with_number_after_login', 'Отображать окно электронной очереди (0-нет,1-да)', '1', nextval('hibernate_sequence'), null);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'show_popup_window_with_number_after_login', 'Отображать окно электронной очереди (0-нет,1-да)', '1', nextval('hibernate_sequence'), owner from org_unit;