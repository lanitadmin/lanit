--универсальный скрипт для 3 СУБД (oracle, postgres, firebird)
--При прогоне, если вдруг возникнет ошибка, то скорее всего в таблице присутствуют дублированные записи.
ALTER TABLE SERVICE_DOC_APPLICANTS_REF ADD CONSTRAINT UNQ1_DOC_TYPE_APPLICANT UNIQUE (gossrvc_service_doc_id,card_element_id);

--в случае если присутствуют дублированные записи, то необходимо их удалить. После удаления необходимо попытаться создать constraint заново.
--Скрипт для удаления дублированных записей:

/*
create table SERVICE_DOC_APPLICANTS_REF1 (
   gossrvc_service_doc_id number NOT NULL,
   card_element_id varchar(31) NOT NULL
);

insert into SERVICE_DOC_APPLICANTS_REF1 (gossrvc_service_doc_id, card_element_id)
select gossrvc_service_doc_id, card_element_id
from SERVICE_DOC_APPLICANTS_REF
group by  gossrvc_service_doc_id, card_element_id;

delete from SERVICE_DOC_APPLICANTS_REF;

insert into SERVICE_DOC_APPLICANTS_REF (gossrvc_service_doc_id, card_element_id)
select gossrvc_service_doc_id, card_element_id
from SERVICE_DOC_APPLICANTS_REF1;

select count(1) from SERVICE_DOC_APPLICANTS_REF1;

drop table SERVICE_DOC_APPLICANTS_REF1;
*/