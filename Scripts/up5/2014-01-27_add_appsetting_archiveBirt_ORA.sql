--lodint/mfc/Ryazan/docArchive.rptdesign вот так должен выглядить путь до печатной формы

INSERT INTO app_setting (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
SELECT 'archivePrintBirt', 'Путь до печатной формы для электронного архива', 'lodint/mfc/Tver/docArchive.rptdesign', hibernate_sequence.nextval, owner FROM org_unit;