--Для применения новых настроек необходимо увеличить размер колонки SETTINGS_VALUE
ALTER TABLE APP_SETTING MODIFY SETTING_VALUE varchar2(512);


--Добавить если очередь Коминтех
update app_setting set SETTING_VALUE = 'CALL: comintech_InviteNextVisitor; POSTPONE: comintech_postpone; END: comintech_CompleteCurrentOperation; BEGIN: comintech_StartOperation; REJECT_VISITOR: comintech_RejectCurrentOperation; GET_CURR_VISITOR: comintech_GetCurrentVisitor; GET_WINDOW_STATE: Comintech_GetWindowState; REDIRECT: Comintech_redirect'
where SETTING_ID = 'integration_queue_template_soap' and owner = owner_for_update
--Добавить если очередь Дамаск
update app_setting set SETTING_VALUE = 'CALL: damaskCall; END: damaskEnd; POSTPONE: damaskPostpone; REDIRECT: damaskRedirect'
where SETTING_ID = 'integration_queue_template_soap' and owner = owner_for_update