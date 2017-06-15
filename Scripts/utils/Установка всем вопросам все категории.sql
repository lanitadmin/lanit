insert into CONS_QUESTION_SERVICE_RF (cons_question_id, card_element_id) 
select t1.QUE, t2.CAT from

(select c.id AS QUE from cons_question as c where c.code not like ('mkgu%')) t1,
(select ce.id AS CAT from card_element as ce where ce.card_code = 'SCatServ') t2

where not exists (select * from CONS_QUESTION_SERVICE_RF where cons_question_id = t1.QUE and card_element_id = t2.CAT );