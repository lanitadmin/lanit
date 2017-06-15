--!!! Важно, обязательно запустить перез запуском Jboss-а, иначе нумерация док-ов, пойдет с 1
create table hibernate_sequences (
        sequence_name varchar2(255) PRIMARY KEY NOT NULL,
        next_val decimal(19) not null
);

insert into hibernate_sequences(sequence_name,next_val)
select COALESCE(owner,'')||'#'||doc_type,doc_no_value+1 from doc_num_gen where doc_no_value is not null;