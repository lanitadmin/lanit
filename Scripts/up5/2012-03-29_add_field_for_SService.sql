--1)добавление дополнительного поля  'TypeDay' в картотеку услуга, поле не обязательно для заполения
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (gen_id( hibernate_sequence, 1 ),'TypeDay','list:integer=0,в календарных;1,в рабочих',1,'Тип дней',2,null,'SService');

--2)установление расширенного поля TypeDay в 0
update card_element_field_value f
set f.field_integer_value = 0
where id in
    (select f1.id from Card_element c, card_field f, card_element_field_value f1 where
        f.field_name = 'TypeDay'
        and f1.field_id = f.field_id
        and f1.card_element_id = c.id
        and f1.field_integer_value is null
    )
    
INSERT INTO APP_SETTING (id,SETTING_ID,SETTING_NAME,SETTING_VALUE) VALUES 
((select gen_id( hibernate_sequence, 1 ) from RDB$DATABASE),'sm_cardId_WSDL','Путь к WSDL сервиса смарт-карты','http://192.168.61.27:82/RSC.asmx?WSDL');

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'sm_cardId_WSDL', 'Путь к WSDL сервиса смарт-карты', 'http://192.168.61.27:82/RSC.asmx?WSDL', gen_id( hibernate_sequence, 1), owner from org_unit;

