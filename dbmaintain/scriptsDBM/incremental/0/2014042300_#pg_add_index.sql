CREATE INDEX soap_context_var_idx1 ON soap_context_var USING btree (parent_id);
CREATE INDEX soap_context_hist_idx1 ON soap_context_hist USING btree (parent_context_id);
CREATE INDEX soap_options_var_idx1 ON soap_options_var USING btree (parent_id);
CREATE INDEX soap_options_template_idx1 ON soap_options_template USING btree (parent_id);