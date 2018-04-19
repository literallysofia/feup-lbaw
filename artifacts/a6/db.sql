CREATE DOMAIN "Today" AS date NOT NULL DEFAULT ('now'::text)::date;


CREATE TABLE countries (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);

CREATE TABLE cities (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE,
    "country_id" integer NOT NULL REFERENCES countries(id) ON DELETE CASCADE
);

CREATE TABLE users (
    id serial PRIMARY KEY,
    name text NOT NULL,
    username text NOT NULL UNIQUE,
    email text NOT NULL UNIQUE,
    password text NOT NULL,
    nif integer UNIQUE
);

CREATE TABLE addresses (
    id serial PRIMARY KEY,
    name text NOT NULL,
    street text NOT NULL,
    "postal_code" text NOT NULL,
    "city_id" integer NOT NULL REFERENCES cities(id) ON DELETE CASCADE,
    "user_id" integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    "is_archived" boolean DEFAULT false NOT NULL
);

CREATE TABLE admins (
    "user_id" integer PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE categories (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE,
    "is_navbar_category" boolean DEFAULT false NOT NULL
);


CREATE TABLE properties (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);


CREATE TABLE category_properties (
    id serial PRIMARY KEY,
    "category_id" integer NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    "property_id" integer NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
    "is_required_property" boolean DEFAULT false NOT NULL
);

CREATE TABLE products (
    id serial PRIMARY KEY,
    name text NOT NULL,
    price double precision NOT NULL,
    "quantity_available" integer NOT NULL,
    score double precision NOT NULL,
    "category_id" integer NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    CONSTRAINT price CHECK ((price > (0)::double precision)),
    CONSTRAINT quantity_available CHECK ((quantity_available >= 0)),
    CONSTRAINT score CHECK (score >= 0 AND score <= 5)
);

CREATE TABLE archived_products (
    "product_id" integer PRIMARY KEY REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE delivery_types (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE,
    cost double precision NOT NULL UNIQUE
);

CREATE TABLE faqs (
    id serial PRIMARY KEY,
    question text NOT NULL UNIQUE,
    answer text NOT NULL
);

CREATE TABLE photos (
    id serial PRIMARY KEY,
    path text NOT NULL,
    "product_id" integer NOT NULL REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE product_carts (
    id serial PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    "product_id" integer NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    quantity integer NOT NULL,
    CONSTRAINT quantity CHECK ((quantity > 0))
);

CREATE TABLE purchases (
    id serial PRIMARY KEY,
    "date" TIMESTAMP WITH TIME zone DEFAULT now() NOT NULL,
    total double precision NOT NULL,
    "user_id" integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    "address_id" integer NOT NULL REFERENCES addresses(id) ON DELETE CASCADE,
    status text DEFAULT 'Processing'::text NOT NULL,
    CONSTRAINT status CHECK (status IN ('Processing', 'Shipped', 'Delivered')),
    CONSTRAINT total CHECK ((total > (0)::double precision))
);

CREATE TABLE product_purchases (
    "product_id" integer NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    "purchase_id" integer NOT NULL REFERENCES purchases(id) ON DELETE CASCADE,
    quantity integer NOT NULL,
    price double precision NOT NULL,
    CONSTRAINT price CHECK ((price > (0)::double precision)),
    CONSTRAINT quantity CHECK ((quantity > 0)),
    PRIMARY KEY ("product_id", "purchase_id")
);


CREATE TABLE reviews (
    "user_id" integer REFERENCES users(id) ON DELETE CASCADE,
    "product_id" integer REFERENCES products(id) ON DELETE CASCADE,
    score integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    CONSTRAINT score CHECK (((score >= 0) AND (score <= 5))),
    PRIMARY KEY ("user_id", "product_id")
);

CREATE TABLE values_lists (
    id serial PRIMARY KEY,
    "category_property_id" integer NOT NULL REFERENCES category_properties(id) ON DELETE CASCADE,
    "product_id" integer NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE("category_property_id", "product_id")
);

CREATE TABLE values (
    id serial PRIMARY KEY,
    name text,
    "values_list_id" integer NOT NULL REFERENCES values_lists(id) ON DELETE CASCADE
);


CREATE TABLE wishlists (
    "user_id" integer REFERENCES users(id) ON DELETE CASCADE,
    "product_id" integer REFERENCES products(id) ON DELETE CASCADE,
    PRIMARY KEY ("user_id", "product_id")
);

--Indexs

CREATE INDEX username_users ON users USING hash (username);

CREATE INDEX userid_addresses ON addresses USING hash (user_id);

CREATE INDEX userid_purchases ON purchases USING hash (user_id);

CREATE INDEX productid_reviews ON reviews USING hash (product_id);

CREATE INDEX categoryid_products ON products USING hash (category_id);

CREATE INDEX price_products ON products USING btree (price);

CREATE INDEX search_product ON products USING GIST (name);

--Triggers

CREATE FUNCTION update_product_score() RETURNS TRIGGER AS
$BODY$
BEGIN
	UPDATE products
	SET score = (AVG(score) FROM reviews WHERE product_id = New.product_id)
	WHERE "product_id" = New."product_id"
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER product_score AFTER INSERT OR UPDATE OR DELETE
ON reviews
EXECUTE PROCEDURE update_product_score();


CREATE FUNCTION add_review() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NOT EXISTS (SELECT Product.product_id
                 FROM purchases AS Purchases, product_purchases AS Product, users AS Users
                 WHERE Purchases.id = Product.purchase_id AND New.user_id = Purchases.user_id
                 AND New.product_id = Product.product_id AND Users.id = *LOGGED_USER_ID*) THEN
        RAISE EXCEPTION 'You can not review a product you have not purchased.';
    END IF;
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER add_review
BEFORE INSERT OR UPDATE ON review
FOR EACH ROW
EXECUTE PROCEDURE add_review();
            
CREATE FUNCTION check_purchases_quantities() RETURNS TRIGGER AS
$BODY$
BEGIN
	IF 
		NOT EXISTS (SELECT quantity_available FROM products WHERE id = New.product_id AND quantity_available >= New.quantity) 
	THEN
		RAISE EXCEPTION ’You can’t buy % items of product %’ , New.quantity, New.product_id
	END IF;
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_purchase_quantities BEFORE INSERT
ON product_purchases
FOR EACH ROW
EXECUTE PROCEDURE check_purchases_quantities();

CREATE FUNCTION clear_cart() RETURNS TRIGGER AS
$BODY$
BEGIN
	DELETE FROM product_carts
	WHERE "user_id" = New."user_id"
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER clear_cart AFTER INSERT
ON purchases
EXECUTE PROCEDURE clear_cart();


CREATE FUNCTION remove_wishlist_product() RETURNS TRIGGER AS
$BODY$
BEGIN
	DELETE FROM wishlist
	WHERE "user_id" = New."user_id"
  AND "product_id" = New."product_id"
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER remove_wishlist_product AFTER INSERT
ON product_carts
EXECUTE PROCEDURE remove_wishlist_product();

CREATE FUNCTION update_available_products() RETURNS TRIGGER AS
$BODY$
BEGIN
  UPDATE products
  SET quantity = quantity - New.quantity
  WHERE "product_id" = New."product_id"
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_available_products AFTER INSERT
ON product_purchases
EXECUTE PROCEDURE update_available_products();

CREATE FUNCTION archive_product() RETURN TRIGGER AS
$BODY$
BEGIN
	DELETE FROM whishlists
	WHERE product_id = NEW.id
	DELETE FROM product_carts
	WHERE product_id = NEW.id
	
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER archive_product AFTER INSERT
ON archived_products
FOR EACH ROW
EXECUTE PROCEDURE archive_product();
