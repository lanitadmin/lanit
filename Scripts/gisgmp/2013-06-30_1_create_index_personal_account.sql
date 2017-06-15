alter table org_unit drop column ACCOUNT_ID;
alter table mfc.charge_template drop column PERSONAL_ACCOUNT_ID;
CREATE INDEX PERSONAL_ACCOUNT_IDX1 ON PERSONAL_ACCOUNT (ACCOUNT_CODE);
