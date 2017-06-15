update CARD_FIELD c
set c.field_required = null
where c.card_code = 'SDocType' and c.field_name = 'SelectType';