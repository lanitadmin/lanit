update RDB$FIELDS set RDB$FIELD_LENGTH = 31, RDB$CHARACTER_LENGTH = 31
where RDB$FIELD_NAME = 
(select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS 
where (RDB$RELATION_NAME = 'OBJECT_GROUP') and (RDB$FIELD_NAME = 'MAIN_SERVICE_ID'));