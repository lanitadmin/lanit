insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(gen_id( hibernate_sequence, 1), null,'soap_inn_adapter_attr_code_complience','Соответствие аттрибутов кодов', 'FirstName,Zapros_FirstName;LastName,Zapros_LastName;BirthDate,Zapros_BirthDate;VidDoc,Zapros_CodeVidDoc;SerNumDoc,Zapros_SerNumDoc;NumSender,CaseNumberSender;Name,SvUL_NAIMUL;Ogrn,SvUL_OGRN;Inn,SvUL_INNUL;', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select gen_id( hibernate_sequence, 1), ou.owner,'soap_inn_adapter_attr_code_complience','Соответствие аттрибутов кодов', 'FirstName,Zapros_FirstName;LastName,Zapros_LastName;BirthDate,Zapros_BirthDate;VidDoc,Zapros_CodeVidDoc;SerNumDoc,Zapros_SerNumDoc;NumSender,CaseNumberSender;Name,SvUL_NAIMUL;Ogrn,SvUL_OGRN;Inn,SvUL_INNUL;', false  from org_unit ou;


insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(gen_id( hibernate_sequence, 1), null,'soap_inn_adapter_code','Код адаптера для получения ИНН', 'SID0003450', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select gen_id( hibernate_sequence, 1), ou.owner,'soap_inn_adapter_code','Код адаптера для получения ИНН', 'SID0003450', false  from org_unit ou;


insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(gen_id( hibernate_sequence, 1), null,'soap_inn_code','Код аттрибута ИНН', 'Result', false);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select gen_id( hibernate_sequence, 1), ou.owner,'soap_inn_code','Код аттрибута ИНН', 'Result', false  from org_unit ou;