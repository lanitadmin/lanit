insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'ik_send_email_notification','Отправка на email из ИК, 1-да, 0-нет', '0', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'ik_send_email_notification','Отправка на email из ИК, 1-да, 0-нет', '0', false  from org_unit ou;

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(nextval('hibernate_sequence'), null,'ik_send_email_from','Отправка на email из ИК от имени (Адрес электронной почты отправителя)', 'noreply@samara.lanit.ru', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'ik_send_email_from','Отправка на email из ИК от имени (Адрес электронной почты отправителя)', 'noreply@samara.lanit.ru', false  from org_unit ou;

values(nextval('hibernate_sequence'), null,'ik_send_email_to','Отправка на email из ИК на почту руководителю (Адрес электронной почты получателя)', '', false);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select nextval('hibernate_sequence'), ou.owner,'ik_send_email_to','Отправка на email из ИК на почту руководителю (Адрес электронной почты получателя)', '', false  from org_unit ou;
