INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('wssecurity.keyStore', 'org.jboss.ws.wsse.keyStore', '/opt/jboss-mfc/ssl/store.store', gen_id( hibernate_sequence, 1 ), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('wssecurity.keyStorePassword', 'org.jboss.ws.wsse.keyStorePassword', '123456', gen_id( hibernate_sequence, 1 ), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('wssecurity.keyStoreType', 'org.jboss.ws.wsse.keyStoreType', 'HDImageStore', gen_id( hibernate_sequence, 1 ), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('wssecurity.trustStore', 'org.jboss.ws.wsse.trustStore', '/opt/jboss-mfc/ssl/store.store', gen_id( hibernate_sequence, 1 ), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('wssecurity.trustStorePassword', 'org.jboss.ws.wsse.trustStorePassword', '123456', gen_id( hibernate_sequence, 1 ), null);

INSERT INTO APP_SETTING (SETTING_ID, SETTING_NAME, SETTING_VALUE, ID, OWNER)
values ('wssecurity.trustStoreType', 'org.jboss.ws.wsse.trustStoreType', 'HDImageStore', gen_id( hibernate_sequence, 1 ), null);