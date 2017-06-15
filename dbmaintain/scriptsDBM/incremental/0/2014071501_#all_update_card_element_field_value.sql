DELETE FROM card_element_field_value WHERE field_id = (SELECT field_id FROM card_field WHERE field_name = 'docExample') AND (field_string_value is null OR field_string_value = '');

UPDATE card_element_field_value
SET field_id = (SELECT field_id FROM card_field WHERE field_name = 'docExample')
WHERE card_element_id IN (SELECT card_element_id FROM card_element_field_value WHERE field_id = (SELECT field_id FROM card_field WHERE field_name = 'isExample') AND field_integer_value = 1)
AND field_id = (SELECT field_id FROM card_field WHERE field_name = 'docTemplate')
AND field_string_value is not null;