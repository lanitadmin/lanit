1) 
удалить с таблицы DOC_NUM_GEN уникальный ключ по полям DOC_TYPE,OWNER,PARENT_ID

2) 
ALTER TABLE DOC_NUM_GEN ADD CONSTRAINT UNQ1_DOC_NUM_GEN UNIQUE (DOC_TYPE,OWNER);