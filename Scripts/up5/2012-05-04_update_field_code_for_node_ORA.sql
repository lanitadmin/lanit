--1)
--необходимо удалить обязательность поля
ALTER TABLE GOSSRVC_SERVICE_ATTR MODIFY PARENT_ID NULL;
 
--2)
ALTER TABLE NODE MODIFY (CODE varchar2(50));
