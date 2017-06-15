insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'soap_inn_adapter_attr_code_complience','Соответствие аттрибутов кодов', 'FirstName,Zapros_FirstName;LastName,Zapros_LastName;BirthDate,Zapros_BirthDate;VidDoc,Zapros_CodeVidDoc;SerNumDoc,Zapros_SerNumDoc;NumSender,CaseNumberSender;Name,SvUL_NAIMUL;Ogrn,SvUL_OGRN;Inn,SvUL_INNUL;', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'soap_inn_adapter_attr_code_complience','Соответствие аттрибутов кодов', 'FirstName,Zapros_FirstName;LastName,Zapros_LastName;BirthDate,Zapros_BirthDate;VidDoc,Zapros_CodeVidDoc;SerNumDoc,Zapros_SerNumDoc;NumSender,CaseNumberSender;Name,SvUL_NAIMUL;Ogrn,SvUL_OGRN;Inn,SvUL_INNUL;', 0  from org_unit ou;


insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'soap_inn_adapter_code','Код адаптера для получения ИНН', 'SID0003450', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'soap_inn_adapter_code','Код адаптера для получения ИНН', 'SID0003450', 0  from org_unit ou;


insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) values(hibernate_sequence.nextval, null,'soap_inn_code','Код аттрибута ИНН', 'Result', 0);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner,'soap_inn_code','Код аттрибута ИНН', 'Result', 0  from org_unit ou;