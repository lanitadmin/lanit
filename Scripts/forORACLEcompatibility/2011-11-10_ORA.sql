1) Добавление полей в ORG_UNIT

alter table ORG_UNIT add "JCR_CONTENT_SIZE" NUMBER(19,0);
alter table ORG_UNIT add "JCR_FILES_COUNT" NUMBER(19,0);

update ORG_UNIT set JCR_CONTENT_SIZE = 0;
update ORG_UNIT set JCR_FILES_COUNT = 0;


2) Добавление параметра в APP_SETTING (Нужно добавить параметр для каждой записи из табл. ORG_UNIT)

insert into app_setting (ID, OWNER, SETTING_ID, SETTING_NAME, SETTING_VALUE) 
values (hibernate_sequence.NEXTVAL, ???,  'jcr_content_limit', 'Лимит объема репозитария для хранения файлов, ГБайт', ???);
