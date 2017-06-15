--1. добавление уникального индекса в APP_SETTING на поля SETTING_ID,OWNER  
alter table APP_SETTING
add constraint UNQ1_APP_SETTING
unique (SETTING_ID,OWNER)

-- если ключ не ставится то нужно прогнать скрипт
--2 скрипт выводящий значения дублирующих полей элементов картотек
select ff1.id, ff1.card_element_id, ff1.field_id, (select field_name from card_field where field_id = ff1.field_id) as name,
ff1.FIELD_STRING_VALUE, ff1.FIELD_INTEGER_VALUE, ff1.FIELD_DATE_VALUE

from (
SELECT c.field_id as f_id , c.card_element_id as e_id
FROM card_element_field_value c
group by c.field_id, c.card_element_id
having count(*)>1
) ff, card_element_field_value ff1 where ff.f_id = ff1.field_id and ff.e_id = ff1.card_element_id
order by ff1.card_element_id, ff1.field_id

--если выбока не нулевая , просмотреть данные, если данные дублирующие то необходимо запустить обработку
--3 http://[имя или IP хоста где крутится сервер приложения МФЦ]/admin/ddc.seam

--4. добавление уникального индекса в CARD_ELEMENT_FIELD_VALUE на поля CARD_ELEMENT_ID,FIELD_ID
alter table CARD_ELEMENT_FIELD_VALUE
add constraint UNQ1_CARD_ELEMENT_FIELD_VALUE
unique (CARD_ELEMENT_ID,FIELD_ID)

--5. добавление уникального индекса в CARD_FIELD на поля FIELD_NAME,CARD_CODE 
alter table CARD_FIELD
add constraint UNQ1_CARD_FIELD
unique (FIELD_NAME,CARD_CODE)