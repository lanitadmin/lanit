ALTER TABLE revinfo ALTER COLUMN rev SET DATA TYPE int8;
INSERT INTO revinfo(rev, revtstmp, user_id) SELECT cast(rev as  bit(32))::int8, revtstmp, user_id FROM revinfo WHERE rev<0;
ALTER TABLE permission_ref_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE declaration_item_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE contractor_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE contractor_type_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE role_ref_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE lic_object_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE agent_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE archive_card_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE archive_collection_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE archive_jcrfile_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE contractor_doc_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE declaration_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE grant_ref_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE contractor_doc_type_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE person_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE license_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE license_copy_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE org_unit_personal_account_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE user_role_ref_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE org_unit_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE user_permission_ref_aud ALTER COLUMN rev SET DATA TYPE int8;
ALTER TABLE user_ref_aud ALTER COLUMN rev SET DATA TYPE int8;
UPDATE declaration_item_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE permission_ref_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE contractor_type_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE contractor_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE role_ref_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE lic_object_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE agent_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE archive_card_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE archive_collection_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE archive_jcrfile_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE contractor_doc_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE declaration_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE grant_ref_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE contractor_doc_type_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE person_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE license_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE license_copy_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE org_unit_personal_account_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE user_role_ref_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE org_unit_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE user_permission_ref_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
UPDATE user_ref_aud SET rev = cast(rev as  bit(32))::int8 WHERE rev < 0;
DELETE FROM revinfo WHERE rev < 0;

