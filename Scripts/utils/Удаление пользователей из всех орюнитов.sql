delete from user_role_ref where role_id in (select u.id from role_ref u where u.owner is not null);
delete from grant_ref where role_id in (select u.id from role_ref u where u.owner is not null);
delete from role_ref where id in (select u.id from role_ref u where u.owner is not null);
delete from bpms_resource;
delete from person_aud;
delete from agent_aud;
delete from ORG_UNIT_AUD;
delete from user_ref_aud;
delete from grant_ref_aud;
delete from permission_ref_aud;
delete from user_role_ref_aud;
delete from role_ref_aud;
delete from org_unit_personal_account_aud;
delete from revinfo;
delete from user_setting where user_id in (select u.id from user_ref u where u.owner is not null);
delete from user_role_ref where user_id in (select u.id from user_ref u where u.owner is not null);
delete from user_org_unit;
delete from user_ref where id in (select u.id from user_ref u where u.owner is not null);


----удадение орг-юнитов осторожно !!! спросить у Сергея Матвеева
update user_ref set department_id=null;
delete from department;
delete from report_settings;
update org_unit set parent_id = null;
delete from xpdl_visability;
delete from cons_history;
delete from org_unit_personal_account;
delete from org_unit_cased_fullname;
delete from org_unit;
delete from doc_num_gen where owner is not null;
delete from app_setting where owner is not null;



