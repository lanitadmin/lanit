insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values (nextval('hibernate_sequence'), null,'autogen_person_case','Возможность генерации падежных форм заявителя при подаче заявления (0-нет, 1-да)', '1', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select nextval('hibernate_sequence'), ou.owner,'autogen_person_case','Возможность генерации падежных форм заявителя при подаче заявления (0-нет, 1-да)', '1', false  from org_unit ou