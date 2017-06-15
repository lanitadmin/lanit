insert into Card(Card_code,card_Name,group_code,owner) values ('STypeCons','Виды обращения заявителя за консультацией','Услуги',null);

insert into CARD_ELEMENT(id,name,card_code,owner) values('consLichno','личное посещение','STypeCons',null);
insert into CARD_ELEMENT(id,name,card_code,owner) values('consPhone','по телефону','STypeCons',null);
insert into CARD_ELEMENT(id,name,card_code,owner) values('consWeb','через интернет','STypeCons',null);
insert into CARD_ELEMENT(id,name,card_code,owner) values('consEmail','по электронной почте','STypeCons',null);