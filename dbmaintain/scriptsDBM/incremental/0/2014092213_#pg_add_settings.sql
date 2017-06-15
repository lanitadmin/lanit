insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'arm_receive_doc_package_schedule_timer_period','Расписание запуска таймера приема дел на выдачу', '', false, 'АРМ');

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
values(nextval('hibernate_sequence'), null,'arm_send_doc_package_schedule_timer_period','Расписание запуска таймера передачи новых дел и обновление дел на выдачу ', '', false, 'АРМ');
