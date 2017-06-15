update card_element_field_value 
set field_integer_value = 0 
where field_id in (select field_id from card_field where field_name like 'IkShow' and card_code = 'SService') and field_integer_value is null;

insert into card_element_field_value (id, field_date_value, field_integer_value, field_string_value, card_element_id, field_id)
select nextval('hibernate_sequence'), null, field_integer_value, null, card_element_id, (select max(field_id) from card_field where card_code = 'SService' and field_name like 'ecuShow')
from card_element_field_value
where field_id in (select field_id from card_field where field_name like 'IkShow' and card_code = 'SService');