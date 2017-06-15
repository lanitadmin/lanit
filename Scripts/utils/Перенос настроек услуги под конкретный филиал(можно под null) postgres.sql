--- где 'VydOrdNaProvZemlRab' - код услуги,  'bashkiria'- под какой орг. юнит ставить
--- гоним скрипты по переносу настрок под орг. юнит   'bashkiria'
---скрипт протестирован, в будем если будет часто юзаться можно оформить ввиде процедуры 
update securable
set owner = 'bashkiria'
where id in(select tree.id from gossrvc_service_doc_tree tree where tree.service_id = 'VydOrdNaProvZemlRab')
and aobject = 'entity.GossrvcServiceDocTree';

update securable
set owner = 'bashkiria'
where id in(select tree.id from GOSSRVC_SERVICE_ATTR attr, gossrvc_service_doc_tree tree where tree.service_id = 'VydOrdNaProvZemlRab' and attr.PARENT_ID = tree.id)
and aobject = 'entity.GossrvcServiceAttr';


update securable
set owner = 'bashkiria'
where id in(select tree.id from GOSSRVC_SERVICE_DOC_CODE_INTEG doc, gossrvc_service_doc_tree tree where tree.service_id = 'VydOrdNaProvZemlRab' and doc.REQUEST_ID = tree.id)
and aobject = 'entity.DocCodeIntegration';


update securable
set owner = 'bashkiria'
where id in(select tree.id from gossrvc_service_doc tree where tree.service_id = 'VydOrdNaProvZemlRab')
and aobject = 'entity.GossrvcServiceDoc';



update securable
set owner = 'bashkiria'
where s1.id in(select tree.id from type_application_tree tree where tree.service_id = 'VydOrdNaProvZemlRab') and 
and aobject = 'entity.TypeApplicationTree';


---создаем элемент VydOrdNaProvZemlRab под оргюнитом bashkiria через редактор , получаем услугу 'VydOrdNaProvZemlRab_bashkiria'
--гоним скрипты по переносу настроек со старой услуги 'VydOrdNaProvZemlRab' на новую 'VydOrdNaProvZemlRab_bashkiria' под конкрентным филиалом

update gossrvc_service_doc_tree
set service_id = 'VydOrdNaProvZemlRab_bashkiria'
where service_id = 'VydOrdNaProvZemlRab';


update gossrvc_service_doc
set service_id = 'VydOrdNaProvZemlRab_bashkiria'
where service_id = 'VydOrdNaProvZemlRab';


update type_application_tree
set service_id = 'VydOrdNaProvZemlRab_bashkiria'
where service_id = 'VydOrdNaProvZemlRab';