insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, IS_PASS)
values ('integration_queue_id', 'id интеграции с эл. очередью(damask,enter)', 'damask', nextval('hibernate_sequence'), NULL,false);

--insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER , IS_PASS)
--select ('integration_queue_id', 'id интеграции с эл. очередью(damask,enter)', 'damask', nextval('hibernate_sequence'),owner,false) from org_unit;

--когда нужно активировать интеграцию с коминтек
--update app_setting set SETTING_VALUE = 'comintech_InviteNextVisitor,comintech_postpone,comintech_CompleteCurrentOperation,comintech_StartOperation,comintech_RejectCurrentOperation,comintech_GetCurrentVisitor,Comintech_GetWindowState'
	--where SETTING_ID = 'integration_queue_template_soap' and owner = owner_for_update

