--- где 'VydOrdNaProvZemlRab' - код услуги,  'bashkiria'- под какой орг. юнит ставить
--- гоним скрипты по переносу настрок под орг. юнит   'bashkiria'
---скрипт протестирован, в будем если будет часто юзаться можно оформить ввиде процедуры 
update securable s1
set s1.owner = 'bashkiria'
where s1.id in(select tree.id from gossrvc_service_doc_tree tree where tree.service_id = 'VydOrdNaProvZemlRab');

update securable s1
set s1.owner = 'bashkiria'
where s1.id in(select tree.id from gossrvc_service_doc tree where tree.service_id = 'VydOrdNaProvZemlRab');


update securable s1
set s1.owner = 'bashkiria'
where s1.id in(select tree.id from type_application_tree tree where tree.service_id = 'VydOrdNaProvZemlRab');


---создаем элемент VydOrdNaProvZemlRab под оргюнитом bashkiria через редактор , получаем услугу 'VydOrdNaProvZemlRab_bashkiria'
--гоним скрипты по переносу настроек со старой услуги 'VydOrdNaProvZemlRab' на новую 'VydOrdNaProvZemlRab_bashkiria' под конкрентным филиалом

update gossrvc_service_doc_tree tree
set tree.service_id = 'VydOrdNaProvZemlRab_bashkiria'
where tree.service_id = 'VydOrdNaProvZemlRab';


update gossrvc_service_doc tree
set tree.service_id = 'VydOrdNaProvZemlRab_bashkiria'
where tree.service_id = 'VydOrdNaProvZemlRab';


update type_application_tree tree
set tree.service_id = 'VydOrdNaProvZemlRab_bashkiria'
where tree.service_id = 'VydOrdNaProvZemlRab';