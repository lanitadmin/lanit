insert into Card(Card_code,card_Name,group_code,owner) values ('STemplMess','Шаблоны сообщений, отсылаемых на портал','Услуги',null);
insert into CARD_ELEMENT(id,name,card_code,owner) values('mesAccept','Заявление принято','STemplMess',null);
insert into CARD_ELEMENT(id,name,card_code,owner) values('mesNoAccept','В принятии заявления отказано','STemplMess',null);
insert into CARD_ELEMENT(id,name,card_code,owner) values('mesComplDocPack','Необходимо дополнить комплект документов','STemplMess',null);
insert into CARD_ELEMENT(id,name,card_code,owner) values('mesServiceCompl','Услуга оказана','STemplMess',null);
insert into CARD_ELEMENT(id,name,card_code,owner) values('mesServiceNoCompl','В услуге отказано','STemplMess',null);