/*
скрипт необходимо прогнать перед деплоем ear
 */
update soap_options
set typesignsoap = 'auto'
where typesignsoap like 'autoAndManual';

update soap_options
set typesign2 = '2'
where typesign2 = '3';

update SOAP_CONTEXT_HIST
set typesign = 'auto'
where typesign like 'autoAndManual';