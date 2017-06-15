update gossrvc_service_attr
set input_mask = replace(input_mask, '9', '#')
where input_mask is not null;