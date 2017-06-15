UPDATE CARD_FIELD
SET FIELD_CAPTION='Отображать услугу в ИК и на портале', FIELD_TYPE='list:integer=1,нет;0,да'
WHERE FIELD_NAME='IkShow' AND CARD_CODE = 'SService';

UPDATE CARD_FIELD
SET FIELD_CAPTION='Отображать услугу в ЕЦУ', FIELD_TYPE='list:integer=0,да;1,нет'
WHERE FIELD_NAME='ecuShow' AND CARD_CODE = 'SService';