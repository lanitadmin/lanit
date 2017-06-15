insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values (hibernate_sequence.nextval, null,'automatic_redirection_tasks','Возможность автоматического перенаправления дел с приема на контроль (0-нет, 1-да)', '1', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
select hibernate_sequence.nextval, ou.owner,'automatic_redirection_tasks','Возможность автоматического перенаправления дел с приема на контроль (0-нет, 1-да)', '1', 0  from org_unit ou;