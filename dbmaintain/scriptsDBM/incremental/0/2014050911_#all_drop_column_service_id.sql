--прогонять после обновления приложения
update  eq_service_tree 
set ext_service_id = card_element.id, ext_service_name = card_element.name
from card_element
where eq_service_tree.service_id = card_element.id;

ALTER TABLE eq_service_tree DROP column service_id;