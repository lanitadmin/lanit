
insert into permission_ref(id,aaction, add_check, aobject)
select hibernate_sequence.nextval, 'просмотр',null,br.path  from birt_report br where br.path not in (select pr.aobject FROM permission_ref pr where pr.aobject like '%lodint%');

insert into grant_ref(id, permission_id,role_id)
select hibernate_sequence.nextval, pr.id, rr.id from role_ref rr, permission_ref pr where pr.aobject like '%lodint%';