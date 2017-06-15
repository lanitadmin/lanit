-- Добавление переменной 'План. дата оказания услуги' в настройки отображения Моих задач 


-- 1. Поиск ID раздела, в который добавляется поле настройки
SELECT ID FROM SETTING_TABLE_DEF WHERE CAPTION = 'Мои задачи';

-- 2. Добавление поля настройки
INSERT INTO SETTING_TABLE_FIELD (ID, CAPTION, NAME, TABLE_DEF_ID) VALUES (gen_id( hibernate_sequence, 1), 'План. дата оказания услуги', 'proc_ident.dateServEnd', <результат запроса в п.1>);

-- 3. Поиск роли/пользователя, для которого необходимо добавить поле настройки
SELECT ID FROM SETTING_TABLE WHERE ROLE_CODE = <Код роли, для которой нужно добавить поле настройки>
SELECT ID FROM SETTING_TABLE WHERE USER_NAME = <Логин пользователя, для которого нужно добавить поле настройки>

-- 4. Добавление поля настройки для конкретной роли/ конкретного пользователя
INSERT INTO SETTING_TABLE_FIELD_VALUE (ID, ENABLE, PRIORITY, VISIBLE, FIELD_ID, TABLE_RULE_ID)
VALUES (gen_id( hibernate_sequence, 1), 1, 16, 1, <ID записи, добавленной при выполнении скрипта в п.2>, <ID роли/пользователя, полученный при выполнении скрипта в п.3>);
