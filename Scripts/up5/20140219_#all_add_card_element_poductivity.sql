insert into card_group (group_code, owner,name_group) values ('Util',null,'Дополнительно');
insert into card(card_code,card_name,owner,group_code) values ('STypeProd','Виды показателей', null, 'Util');
insert into card_element(id,name,owner,card_code) values ('typProdExt','Продуктивность', null, 'STypeProd');
insert into card_element(id,name,owner,card_code) values ('typProdPriem','Прием', null, 'STypeProd');
insert into card_element(id,name,owner,card_code) values ('typProdVwd','Выдача', null, 'STypeProd');
insert into card_element(id,name,owner,card_code) values ('typProdConsL','Консультация', null, 'STypeProd');
insert into card_element(id,name,owner,card_code) values ('typProdConsPh','Звонки', null, 'STypeProd');
