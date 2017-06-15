insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values (hibernate_sequence.nextval, null,'autogen_person_case','Возможность генерации падежных форм заявителя при подаче заявления (0-нет, 1-да)', '1', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'autogen_person_case','Возможность генерации падежных форм заявителя при подаче заявления (0-нет, 1-да)', '1', 0  from org_unit ou;