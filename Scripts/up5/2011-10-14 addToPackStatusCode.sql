
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'addingDocs', 'Донос документов');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'regKomplDoc', 'Регистрация заявителя и прием документов');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'redirected', 'Прошел распределение');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'reqRegKomplDoc', 'Регистрация запроса');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'kurierTransfer', 'Передан с курьером');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'electroTransfer', 'Электронный запрос');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'ogvExec', 'Исполнение запроса');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'reqDocRec', 'Прием документов из ОГВ');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'resultToZayav', 'Документы и результат услуги выданы заявителю');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'returnToOGV', 'Возврат документов в ОГВ в связи с неявкой заявителя');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'requestKomplDoc', 'Процесс запроса');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'serviceExec', 'Оказание услуги');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'OGVrquestExec', 'Обработка запроса в ОГВ');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'regComplaint', 'Регистрация обращения или жалобы');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'prepRespToZayav', 'Подготовка ответа заявителю');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'docVidacha', 'Документы и результат услуги на выдаче');
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME)
                      VALUES (gen_id( hibernate_sequence, 1), 'zaprosZayavit', 'Выдача документов для запроса заявителю');
                      
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME, NOT_VISIBLE, PORTALSTATUS)
                      VALUES (gen_id( hibernate_sequence, 1 ), 'transDocToOgv', 'Подготовка документов для передачи в ведомство', NULL, NULL);
INSERT INTO PACK_STATUS_CODE (ID, CODE, NAME, NOT_VISIBLE, PORTALSTATUS)
                      VALUES (gen_id( hibernate_sequence, 1 ), 'transDocFromOgv', 'Получение документов из ведомства', NULL, NULL);

COMMIT WORK;
