insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
values ('mkgu_card_rating_card_select_ogv_disable', 'Запрет выбора ОГВ в карточки оценки (1-да, 0-нет)', '0', hibernate_sequence.nextval, null, 'МКГУ');

insert into app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER, setting_group)
select 'mkgu_card_rating_card_select_ogv_disable', 'Запрет выбора ОГВ в карточки оценки (1-да, 0-нет)', '0', hibernate_sequence.nextval, owner, 'МКГУ' from org_unit;