insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
values(hibernate_sequence.nextval, null,'scan_applet_v2','Использовать новый апплет сканирования (многостраничный) (0-нет,1-да)', '0', null);
insert into app_setting (setting_id, setting_name, setting_value, id, owner)
select 'scan_applet_v2','Использовать новый апплет сканирования (многостраничный) (0-нет,1-да)', '0', hibernate_sequence.nextval, owner from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
values(hibernate_sequence.nextval, null,'scan_applet_zip_limit','Предельное количество файлов для архивирования скан копий', '20', null);
insert into app_setting (setting_id, setting_name, setting_value, id, owner)
select 'scan_applet_zip_limit','Предельное количество файлов для архивирования скан копий', '20', hibernate_sequence.nextval, owner from org_unit;

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
values(hibernate_sequence.nextval, null,'scan_applet_memory_size','Размер оперативной памяти, выделяемый для скан апплета (Мб)', '1024', null);
insert into app_setting (setting_id, setting_name, setting_value, id, owner)
select 'scan_applet_memory_size','Размер оперативной памяти выделяемый для скан апплета (Мб)', '1024', hibernate_sequence.nextval, owner from org_unit;