insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('gossrvc_appeal_host', 'Сервис приема жалоб (хост)', '', nextval('hibernate_sequence'), null);

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'gossrvc_appeal_host', 'Сервис приема жалоб (хост)', '', nextval('hibernate_sequence'), owner from org_unit;