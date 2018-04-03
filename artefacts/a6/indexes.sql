CREATE INDEX username_users ON users USING hash (username);
CREATE INDEX userid_addresses ON addresses USING hash (user_id);
CREATE INDEX userid_purchases ON purchases USING hash (user_id);
CREATE INDEX productid_reviews ON reviews USING hash (product_id);
CREATE INDEX categoryid_products ON products USING hash (category_id);
CREATE INDEX price_products ON products USING btree (price);
CREATE INDEX search_product ON products USING GIST (to_tsvector('english', name));
