INSERT INTO app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
VALUES (hibernate_sequence.nextval, null, 'inf_quest', 'Отображение функционала внутренних опросников', '1', false, '');

INSERT INTO app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
VALUES (hibernate_sequence.nextval, null, 'inf_module', 'Отображение функционала "Информационный модуль"', '1', false, '');

INSERT INTO app_setting (id, owner, setting_id, setting_name, setting_value, is_pass, setting_group)
VALUES (hibernate_sequence.nextval, null, 'inf_update', 'Автоматическая синхронизация настроек "Информационного модуля" с планшетами', '7;20', false, '');



