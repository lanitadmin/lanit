--------------------------------------------------------------------------
-- Восстановление нормальной структуры БД по ORG_UNIT
--------------------------------------------------------------------------

-- 1. Удаление поля ORG_UNIT_ID из ROLE_REF и USER_REF

alter table ROLE_REF drop ORG_UNIT_ID;
 
alter table USER_REF drop ORG_UNIT_ID;


-- 2. Корректировка табл. DEPARTMENT

alter table DEPARTMENT add tmp numeric(18,0) not null;

update DEPARTMENT set tmp = org_unit_id;

ALTER TABLE DEPARTMENT DROP CONSTRAINT <Имя внешнего ключа на ORG_UNIT поле ID>;

ALTER TABLE DEPARTMENT DROP org_unit_id;

ALTER TABLE DEPARTMENT ALTER TMP TO ORG_UNIT_ID;


-- 3. Корректировка табл. ORG_UNIT

alter table ORG_UNIT add tmp numeric(18,0) not null;

alter table ORG_UNIT add parent_tmp numeric(18,0);

update  ORG_UNIT set tmp = id;

update  ORG_UNIT set parent_tmp = parent_id;

ALTER TABLE  ORG_UNIT DROP CONSTRAINT <Имя внешнего ключа на ORG_UNIT поле ID>;

ALTER TABLE ORG_UNIT DROP CONSTRAINT <Имя первичного ключа>;

ALTER TABLE  ORG_UNIT DROP id;

ALTER TABLE  ORG_UNIT DROP parent_id;

ALTER TABLE  ORG_UNIT ALTER tmp TO id;

ALTER TABLE  ORG_UNIT ALTER parent_tmp TO parent_id;


-- 4. Восстановление ключей

ALTER TABLE ORG_UNIT ADD PRIMARY KEY (ID);

ALTER TABLE ORG_UNIT ADD CONSTRAINT FK_ORG_UNIT_1 FOREIGN KEY (PARENT_ID) REFERENCES ORG_UNIT (ID);

ALTER TABLE DEPARTMENT ADD CONSTRAINT FK_DEPARTMENT_1 FOREIGN KEY (ORG_UNIT_ID) REFERENCES ORG_UNIT (ID);
