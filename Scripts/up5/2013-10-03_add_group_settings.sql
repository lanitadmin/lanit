-- Репозиторий
update app_setting set setting_group = 'Репозиторий' where setting_id = 'repo_service_is_reestr';
update app_setting set setting_group = 'Репозиторий' where setting_id = 'repo_service_url';
update app_setting set setting_group = 'Репозиторий' where setting_id = 'wssecurity.keyStore';
update app_setting set setting_group = 'Репозиторий' where setting_id = 'wssecurity.keyStoreAlias';
update app_setting set setting_group = 'Репозиторий' where setting_id = 'wssecurity.keyStorePassword';
update app_setting set setting_group = 'Репозиторий' where setting_id = 'wssecurity.keyStoreType';
update app_setting set setting_group = 'Репозиторий' where setting_id = 'repo_service_test';

-- Инфокиоск
update app_setting set setting_group = 'Инфокиоск' where setting_id = 'theme_ik';
update app_setting set setting_group = 'Инфокиоск' where setting_id = 'ik_edit_superAdmin';
update app_setting set setting_group = 'Инфокиоск' where setting_id = 'ik_menu';

-- МКГУ
update app_setting set setting_group = 'МКГУ' where setting_id = 'soap_mkgu_id';
update app_setting set setting_group = 'МКГУ' where setting_id = 'mkgu_uri_send_rating';
update app_setting set setting_group = 'МКГУ' where setting_id = 'mkgu_uri_status_rating';
update app_setting set setting_group = 'МКГУ' where setting_id = 'send_rating_timer_period';
update app_setting set setting_group = 'МКГУ' where setting_id = 'mkgu_uri_current_form';
update app_setting set setting_group = 'МКГУ' where setting_id = 'mkgu_prefixCodeInquirer';
update app_setting set setting_group = 'МКГУ' where setting_id = 'mkgu_prefixNameInquirer';
update app_setting set setting_group = 'МКГУ' where setting_id = 'soap_mkgu_vendor_id';

-- ОГВ
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_address';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_boss_name';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_boss_post';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_fax';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_index';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_mail';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_name';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_name_acronym';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_phones';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_administration';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_country';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_federal_district';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_inn';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_kpp';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_ogrn';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_signature_name';
update app_setting set setting_group = 'ОГВ' where setting_id = 'ogv_signature_post';

-- Интеграция с электронной очередью
update app_setting set setting_group = 'Интеграция с электронной очередью' where setting_id = 'integration_queue';
update app_setting set setting_group = 'Интеграция с электронной очередью' where setting_id = 'integration_queue_pack_id';
update app_setting set setting_group = 'Интеграция с электронной очередью' where setting_id = 'integration_queue_process_id';
update app_setting set setting_group = 'Интеграция с электронной очередью' where setting_id = 'integration_queue_responce';
update app_setting set setting_group = 'Интеграция с электронной очередью' where setting_id = 'integration_queue_responce_local';
update app_setting set setting_group = 'Интеграция с электронной очередью' where setting_id = 'integration_queue_template_soap';
update app_setting set setting_group = 'Интеграция с электронной очередью' where setting_id = 'integration_queue_type_sequence';

-- Интеграция с call-центром
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_asterisk_host';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_ami_pwd';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_agi_port';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_timer_period_ms';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_start_on_deploy';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_asterisk_host';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_ami_remote_port';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_sound_dir';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_repeat_call_after_hour';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_permit_call_interval_end_hour';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_permit_call_interval_begin_hour';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_permit_call_days_of_week';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_callerid';
update app_setting set setting_group = 'Интеграция с call-центром' where setting_id = 'integration_callcenter_ami_username';