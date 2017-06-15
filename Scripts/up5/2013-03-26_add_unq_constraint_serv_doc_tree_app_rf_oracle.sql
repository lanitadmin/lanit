--универсальный скрипт для 3 СУБД (oracle, postgres, firebird)
--При прогоне, если вдруг возникнет ошибка, то скорее всего в таблице присутствуют дублированные записи.
ALTER TABLE SERVICE_DOC_TREE_APPLICANTS_RF ADD CONSTRAINT UNQ1_SERV_DOC_TREE_APP_RF UNIQUE (service_doc_tree_id,card_element_id);

--в случае если присутствуют дублированные записи, то необходимо их удалить. После удаления необходимо попытаться создать constraint заново.
--Скрипт для удаления дублированных записей:

/*
create table SERVICE_DOC_TREE_APPLICANTS_RF1 (
   service_doc_tree_id number NOT NULL,
   card_element_id varchar(31) NOT NULL
);


insert into SERVICE_DOC_TREE_APPLICANTS_RF1 (service_doc_tree_id, card_element_id)
select service_doc_tree_id, card_element_id
from SERVICE_DOC_TREE_APPLICANTS_RF
group by  service_doc_tree_id, card_element_id;

delete from SERVICE_DOC_TREE_APPLICANTS_RF;

insert into SERVICE_DOC_TREE_APPLICANTS_RF (service_doc_tree_id, card_element_id)
select service_doc_tree_id, card_element_id
from SERVICE_DOC_TREE_APPLICANTS_RF1;

select count(1) from SERVICE_DOC_TREE_APPLICANTS_RF;

drop table SERVICE_DOC_TREE_APPLICANTS_RF1;
*/