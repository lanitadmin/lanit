insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'rating_before_complete','Возможность оценки до завершения комплекта документов, 1-да, 0-нет', '0', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'rating_before_complete','Возможность оценки до завершения комплекта документов, 1-да, 0-нет', '0', 0  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'rating_before_complete_period','Период, в течение которого ОГВ невозможно оценить', '12', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'rating_before_complete_period','Период, в течение которого ОГВ невозможно оценить', '12', 0  from org_unit ou;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'clear_eval_rating_period','Время жизни оценки в реестре (ч)', '1', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'clear_eval_rating_period','Время жизни оценки в реестре (ч)', '1', 0  from org_unit ou;