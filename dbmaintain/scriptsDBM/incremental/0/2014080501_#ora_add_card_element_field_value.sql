DELETE
FROM card_element_field_value
WHERE field_id IN
    (SELECT field_id
     FROM card_field
     WHERE field_name = 'isActual');


INSERT INTO card_element_field_value (id, field_integer_value, card_element_id, field_id)
SELECT hibernate_sequence.nextval,
       '1',
       ce.id,
       cf.field_id
FROM card_field cf,
     card_element ce
WHERE ce.card_code IN ('SDocClass',
                       'SDocType',
                       'SGosOrg',
                       'SZType',
                       'STypeDocUL',
                       'SRayon')
  AND cf.field_name = 'isActual';