-- Скрипт выполнять после запуска JBOSS с ear'ом из обновления (чтобы новые поля и таблицы уже были созданы)  
update SERVICE_INTEGRATION set XPDL_ID = 'MFC_plus';

update ACTIVITY_REPORT_REF set XPDL_ID = 'MFC_plus', XPDL_NAME = 'Процессы оказания государственных и муниципальных услуг';

--update ORG_UNIT set USE_COMMON_PACK = 1;

update BPMS_XPDL set OWNER = null;

--Вставка исходных данных в табл. видимости пакетов для орг.единиц 
insert into XPDL_VISABILITY (ID, IS_VISIBLE, ORG_UNIT, XPDL_ID, XPDL_NAME, OWNER)
select gen_id(hibernate_sequence, 1), 1, o.id, x.bpms_xpdl_id, 'Процессы оказания государственных и муниципальных услуг', null
from org_unit o, bpms_xpdl x where x.bpms_current = 1 and x.bpms_inhistory = 0;

update XPDL_VISABILITY set xpdl_name = 'Адаптер' where xpdl_id = 'adapter';

update XPDL_VISABILITY set xpdl_name = xpdl_id where xpdl_id not in ('adapter','MFC_plus');



insert into SECURABLE (ID, AOBJECT, OWNER)
select id, 'entity.ActivityReport', null from ACTIVITY_REPORT_REF;