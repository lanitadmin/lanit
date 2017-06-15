insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'ik_send_email_notification','Отправка на email из ИК, 1-да, 0-нет', '0', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'ik_send_email_notification','Отправка на email из ИК, 1-да, 0-нет', '0', 0  from org_unit ou;

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
values(hibernate_sequence.nextval, null,'ik_send_email_from','Отправка на email из ИК от имени (Адрес электронной почты отправителя)', 'noreply@samara.lanit.ru', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'ik_send_email_from','Отправка на email из ИК от имени (Адрес электронной почты отправителя)', 'noreply@samara.lanit.ru', 0  from org_unit ou;

values(hibernate_sequence.nextval, null,'ik_send_email_to','Отправка на email из ИК на почту руководителю (Адрес электронной почты получателя)', '', 0);

insert into app_setting (id, owner, setting_id, setting_name, setting_value, is_pass)
select hibernate_sequence.nextval, ou.owner,'ik_send_email_to','Отправка на email из ИК на почту руководителю (Адрес электронной почты получателя)', '', 0  from org_unit ou;
