INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
select 'ik_menu', 'Название шаблона меню инфокиоска (.xhtml)', null, gen_id( hibernate_sequence, 1 ), owner from org_unit;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('ik_menu', 'Название шаблона меню инфокиоска (.xhtml)', null, gen_id( hibernate_sequence, 1 ), null);



