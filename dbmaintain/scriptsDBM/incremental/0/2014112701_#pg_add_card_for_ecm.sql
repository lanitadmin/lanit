INSERT INTO card_group (group_code,owner,name_group) VALUES ('ecm',null,'Документооборот');
INSERT INTO card (card_code,card_name,owner,group_code) VALUES ('eDocClass','Вид документа',null,'ecm');

INSERT INTO card_field (field_id,field_caption,field_ident,field_name,field_size,field_type,field_visible,field_required,card_code,field_max_value,field_min_value,validator_id,field_readonly,field_recommended)
VALUES (nextval('hibernate_sequence'),'Код группы документа',null,'docNumCode',20,'string',true,null,'eDocClass',null,null,null,false,null);

INSERT INTO card_field (field_id,field_caption,field_ident,field_name,field_size,field_type,field_visible,field_required,card_code,field_max_value,field_min_value,validator_id,field_readonly,field_recommended)
VALUES (nextval('hibernate_sequence'),'Код вида документа',null,'docNumPrefix',20,'string',true,null,'eDocClass',null,null,null,false,null);

INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecm_incoming','Входящий документ',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecm_outgoing','Исходящий документ',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecm_internal','Внутренний документ',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecm_project','Проект документа',null,'eDocClass');

INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass1','Договор',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass2','Письмо',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass3','Приказ',null,'eDocClass');

INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass4','Договор',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass5','Письмо',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass6','Приказ',null,'eDocClass');

INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass7','Договор',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass8','Письмо',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass9','Приказ',null,'eDocClass');

INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass10','Договор',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass11','Письмо',null,'eDocClass');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('ecmDocClass12','Приказ',null,'eDocClass');


INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass1','ecm_incoming',null);
INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass2','ecm_incoming',null);
INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass3','ecm_incoming',null);

INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass4','ecm_outgoing',null);
INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass5','ecm_outgoing',null);
INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass6','ecm_outgoing',null);

INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass7','ecm_internal',null);
INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass8','ecm_internal',null);
INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass9','ecm_internal',null);

INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass10','ecm_project',null);
INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass11','ecm_project',null);
INSERT INTO card_element_dependence (id,owner,element_id,parent_element_id,weight) VALUES (nextval('hibernate_sequence'),null,'ecmDocClass12','ecm_project',null);


