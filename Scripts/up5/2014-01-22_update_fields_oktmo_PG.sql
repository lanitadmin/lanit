--Для изменения поля Справочника ОГВ с ОКАТО на ОКТМО

update card_field set field_name = 'ogv_oktmo', field_required = false, field_recommended = true, field_caption = 'ОКТМО' where field_name = 'ogv_okato';

--Сделать значения справочника ОГВ необходимые ГИСГМП рекомендуемыми / необязательными

update card_field set field_required = false, field_recommended = true where field_name = 'ogv_inn';
update card_field set field_required = false, field_recommended = true where field_name = 'ogv_kpp';
update card_field set field_required = false, field_recommended = true where field_name = 'ogv_ogrn';
update card_field set field_required = false, field_recommended = true where field_name = 'ogv_ogrn';
update card_field set field_required = false, field_recommended = true where field_name = 'ogv_kgadb';
update card_field set field_required = false, field_recommended = true, field_type='list:integer=1,расчетный;2,текущий;3,корреспондентский' where field_name = 'ogv_bankacctype';
update card_field set field_required = false, field_recommended = true where field_name = 'ogv_bankaccount';
update card_field set field_required = false, field_recommended = true where field_name = 'ogv_bancorracc';
update card_field set field_required = false, field_recommended = true, field_type='list:string=BIK,БИК;SWIFT,SWIFT' where field_name = 'ogv_bankId';
update card_field set field_required = false, field_recommended = true where field_name = 'ogv_bik';
update card_field set field_required = false, field_recommended = true where field_name = 'ogv_swift';
update card_field set field_required = false, field_recommended = true where field_name = 'ogv_licacc';
update card_field set field_required = false, field_recommended = true where field_name = 'ogv_ufkname';




--Сделать значения справочника ОГВ необходимые ГИСГМП рекомендуемыми / необязательными
update card_field set field_required = false, field_recommended = true where field_name = 'amount';
update card_field set field_required = false, field_recommended = true where field_name = 'bill_for';
update card_field set field_required = false, field_recommended = true where field_name = 'kbk';