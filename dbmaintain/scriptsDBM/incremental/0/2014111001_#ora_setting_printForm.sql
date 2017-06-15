insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'dp_allow_printForm','Наименование адаптера по отправке начислений на портал', '0', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
select hibernate_sequence.nextval, ou.owner,'dp_allow_printForm','Разрешить сканирование печатных форм в КД', '0', 0  from org_unit ou;