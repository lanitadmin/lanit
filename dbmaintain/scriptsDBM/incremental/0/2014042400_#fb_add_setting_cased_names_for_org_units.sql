insert into APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('use_cased_org_unit_names',
'Использовать возможность создания наименований ОГВ в различных падежах (0 - выкл., 1 - вкл.)', '1', gen_id( hibernate_sequence, 1 ), null);