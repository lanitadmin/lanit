insert into app_setting (id, owner,setting_id,setting_name, setting_value) values (gen_id(hibernate_sequence, 1), null,'autogen_person_case','Возможность генерации падежных форм заявителя при подаче заявления (0-нет, 1-да)', '1');

insert into app_setting (id, owner,setting_id,setting_name, setting_value) 
select gen_id(hibernate_sequence, 1), ou.owner,'autogen_person_case','Возможность генерации падежных форм заявителя при подаче заявления (0-нет, 1-да)', '1'  from org_unit ou