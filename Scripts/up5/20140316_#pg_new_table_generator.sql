--!!! Важно, обязательно запустить перез запуском Jboss-а, иначе нумерация док-ов, пойдет с 1
create table hibernate_sequences (
        sequence_name varchar(255) not null primary key,
        next_val bigint not null default 1
);

insert into hibernate_sequences(sequence_name,next_val)
select COALESCE(owner,'')||'#'||doc_type,doc_no_value+1 from doc_num_gen where doc_no_value is not null;