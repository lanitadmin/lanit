-- После удаления таблицы необоходим перезапуск JBOSS изменилась схема таблицы
DROP TABLE ACTIVITY_SIGN;

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
VALUES ('allow_sign_docPackage', 'Разрешать подписывать комплект документов на шагах процесса', '0', hibernate_sequence.nextval, NULL);