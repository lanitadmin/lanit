-- Заменяет код ОГВ в полях "Государственный регистрирующий орган" на наименование ОГВ
update AGENT tbl1 set GOV_REG_OGV = (select tbl2.name from CARD_ELEMENT tbl2  where tbl2.ID = tbl1.GOV_REG_OGV) 
where tbl1.GOV_REG_OGV in (select id from CARD_ELEMENT where CARD_CODE = 'SGosOrg') and tbl1.GOV_REG_OGV is not null
