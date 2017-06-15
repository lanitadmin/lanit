update APP_SETTING set setting_value = null where setting_id = 'soap_crypto_auto_keyStoreType' and owner is not null;
update APP_SETTING set setting_value = null where setting_id = 'soap_crypto_auto_alias' and owner is not null;
update APP_SETTING set setting_value = null where setting_id = 'soap_crypto_auto_password' and owner is not null;
