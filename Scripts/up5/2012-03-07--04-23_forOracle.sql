INSERT INTO PERMISSION_REF (id, AOBJECT, AACTION)
VALUES (hibernate_sequence.nextval,'Инфокиоск','изменять');


INSERT INTO CARD_FIELD (FIELD_ID,FIELD_NAME,FIELD_TYPE,FIELD_VISIBLE,FIELD_CAPTION,FIELD_SIZE,FIELD_IDENT,CARD_CODE)
VALUES (hibernate_sequence.nextval,'TypeDay','list:integer=0,в календарных;1,в рабочих',1,'Тип дней',2,null,'SService');

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
(hibernate_sequence.nextval,'sm_cardId_WSDL','Путь к WSDL сервиса смарт-карты','http://192.168.61.27:82/RSC.asmx?WSDL');

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'sm_cardId_WSDL', 'Путь к WSDL сервиса смарт-карты', 'http://192.168.61.27:82/RSC.asmx?WSDL', hibernate_sequence.nextval, owner from org_unit;

update CARD_ELEMENT_DEPENDENCE  d
set d.owner = (select c.owner from CARD_ELEMENT c where c.id = d.element_id);


INSERT INTO CARD (CARD_CODE, CARD_NAME, GROUP_CODE, OWNER) VALUES ('SGovLevel', 'Уровень власти', 'Услуги', NULL);

INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (hibernate_sequence.nextval, 'gosOrgGovLevel', 'cardElement=SGovLevel', 1, 'Уровень власти ОГВ', 0, NULL, 'SGosOrg', 0);
INSERT INTO CARD_FIELD (FIELD_ID, FIELD_NAME, FIELD_TYPE, FIELD_VISIBLE, FIELD_CAPTION, FIELD_SIZE, FIELD_IDENT, CARD_CODE, FIELD_REQUIRED)
VALUES (hibernate_sequence.nextval, 'serviceGovLevel', 'cardElement=SGovLevel', 1, 'Уровень власти услуги', 0, NULL, 'SService', 0);

INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('Municip','муниципальный','SGovLevel',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('Feder','федеральный','SGovLevel',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('Regional','региональный','SGovLevel',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('Respub','республиканский','SGovLevel',null);
INSERT INTO CARD_ELEMENT (ID,NAME,CARD_CODE,OWNER) VALUES ('Other','иной','SGovLevel',null);

update GOSSRVC_SERVICE_ATTR set countmode='one' where countmode is null or countmode='';
update GOSSRVC_SERVICE_ATTR set archive=0 where archive is null;
update GOSSRVC_SERVICE_ATTR set param_mode='in' where param_mode is null or param_mode='';
update GOSSRVC_SERVICE_ATTR set REQUIRED=1 where REQUIRED is null;