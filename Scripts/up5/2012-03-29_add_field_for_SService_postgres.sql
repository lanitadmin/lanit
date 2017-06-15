--1)добавление дополнительного поля  'TypeDay' в картотеку услуга, поле не обязательно для заполения
INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (nextval('hibernate_sequence'),'TypeDay','list:integer=0,в календарных;1,в рабочих',1,'Тип дней',2,null,'SService');

--2)установление расширенного поля TypeDay в 0
update card_element_field_value 
set field_integer_value = 0
where id in
    (select f1.id from Card_element c, card_field f, card_element_field_value f1 where
        f.field_name = 'TypeDay'
        and f1.field_id = f.field_id
        and f1.card_element_id = c.id
        and f1.field_integer_value is null
    )  

