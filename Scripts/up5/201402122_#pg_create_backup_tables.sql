create table bkp_user_role_ref (user_id int, role_id int, rev_id timestamp);
create table bkp_cons_question_service_rf (cons_question_id int, card_element_id varchar(1024), rev_id timestamp);
create table bkp_cons_inquirer_categ_serv_r (cons_inquirer_id int, card_element_id varchar(1024), rev_id timestamp);
create table bkp_obj_gr_item_appl_ref (obj_gr_item_id int, card_element_id varchar(1024), rev_id timestamp);
create table bkp_service_doc_applicants_ref (gossrvc_service_doc_id int, card_element_id varchar(1024), rev_id timestamp);
create table bkp_service_doc_class_rf (service_doc_id int, card_element_id varchar(1024), rev_id timestamp);
create table bkp_doc_type_applicant_tree_re (doc_id int, type_applicant_tree_id int, rev_id timestamp);
create table bkp_service_doc_tree_applicant (service_doc_tree_id int, card_element_id varchar(1024), rev_id timestamp);
create table bkp_goal_type_applicant_tree_r (goal_id int,type_applicant_tree_id int, rev_id timestamp);
create table bkp_service_doc_tree_class_rf (service_doc_tree_id int, card_element_id varchar(1024), rev_id timestamp);
create table bkp_service_doc_goal_ref (gossrvc_service_doc_id int, goal_id int, rev_id timestamp);
create table bkp_service_doc_tree_ogvs_ref (service_doc_tree_id int, card_element_id varchar(1024), rev_id timestamp);