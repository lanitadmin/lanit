insert into card_field(field_id,field_caption,field_ident,field_name,field_size,field_visible,field_required,card_code,field_max_value,field_min_value,validator_id,field_readonly,field_type)
                values (gen_id(hibernate_sequence,1),'Порядок следования элемента в списке',null,'sequenceList',2,true,null,'SDocClass',null,null,null,false,'integer');
