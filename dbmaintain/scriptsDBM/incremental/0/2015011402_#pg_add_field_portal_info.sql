INSERT INTO card_field (field_id,field_caption,field_ident,field_name,field_size,field_type,field_visible,field_required,card_code,field_max_value,field_min_value,validator_id,field_readonly,field_recommended) 
VALUES (nextval('hibernate_sequence'),'Информация для отображения на портале МФЦ',null,'portal_info',2048,'string',true,null,'SService',null,null,null,false,null);

insert into app_setting (id, owner,setting_id,setting_name, setting_value,is_pass)
values(nextval('hibernate_sequence'), null,'show_service_portal_info','Отображать дополнительную информацию об услуге на портале МФЦ (0-нет, 1-да)', '0', false);
