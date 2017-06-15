update gossrvc_doc_package
set test=false
where test is null;

update person
set test=false
where test is null;

update agent
set test=false
where test is null;

update org_unit
set is_test=false
where is_test is null;

update gossrvc_doc_package pack
set test=true
where exists (select p.id from person p, object_group_item i where p.test=true 
and p.id=i.object_id and i.object_class='org.cp.model.common.Person' 
and i.object_group_id=pack.applicant_group_id);

update gossrvc_doc_package pack
set test=true
where exists (select p.id from agent p, object_group_item i where p.test=true and 
p.id=i.object_id and i.object_class='org.cp.lodent.Agent' 
and i.object_group_id=pack.applicant_group_id);

update gossrvc_doc_package pack
set test=true
where pack.owner is not null and exists (select p.id from org_unit p where p.is_test=true and p.owner=pack.owner);