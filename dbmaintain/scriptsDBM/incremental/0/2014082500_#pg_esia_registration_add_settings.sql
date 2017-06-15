insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'esia_adapter_code','Код адаптера для выполнения запросов к сервису ЕСИА', 'SID0003419ESIA', false, 'ЕСИА');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'esia_personal_data_statement','Шаблон согласия на обработку персональных данных', '&__locale=ru_RU&__report=lodint/mfc/Tyumen/consentApplication.rptdesign;Согласие на обработку персональных данных', false, 'ЕСИА');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'esia_registration_center_code','Идентификатор центра регистрации', '', false, 'ЕСИА');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'esia_registration_center_name','Тестовый центр обслуживания', '', false, 'ЕСИА');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'esia_rf_passport_id','Код паспорта гражданина РФ', '', false, 'ЕСИА');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'esia_foreign_citizen_passport_id','Код документа, удовлетворяющего личность иностранного гражданина', '', false, 'ЕСИА');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'is_esia_service_enabled','Доступность сервиса ЕСИА (1 - доступен)', '', false, 'ЕСИА');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'esia_autoupdate_timer_period','Период запуска таймера для обновления статусов незавершенных запросов в ЕСИА (в мин)', '720', false, 'ЕСИА');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'esia_timer_request_count_for_one_cycle','Кол-во запросов в ЕСИА при обновлении статуса заявки за один проход цикла', '20', false, 'ЕСИА');

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass, setting_group) 
values(nextval('hibernate_sequence'), null,'esia_timer_request_total_count','Ограничение на кол-во запросов, статусы которых необходимо обновить, за один вызов таймера (Если пусто - будут обновлены все незавершенные заявки) ', '', false, 'ЕСИА');
