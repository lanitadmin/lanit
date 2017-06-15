insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'send_email_notification','Уведомлять по почте при прохождении процесса, 0-нет, 1-да', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'send_email_notification','Уведомлять по почте при прохождении процесса, 0-нет, 1-да', '0', 0  from org_unit ou;

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'send_email_subject','Тема сообщения электронной почты', 'Новая задача', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'send_email_subject','Тема сообщения электронной почты', 'Новая задача', 0  from org_unit ou;

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'send_email_from','Отправка электронной почты от имени (email)', 'noreply@samara.lanit.ru', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'send_email_from','Отправка электронной почты от имени (email)', 'noreply@samara.lanit.ru', 0  from org_unit ou;