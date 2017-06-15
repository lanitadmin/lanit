update card_field
set FIELD_TYPE = 'list:integer=0,один из;1,несколько из;2,все из',
	FIELD_REQUIRED = 1
where FIELD_NAME = 'SelectType';