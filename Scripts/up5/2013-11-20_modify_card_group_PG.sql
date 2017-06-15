INSERT INTO card_group(group_code,owner,name_group) VALUES('Services', null, 'Услуги');
Update card set group_code = 'Services' where group_code = 'Услуги';
delete from CARD_GROUP where GROUP_CODE = 'Услуги';