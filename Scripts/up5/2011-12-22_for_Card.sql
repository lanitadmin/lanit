update card_field
set FIELD_TYPE = 'list:integer=0,Новая;1,Старая',
	FIELD_REQUIRED = 1
where FIELD_NAME = 'ServiceType'