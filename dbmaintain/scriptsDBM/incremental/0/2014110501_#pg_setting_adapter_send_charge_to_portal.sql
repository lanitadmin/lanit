insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(nextval('hibernate_sequence'), null,'adapter_send_charge_to_portal','Наименование адаптера по отправке начислений на портал', 'sendChargeToPortal', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
select nextval('hibernate_sequence'), ou.owner,'adapter_send_charge_to_portal','Наименование адаптера по отправке начислений на портал', 'sendChargeToPortal', false  from org_unit ou;