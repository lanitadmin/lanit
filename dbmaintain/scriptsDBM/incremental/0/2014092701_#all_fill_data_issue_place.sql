--прогнать после деплоя обязательно
insert into obj_gr_itm_issue_places (obj_gr_item_id, issue_place)
select id,issue_place
from object_group_item i 
where issue_place is not null
and not exists (select 1 from obj_gr_itm_issue_places p where i.id = p.obj_gr_item_id);