update RDB$FIELDS set RDB$FIELD_LENGTH = 4000, RDB$CHARACTER_LENGTH = 4000
where RDB$FIELD_NAME = (select RDB$FIELD_SOURCE from RDB$RELATION_FIELDS
where (RDB$RELATION_NAME = 'SOAP_CONTEXT') and (RDB$FIELD_NAME = 'INPUTVARS'));