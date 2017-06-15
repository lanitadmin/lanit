--Справочник "Виды документов" используется ГИСГМП для указания документов, по которым могут быть рассчитаны альтернативные идентификаторы плательщика


--если нет группы справочников - добавляет
INSERT INTO card_group (group_code,owner) VALUES ('Платежи',null);
INSERT INTO card (card_code,card_name,owner,group_code) VALUES ('STypeDocum','Виды документов',null,'Платежи');

INSERT INTO card_element (id,name,card_code) VALUES ('doc01','Паспорт гражданина Российской Федерации','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc02','Свидетельство органов ЗАГСа, органа исполнительной  власти  или  органа местного самоуправления о  рождении гражданина','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc03','Паспорт моряка (удостоверение личности моряка)','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc04','Удостоверение личности военнослужащего Российской Федерации','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc05','Военный билет военнослужащего','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc06','Временное удостоверение личности гражданина Российской Федерации','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc07','Справка об освобождении из мест лишения свободы','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc08','Паспорт иностранного гражданина или удостоверение личности лица без гражданства','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc09','Вид на жительство в Российской Федерации','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc10','Разрешение на временное проживание','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc11','Удостоверение беженца','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc12','Миграционная карта','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc13','Паспорт гражданина СССР образца 1974 г. для некоторых категорий иностранных граждан и лиц без гражданства','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc21','Идентификационный номер налогоплательщика','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc22','Номер водительского удостоверения, выданного на территории РФ в соответствии с законодательством ','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc23','Учетный код Федеральной миграционной службы РФ','STypeDocum');
INSERT INTO card_element (id,name,card_code) VALUES ('doc24','Cвидетельство о регистрации транспортного средства','STypeDocum');

INSERT INTO card_field (field_id,field_caption,field_ident,field_name,field_size,field_type,field_visible,field_required,card_code,field_max_value,field_min_value,validator_id,field_readonly) VALUES (gen_id(hibernate_sequence,1),'Код типов документов',null,'code_typedoc',2,'string',true,true,'STypeDocum',null,null,null,false);

INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'22','doc22',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'11','doc11',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'07','doc07',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'01','doc01',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'09','doc09',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'24','doc24',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'03','doc03',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'21','doc21',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'06','doc06',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'02','doc02',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'08','doc08',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'04','doc04',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'12','doc12',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'05','doc05',(select field_id from card_field where field_name='code_typedoc'));
INSERT INTO card_element_field_value (id,field_date_value,field_integer_value,field_string_value,card_element_id,field_id) VALUES (gen_id(hibernate_sequence,1),null,null,'13','doc13',(select field_id from card_field where field_name='code_typedoc'));


--Удаление справочника

--delete from card_element_field_value where card_element_id like 'doc%';
--delete from card_field where card_code like 'STypeDocum';
--!! УДаление всей таблицы альтернативных идентификаторов !!! drop table p_identifier;
--delete from card_element where card_code like 'STypeDocum';
--delete from card card where card_code='STypeDocum';