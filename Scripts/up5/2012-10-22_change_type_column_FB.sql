update RDB$FIELDS set RDB$FIELD_LENGTH = 255, RDB$CHARACTER_LENGTH = 255
where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
where (RDB$RELATION_NAME = 'GOSSRVC_SERVICE_DOC_TREE') and (RDB$FIELD_NAME = 'EXT_SERVICE'));

update RDB$FIELDS set RDB$FIELD_LENGTH = 255, RDB$CHARACTER_LENGTH = 255
where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
where (RDB$RELATION_NAME = 'REQUEST_TEMPLATE') and (RDB$FIELD_NAME = 'EXT_SERVICE'));