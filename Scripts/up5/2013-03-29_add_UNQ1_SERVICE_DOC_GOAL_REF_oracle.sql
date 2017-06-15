--универсальный скрипт для 3 СУБД (oracle, postgres, firebird)
--При прогоне, если вдруг возникнет ошибка, то скорее всего в таблице присутствуют дублированные записи.
ALTER TABLE SERVICE_DOC_GOAL_REF ADD CONSTRAINT UNQ1_SERVICE_DOC_GOAL_REF UNIQUE (gossrvc_service_doc_id,goal_id);

--в случае если присутствуют дублированные записи, то необходимо их удалить. После удаления необходимо попытаться создать constraint заново.
--Скрипт для удаления дублированных записей:

/*
create table SERVICE_DOC_GOAL_REF1 (
   gossrvc_service_doc_id number NOT NULL,
   goal_id bigint NOT NULL
);


insert into SERVICE_DOC_GOAL_REF1 (gossrvc_service_doc_id, goal_id)
select gossrvc_service_doc_id, goal_id
from SERVICE_DOC_GOAL_REF
group by  gossrvc_service_doc_id, goal_id;

delete from SERVICE_DOC_GOAL_REF;

insert into SERVICE_DOC_GOAL_REF (gossrvc_service_doc_id, goal_id)
select gossrvc_service_doc_id, goal_id
from SERVICE_DOC_GOAL_REF1;

select count(1) from SERVICE_DOC_GOAL_REF;

drop table SERVICE_DOC_GOAL_REF1;
*/