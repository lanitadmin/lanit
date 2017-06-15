--только для фиас
CREATE INDEX search_idx ON address_object USING btree(livestatus,   regioncode,   autocode,   areacode,   citycode,   ctarcode,   
placecode,   streetcode,   extrcode,   sextcode);

CREATE INDEX parent_addr_idx ON house USING btree (aoguid);

CREATE INDEX guid_ext_idx ON house USING btree (houseguid);