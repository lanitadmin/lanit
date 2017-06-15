--настройка для интеграции с СУО ЛАНИТ
insert into app_setting(id,owner,setting_id, setting_name,setting_value,is_pass) 
select hibernate_sequence.nextval, ou.owner, 'integration_queue_webserver_host', 'IP вебсервиса СУО', null, null from org_unit ou

--справочник префиксов
INSERT INTO card_group (group_code,owner) VALUES ('ЭлОчередь',null);
INSERT INTO card (card_code,card_name,owner,group_code) VALUES ('SPrefix','Префиксы талонов',null,'ЭлОчередь');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref1','А',null,'SPrefix');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref2','Б',null,'SPrefix');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref3','В',null,'SPrefix');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref4','Г',null,'SPrefix');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref5','Д',null,'SPrefix');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref6','Ж',null,'SPrefix');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref7','З',null,'SPrefix');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref8','И',null,'SPrefix');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref9','К',null,'SPrefix');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref10','Л',null,'SPrefix');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('pref11','М',null,'SPrefix');


--справочник типов отложения клиента в предварительную очередь
INSERT INTO card (card_code,card_name,owner,group_code) VALUES ('STypeCause','Причина отклонения клиента',null,'ЭлОчередь');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('cause1','Отсутствие паспорта',null,'STypeCause');
INSERT INTO card_element (id,name,owner,card_code) VALUES ('cause2','Отсутствие свидетельства о рождении',null,'STypeCause');