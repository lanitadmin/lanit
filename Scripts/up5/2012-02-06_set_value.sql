update card_element_field_value f
set f.field_integer_value = 0
where id in
    (select f1.id from Card_element c, card_field f, card_element_field_value f1 where
        f.field_name = 'SelectType'
        and f1.field_id = f.field_id
        and f1.card_element_id = c.id
        and f1.field_integer_value is null
    )
