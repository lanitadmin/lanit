INSERT INTO app_setting (id,owner,setting_id,setting_name,setting_value,is_pass) VALUES (nextval('hibernate_sequence'),null,'cons_rep_quality_center_org_owner','код орг. ед. представляющей центр качества','repLocal',false);
INSERT INTO app_setting (id,owner,setting_id,setting_name,setting_value,is_pass) VALUES (nextval('hibernate_sequence'),null,'cons_rep_quality_center','(0-не является центром качества, 1-является центром качества)','0',false);
INSERT INTO app_setting (id,owner,setting_id,setting_name,setting_value,is_pass) VALUES (nextval('hibernate_sequence'),null,'cons_rep_timer_interval','интервал запуска таймера сбора консолидированной отчетности (в мин.)','60',false);
INSERT INTO app_setting (id,owner,setting_id,setting_name,setting_value,is_pass) VALUES (nextval('hibernate_sequence'),null,'cons_rep_bi_system_url','cons_rep_bi_system_url','http://192.168.0.153/pentaho/Login',false);