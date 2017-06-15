insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'rating_before_complete','Возможность оценки до завершения комплекта документов, 1-да, 0-нет', '0', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'rating_before_complete','Возможность оценки до завершения комплекта документов, 1-да, 0-нет', '0', false  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'rating_before_complete_period','Период, в течение которого ОГВ невозможно оценить', '12', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'rating_before_complete_period','Период, в течение которого ОГВ невозможно оценить', '12', false  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'clear_eval_rating_period','Время жизни оценки в реестре (ч)', '1', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'clear_eval_rating_period','Время жизни оценки в реестре (ч)', '1', false  from org_unit ou;