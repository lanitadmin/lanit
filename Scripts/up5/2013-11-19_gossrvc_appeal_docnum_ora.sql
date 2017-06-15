INSERT INTO doc_num_gen (id,owner,date_update,doc_name,doc_no_format,doc_no_value,doc_type,version,parent_id)
VALUES (hibernate_sequence.nextval,null,current_date,'Номер жалобы','[YEAR]/[COUNTER]',0,'GossrvcAppeal',0,null);

INSERT INTO doc_num_gen (id,owner,date_update,doc_name,doc_no_format,doc_no_value,doc_type,version,parent_id)
select hibernate_sequence.nextval,o.owner,current_date,'Номер жалобы','[YEAR]/[COUNTER]',0,'GossrvcAppeal',0,null from org_unit o;