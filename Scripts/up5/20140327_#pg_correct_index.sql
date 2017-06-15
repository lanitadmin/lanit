CREATE INDEX gossrvc_doc_package_item_idx_4 ON gossrvc_doc_package_item  USING btree (added_user);
DROP INDEX "имя индекса на поле doc_level таблицы gossrvc_doc_package_item" RESTRICT;
DROP INDEX "имя индекса на поле is_result таблицы gossrvc_doc_package_item" RESTRICT;