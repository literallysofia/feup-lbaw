DROP DOMAIN IF EXISTS "Today" CASCADE;
CREATE DOMAIN "Today" AS date NOT NULL DEFAULT ('now'::text)::date;

DROP TABLE IF EXISTS countries CASCADE;
CREATE TABLE countries (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);

DROP TABLE IF EXISTS cities CASCADE;
CREATE TABLE cities (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE,
    "country_id" integer NOT NULL REFERENCES countries(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
    id serial PRIMARY KEY,
    name text NOT NULL,
    username text NOT NULL UNIQUE,
    email text NOT NULL UNIQUE,
    password text NOT NULL,
    nif integer UNIQUE,
    remember_token VARCHAR,
    "is_archived" boolean DEFAULT false NOT NULL    
);

DROP TABLE IF EXISTS addresses CASCADE;
CREATE TABLE addresses (
    id serial PRIMARY KEY,
    name text NOT NULL,
    street text NOT NULL,
    "postal_code" text NOT NULL,
    "city_id" integer NOT NULL REFERENCES cities(id) ON DELETE CASCADE,
    "user_id" integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    "is_archived" boolean DEFAULT false NOT NULL
);

DROP TABLE IF EXISTS admins CASCADE;
CREATE TABLE admins (
    "user_id" integer PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE
);


DROP TABLE IF EXISTS categories CASCADE;
CREATE TABLE categories (
    id serial PRIMARY KEY,
    name text NOT NULL,
    "is_navbar_category" boolean DEFAULT false NOT NULL,
    "is_archived" boolean DEFAULT false NOT NULL
);

DROP TABLE IF EXISTS properties CASCADE;
CREATE TABLE properties (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);

DROP TABLE IF EXISTS category_properties CASCADE;
CREATE TABLE category_properties (
    id serial PRIMARY KEY,
    "category_id" integer NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    "property_id" integer NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
    "is_required_property" boolean DEFAULT false NOT NULL
);

DROP TABLE IF EXISTS products CASCADE;
CREATE TABLE products (
    id serial PRIMARY KEY,
    name text NOT NULL,
    price double precision NOT NULL,
    "quantity_available" integer NOT NULL,
    score double precision DEFAULT 0 NOT NULL ,
    "category_id" integer NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    brand text NOT NULL,
    "is_archived" boolean DEFAULT false NOT NULL,
    CONSTRAINT price CHECK ((price > (0)::double precision)),
    CONSTRAINT quantity_available CHECK ((quantity_available >= 0)),
    CONSTRAINT score CHECK (score >= 0 AND score <= 5)
);


DROP TABLE IF EXISTS archived_products CASCADE;


DROP TABLE IF EXISTS delivery_types CASCADE;
CREATE TABLE delivery_types (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE,
    price double precision NOT NULL UNIQUE
);

DROP TABLE IF EXISTS faqs CASCADE;
CREATE TABLE faqs (
    id serial PRIMARY KEY,
    question text NOT NULL UNIQUE,
    answer text NOT NULL
);

DROP TABLE IF EXISTS photos CASCADE;
CREATE TABLE photos (
    id serial PRIMARY KEY,
    path text NOT NULL,
    "product_id" integer NOT NULL REFERENCES products(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS product_carts CASCADE;
CREATE TABLE product_carts (
    id serial PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    "product_id" integer NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    quantity integer NOT NULL,
    CONSTRAINT quantity CHECK ((quantity > 0)),
    UNIQUE("user_id", "product_id")
);

DROP TABLE IF EXISTS purchases CASCADE;
CREATE TABLE purchases (
    id serial PRIMARY KEY,
    "date" TIMESTAMP WITH TIME zone DEFAULT now() NOT NULL,
    total double precision NOT NULL,
    "user_id" integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    "address_id" integer NOT NULL REFERENCES addresses(id) ON DELETE CASCADE,
    "delivery_type_id" integer NOT NULL REFERENCES delivery_types(id) ON DELETE CASCADE,
    status text DEFAULT 'Processing'::text NOT NULL,
    CONSTRAINT status CHECK (status IN ('Processing', 'Shipped', 'Delivered')),
    CONSTRAINT total CHECK ((total > (0)::double precision))
);

DROP TABLE IF EXISTS product_purchase CASCADE;
CREATE TABLE product_purchase (
    "product_id" integer NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    "purchase_id" integer NOT NULL REFERENCES purchases(id) ON DELETE CASCADE,
    quantity integer NOT NULL,
    price double precision NOT NULL,
    CONSTRAINT price CHECK ((price > (0)::double precision)),
    CONSTRAINT quantity CHECK ((quantity > 0)),
    PRIMARY KEY ("product_id", "purchase_id")
);

DROP TABLE IF EXISTS reviews CASCADE;
CREATE TABLE reviews (
    id serial PRIMARY KEY,
    "user_id" integer REFERENCES users(id) ON DELETE CASCADE,
    "product_id" integer REFERENCES products(id) ON DELETE CASCADE,
    score integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    "date" TIMESTAMP WITH TIME zone DEFAULT now() NOT NULL,
    CONSTRAINT score CHECK (((score >= 0) AND (score <= 5))),
    UNIQUE("user_id", "product_id")
);

DROP TABLE IF EXISTS values_lists CASCADE;
CREATE TABLE values_lists (
    id serial PRIMARY KEY,
    "category_property_id" integer NOT NULL REFERENCES category_properties(id) ON DELETE CASCADE,
    "product_id" integer NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE("category_property_id", "product_id")
);

DROP TABLE IF EXISTS values CASCADE;
CREATE TABLE values (
    id serial PRIMARY KEY,
    name text,
    "values_lists_id" integer NOT NULL REFERENCES values_lists(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS wishlists CASCADE;
CREATE TABLE wishlists (
    "user_id" integer REFERENCES users(id) ON DELETE CASCADE,
    "product_id" integer REFERENCES products(id) ON DELETE CASCADE,
    PRIMARY KEY ("user_id", "product_id")
);


/** PASSWORD RESET **/
-- Table: public.password_resets

DROP TABLE IF EXISTS password_resets CASCADE;
CREATE TABLE password_resets
(
    id SERIAL PRIMARY KEY,
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    token character varying(255) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
)
WITH (OIDS = FALSE)
TABLESPACE pg_default;


DROP INDEX IF EXISTS password_resets_email_index;
CREATE INDEX password_resets_email_index
    ON password_resets USING btree
    (email COLLATE pg_catalog."default")
    TABLESPACE pg_default;



DROP INDEX IF EXISTS password_resets_token_index;
CREATE INDEX password_resets_token_index
    ON password_resets USING btree
    (token COLLATE pg_catalog."default")
    TABLESPACE pg_default;

-- Index: product_title_index

-- DROP INDEX public.product_title_index;
DROP INDEX IF EXISTS product_title_index;
CREATE INDEX product_title_index
    ON products USING GIN
    (to_tsvector('english', name));


/** TRIGGERS **/

DROP FUNCTION IF EXISTS remove_wishlist_product() CASCADE;
CREATE FUNCTION remove_wishlist_product() RETURNS TRIGGER AS
$$
BEGIN
	DELETE FROM wishlists
	    WHERE "user_id" = NEW."user_id"
        AND "product_id" = NEW."product_id";
    RETURN NEW;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS remove_wishlist_product ON product_carts CASCADE;  
CREATE TRIGGER remove_wishlist_product AFTER INSERT
ON product_carts
FOR EACH ROW EXECUTE PROCEDURE remove_wishlist_product();


DROP FUNCTION IF EXISTS check_product_quantities() CASCADE;
CREATE FUNCTION check_product_quantities() RETURNS TRIGGER AS
$$
BEGIN
	IF 
		NOT EXISTS (SELECT quantity_available FROM products WHERE id = New.product_id AND quantity_available >= New.quantity) 
	THEN
		RAISE EXCEPTION 'You can’t buy % items of product %' , New.quantity, New.product_id;
	END IF;
	RETURN NEW;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_product_quantities ON product_carts CASCADE;  
CREATE TRIGGER check_product_quantities BEFORE INSERT OR UPDATE
ON product_carts
FOR EACH ROW
EXECUTE PROCEDURE check_product_quantities();


DROP TRIGGER IF EXISTS check_product_quantities ON product_purchase CASCADE;  
CREATE TRIGGER check_product_quantities BEFORE INSERT OR UPDATE
ON product_purchase
FOR EACH ROW
EXECUTE PROCEDURE check_product_quantities();


DROP FUNCTION IF EXISTS update_available_products() CASCADE;
CREATE FUNCTION update_available_products() RETURNS TRIGGER AS
$$
BEGIN
  UPDATE products
  SET quantity_available = quantity_available - New.quantity
  WHERE id = New."product_id";
  RETURN NEW;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_available_products ON product_purchase CASCADE;  
CREATE TRIGGER update_available_products AFTER INSERT
ON product_purchase 
FOR EACH ROW
EXECUTE PROCEDURE update_available_products();



DROP FUNCTION IF EXISTS update_product_score() CASCADE;
CREATE FUNCTION update_product_score() RETURNS TRIGGER AS
$$
BEGIN
	UPDATE products
	SET score = (SELECT AVG(score) FROM reviews WHERE product_id = New.product_id)
	WHERE id = New."product_id";
    RETURN NEW;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS product_score ON reviews CASCADE;  
CREATE TRIGGER product_score AFTER INSERT OR UPDATE
ON reviews
FOR EACH ROW
EXECUTE PROCEDURE update_product_score();

DROP FUNCTION IF EXISTS update_product_score_delete() CASCADE;
CREATE FUNCTION update_product_score_delete() RETURNS TRIGGER AS
$$
BEGIN
	UPDATE products
	SET score = (SELECT AVG(score) FROM reviews WHERE product_id = OLD.product_id)
	WHERE id = OLD."product_id";
    RETURN OLD;
END
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS product_score_delete ON reviews CASCADE;  
CREATE TRIGGER product_score_delete AFTER DELETE
ON reviews
FOR EACH ROW
EXECUTE PROCEDURE update_product_score_delete();

/** POPULATE **/

/*COUNTRIES*/
INSERT INTO countries (name) VALUES ('France');
INSERT INTO countries (name) VALUES ('Germany');
INSERT INTO countries (name) VALUES ('Italy');
INSERT INTO countries (name) VALUES ('Netherlands');
INSERT INTO countries (name) VALUES ('Portugal');
INSERT INTO countries (name) VALUES ('Spain');
INSERT INTO countries (name) VALUES ('United Kingdom');

/*CITIES*/
INSERT INTO cities (name, "country_id") VALUES ('Paris', 1);
INSERT INTO cities (name, "country_id") VALUES ('Marselha', 1);
INSERT INTO cities (name, "country_id") VALUES ('Lyon', 1);
INSERT INTO cities (name, "country_id") VALUES ('Berlin', 2);
INSERT INTO cities (name, "country_id") VALUES ('Frankfurt', 2);
INSERT INTO cities (name, "country_id") VALUES ('Florence', 3);
INSERT INTO cities (name, "country_id") VALUES ('Milan', 3);
INSERT INTO cities (name, "country_id") VALUES ('Turin', 3);
INSERT INTO cities (name, "country_id") VALUES ('Amsterdam', 4);
INSERT INTO cities (name, "country_id") VALUES ('Delft', 4);
INSERT INTO cities (name, "country_id") VALUES ('Naarden', 4);
INSERT INTO cities (name, "country_id") VALUES ('Aveiro', 5);
INSERT INTO cities (name, "country_id") VALUES ('Beja', 5);
INSERT INTO cities (name, "country_id") VALUES ('Braga', 5);
INSERT INTO cities (name, "country_id") VALUES ('Bragança', 5);
INSERT INTO cities (name, "country_id") VALUES ('Coimbra', 5);
INSERT INTO cities (name, "country_id") VALUES ('Faro', 5);
INSERT INTO cities (name, "country_id") VALUES ('Leiria', 5);
INSERT INTO cities (name, "country_id") VALUES ('Lisboa', 5);
INSERT INTO cities (name, "country_id") VALUES ('Porto', 5);
INSERT INTO cities (name, "country_id") VALUES ('Santarém', 5);
INSERT INTO cities (name, "country_id") VALUES ('Viana do Castelo', 5);
INSERT INTO cities (name, "country_id") VALUES ('Viseu', 5);
INSERT INTO cities (name, "country_id") VALUES ('Barcelona', 6);
INSERT INTO cities (name, "country_id") VALUES ('Madrid', 6);
INSERT INTO cities (name, "country_id") VALUES ('London', 7);
INSERT INTO cities (name, "country_id") VALUES ('Manchester', 7);
INSERT INTO cities (name, "country_id") VALUES ('Birmingham', 7);
INSERT INTO cities (name, "country_id") VALUES ('Liverpool', 7);

/*USERS*/
INSERT INTO users (name, username, email, password) VALUES ('Administrator', 'swevenAdmin', 'sweventechshop@gmail.com', '$2y$10$3Wc9dkxovmxwQZObfnJfEuOiTDCPPNPL6HdYKpQ/I7qbQrP9U58AK'); /*password: Sweven61*/
INSERT INTO users (name, username, email, password) VALUES ('Stiles Stilinski', 'stiles', 'stiles@gmail.com', '$2y$10$3Wc9dkxovmxwQZObfnJfEuOiTDCPPNPL6HdYKpQ/I7qbQrP9U58AK');
INSERT INTO users (name, username, email, password) VALUES ('Scott McCall', 'scottmc', 'scottmccall@gmail.com', '$2y$10$3Wc9dkxovmxwQZObfnJfEuOiTDCPPNPL6HdYKpQ/I7qbQrP9U58AK');
INSERT INTO users (name, username, email, password) VALUES ('Allison Argent', 'argent', 'allisonargent@gmail.com', '$2y$10$3Wc9dkxovmxwQZObfnJfEuOiTDCPPNPL6HdYKpQ/I7qbQrP9U58AK');
INSERT INTO users (name, username, email, password) VALUES ('Lydia Martin', 'lydiamartin', 'lydiamartin@gmail.com', '$2y$10$3Wc9dkxovmxwQZObfnJfEuOiTDCPPNPL6HdYKpQ/I7qbQrP9U58AK');
INSERT INTO users (name, username, email, password) VALUES ('Jackson Whittemore', 'jackson', 'jacksonwhittemore@gmail.com', '$2y$10$3Wc9dkxovmxwQZObfnJfEuOiTDCPPNPL6HdYKpQ/I7qbQrP9U58AK');

/*ADDRESSES*/
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Abbey Road', '18740-000', 26, 2);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('company', 'Baker Street', '18740-000', 26, 2);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('company', 'Essex Street', '22205', 20, 3);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Hills Place', '88000-000', 3, 4);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Old Gravel Lane', '151287', 24, 5);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Richmond Mews West', '22205', 9, 6);

/*ADMINS*/
INSERT INTO admins ("user_id") VALUES (1);

/*CATEGORIES*/
INSERT INTO categories (name, "is_navbar_category") VALUES ('Smartphones', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Tablets', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Computers', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Monitors', false);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Accessories', true);

/*PROPERTIES*/
INSERT INTO properties (name) VALUES ('Finish');
INSERT INTO properties (name) VALUES ('Operating System');
INSERT INTO properties (name) VALUES ('Display');
INSERT INTO properties (name) VALUES ('Processor');
INSERT INTO properties (name) VALUES ('RAM Memory');
INSERT INTO properties (name) VALUES ('Graphics');
INSERT INTO properties (name) VALUES ('Storage');
INSERT INTO properties (name) VALUES ('Size and Weight');
INSERT INTO properties (name) VALUES ('Wireless');
INSERT INTO properties (name) VALUES ('Camera');
INSERT INTO properties (name) VALUES ('Audio');
INSERT INTO properties (name) VALUES ('Power and Battery');
INSERT INTO properties (name) VALUES ('Interface');
INSERT INTO properties (name) VALUES ('Software');
INSERT INTO properties (name) VALUES ('Accessories');

/*CATEGORIES-PROPERTIES*/
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 1, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 2, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 3, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 4, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 7, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 8, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 10, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 11, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 12, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 13, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 15, true);

INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 1, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 2, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 3, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 4, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 5, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 6, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 7, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 8, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 9, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 10, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 11, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 12, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 13, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 14, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 15, true);

INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 1, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 2, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 3, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 4, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 7, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 8, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 10, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 11, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 12, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 13, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 14, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 15, true);

INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (4, 1, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (4, 3, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (4, 8, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (4, 13, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (4, 15, false);

INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 1, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 7, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 8, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 11, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 12, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 13, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 15, false);

/*PRODUCTS*/
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Google Pixel 2 XL - 64GB - Just Black', '1099.99', 200, 1, 'Google');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Google Pixel - 32GB - Quite Black', '699.99', 80, 1, 'Google');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Apple iPhone X - 256GB - Silver', '1359.00', 100, 1, 'Apple');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Apple iPhone X - 256GB - Space Grey', '1359.00', 100, 1, 'Apple');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Apple iPhone 8 Plus - 64GB - Space Grey', '940.00', 50, 1, 'Apple');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Apple iPhone 8 - 64GB - Space Grey', '829.00', 60, 1, 'Apple');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Apple iPhone 7 - 32GB - Black', '650.00', 60, 1, 'Apple');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Apple iPhone 6S - 32GB - Space Grey', '330.00', 30, 1, 'Apple');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Samsung Galaxy S9+ - 64GB - Midnight Black', '969.90', 100, 1, 'Samsung');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Samsung Galaxy S9 - 64GB - Blue', '869.99', 90, 1, 'Samsung');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('OnePlus 5T - 128GB - Red', '596.22', 100, 1, 'OnePlus');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('OnePlus 5T - 64GB - Midnight Black', '600.00', 150, 1, 'OnePlus');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('OnePlus 5 - 64GB - Slate Gray', '472.00', 20, 1, 'OnePlus');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Huawei P20 - 128GB - Pink', '699.99', 90, 1, 'Huawei');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Huawei P20 Lite - 64GB - Midnight Black', '399.99', 10, 1, 'Huawei');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Huawei P8 Lite 2017 - Black', '199.99', 5, 1, 'Huawei');

INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Apple iPad Pro 12,9" - 256GB - Space Grey', '1249.00', 100, 2, 'Apple');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Samsung Galaxy Tab S2 9.7" - T819 - Black', '529.99', 90, 2, 'Samsung');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Asus ZenPad 10" Z301MF-1H011A - Grey', '219.99', 20, 2, 'Asus');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Huawei MediaPad M3 8.4"', '321.00', 100, 2, 'Huawei');

INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Apple MacBook Pro 13" Retina i5-2,3GHz - 128GB - Space Grey', '1549.00', 50, 3, 'Apple');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Apple MacBook Air 13" i5-1,8GHz - 256GB', '1379.00', 50, 3, 'Apple');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Asus Zenbook UX430UA-57CHDCB1', '949.99', 80, 3, 'Asus');

INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Gaming Asus FHD VP278QG - 27"', '259.99', 80, 4, 'Asus');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('iMac 21,5" Retina 5K - 2,3 GHz - 1 TB', '1349.00', 90, 4, 'Apple');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('iMac 27" Retina 5K - 3,8 GHz - 2 TB', '2699.00', 15, 4, 'Apple');

INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Headphones Beats Studio3 Wireless - Black Shadow', '349.99', 10, 5, 'Beats');
INSERT INTO products (name, price, "quantity_available", "category_id", brand) VALUES ('Power Bank Xiaomi Mi Power 20000mAh - White', '45.99', 50, 5, 'Xiaomi');

/*DELIVERY_TYPES*/
INSERT INTO delivery_types (name, price) VALUES ('Standard Delivery', '0.99');
INSERT INTO delivery_types (name, price) VALUES ('Express Delivery', '9.99');
INSERT INTO delivery_types (name, price) VALUES ('Priority Delivery', '19.99');

/*FAQS*/
INSERT INTO faqs (question, answer) VALUES ('How do I track my order?', 'All orders despatched with DPD are now trackable. Tracking updates will be provided by our delivery partner, with the links to follow your parcel. If your tracking number begins with RML, unfortunately, we are unable to track these parcels at present. Most parcels will reach their destination within 2 weeks, however, some destinations may require additional time allowed for parcels to arrive. As most parcels will reach their destination within 2 weeks, we are unable to query your parcel before this time. If this time has passed and you have still not received your parcel please contact our Customer Care Team.');
INSERT INTO faqs (question, answer) VALUES ('How long will my order take to arrive?', 'Generally our international parcels will arrive within 7 working days. However if  your parcels tracking ID begins with RML, we advise that you allow up to 2 weeks to account for any postal delays within your country. Please note that UK Bank Holidays, Saturday and Sunday are not classed as working days.');
INSERT INTO faqs (question, answer) VALUES ('What do I do if there is a problem with my delivery?', 'Please contact our Customer Care team who are here to help with any problems.');
INSERT INTO faqs (question, answer) VALUES ('What should I do if my parcel is damaged?', 'If you notice that your parcel is damaged during delivery, please take a digital picture that you would send us, before opening your parcel to see your item(s).');
INSERT INTO faqs (question, answer) VALUES ('What is your online security policy?', 'We want to make sure that you are safe and secure when you are shopping with us online. As part of our commitment to this, we perform random checks on orders and this means that you may need to prove your identity. Customers will be contacted by phone or email and will have up to 24 hours to provide us with the required information.');

/*PHOTOS*/
INSERT INTO photos (path, "product_id") VALUES ('storage/1/1.jpg', 1);
INSERT INTO photos (path, "product_id") VALUES ('storage/1/2.jpg', 1);
INSERT INTO photos (path, "product_id") VALUES ('storage/1/3.jpg', 1);
INSERT INTO photos (path, "product_id") VALUES ('storage/2/1.jpg', 2);
INSERT INTO photos (path, "product_id") VALUES ('storage/2/2.jpg', 2);
INSERT INTO photos (path, "product_id") VALUES ('storage/2/3.jpg', 2);
INSERT INTO photos (path, "product_id") VALUES ('storage/3/1.jpg', 3);
INSERT INTO photos (path, "product_id") VALUES ('storage/3/2.jpg', 3);
INSERT INTO photos (path, "product_id") VALUES ('storage/3/3.jpg', 3);
INSERT INTO photos (path, "product_id") VALUES ('storage/4/1.jpg', 4);
INSERT INTO photos (path, "product_id") VALUES ('storage/4/2.jpg', 4);
INSERT INTO photos (path, "product_id") VALUES ('storage/4/3.jpg', 4);
INSERT INTO photos (path, "product_id") VALUES ('storage/5/1.jpg', 5);
INSERT INTO photos (path, "product_id") VALUES ('storage/5/2.jpg', 5);
INSERT INTO photos (path, "product_id") VALUES ('storage/5/3.jpg', 5);
INSERT INTO photos (path, "product_id") VALUES ('storage/6/1.jpg', 6);
INSERT INTO photos (path, "product_id") VALUES ('storage/6/2.jpg', 6);
INSERT INTO photos (path, "product_id") VALUES ('storage/6/3.jpg', 6);
INSERT INTO photos (path, "product_id") VALUES ('storage/7/1.jpg', 7);
INSERT INTO photos (path, "product_id") VALUES ('storage/8/1.jpg', 8);
INSERT INTO photos (path, "product_id") VALUES ('storage/8/2.jpg', 8);
INSERT INTO photos (path, "product_id") VALUES ('storage/8/3.jpg', 8);
INSERT INTO photos (path, "product_id") VALUES ('storage/9/1.jpg', 9);
INSERT INTO photos (path, "product_id") VALUES ('storage/9/2.jpg', 9);
INSERT INTO photos (path, "product_id") VALUES ('storage/9/3.jpg', 9);
INSERT INTO photos (path, "product_id") VALUES ('storage/10/1.jpg', 10);
INSERT INTO photos (path, "product_id") VALUES ('storage/10/2.jpg', 10);
INSERT INTO photos (path, "product_id") VALUES ('storage/10/3.jpg', 10);
INSERT INTO photos (path, "product_id") VALUES ('storage/11/1.jpg', 11);
INSERT INTO photos (path, "product_id") VALUES ('storage/11/2.jpg', 11);
INSERT INTO photos (path, "product_id") VALUES ('storage/11/3.jpg', 11);
INSERT INTO photos (path, "product_id") VALUES ('storage/12/1.jpg', 12);
INSERT INTO photos (path, "product_id") VALUES ('storage/12/2.jpg', 12);
INSERT INTO photos (path, "product_id") VALUES ('storage/12/3.jpg', 12);
INSERT INTO photos (path, "product_id") VALUES ('storage/13/1.jpg', 13);
INSERT INTO photos (path, "product_id") VALUES ('storage/13/2.jpg', 13);
INSERT INTO photos (path, "product_id") VALUES ('storage/13/3.jpg', 13);
INSERT INTO photos (path, "product_id") VALUES ('storage/14/1.jpg', 14);
INSERT INTO photos (path, "product_id") VALUES ('storage/14/2.jpg', 14);
INSERT INTO photos (path, "product_id") VALUES ('storage/14/3.jpg', 14);
INSERT INTO photos (path, "product_id") VALUES ('storage/15/1.jpg', 15);
INSERT INTO photos (path, "product_id") VALUES ('storage/15/2.jpg', 15);
INSERT INTO photos (path, "product_id") VALUES ('storage/15/3.jpg', 15);
INSERT INTO photos (path, "product_id") VALUES ('storage/16/1.jpg', 16);
INSERT INTO photos (path, "product_id") VALUES ('storage/16/2.jpg', 16);
INSERT INTO photos (path, "product_id") VALUES ('storage/16/3.jpg', 16);

INSERT INTO photos (path, "product_id") VALUES ('storage/17/1.jpg', 17);
INSERT INTO photos (path, "product_id") VALUES ('storage/18/1.jpg', 18);
INSERT INTO photos (path, "product_id") VALUES ('storage/19/1.jpg', 19);
INSERT INTO photos (path, "product_id") VALUES ('storage/20/1.jpg', 20);
INSERT INTO photos (path, "product_id") VALUES ('storage/21/1.jpg', 21);
INSERT INTO photos (path, "product_id") VALUES ('storage/22/1.jpg', 22);
INSERT INTO photos (path, "product_id") VALUES ('storage/23/1.jpg', 23);
INSERT INTO photos (path, "product_id") VALUES ('storage/24/1.jpg', 24);
INSERT INTO photos (path, "product_id") VALUES ('storage/25/1.jpg', 25);
INSERT INTO photos (path, "product_id") VALUES ('storage/26/1.jpg', 26);
INSERT INTO photos (path, "product_id") VALUES ('storage/27/1.jpg', 27);
INSERT INTO photos (path, "product_id") VALUES ('storage/28/1.jpg', 28);

/*WISHLIST*/
INSERT INTO wishlists ("user_id", "product_id") VALUES (2, 1);
INSERT INTO wishlists ("user_id", "product_id") VALUES (2, 2);
INSERT INTO wishlists ("user_id", "product_id") VALUES (2, 4);
INSERT INTO wishlists ("user_id", "product_id") VALUES (2, 17);
INSERT INTO wishlists ("user_id", "product_id") VALUES (3, 2);
INSERT INTO wishlists ("user_id", "product_id") VALUES (3, 20);
INSERT INTO wishlists ("user_id", "product_id") VALUES (4, 28);
INSERT INTO wishlists ("user_id", "product_id") VALUES (4, 5);
INSERT INTO wishlists ("user_id", "product_id") VALUES (4, 3);
INSERT INTO wishlists ("user_id", "product_id") VALUES (5, 18);

/*PURCHASES*/
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-08-07', 350.98, 2, 1, 1, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-10-31', 2649.98, 2, 2, 1, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-10-04', 229.98, 2, 1, 2, 'Delivered');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-08-18', 1119.98, 3, 3, 3, 'Delivered');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-04-11', 1249.99, 4, 4, 1, 'Shipped');

/*PRODUCT-PURCHASES*/
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (27, 1, 1, 349.99);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (1, 2, 2, 1099.99);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (21, 2, 1, 1549.00);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (19, 3, 1, 219.99);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (1, 4, 1, 1099.99);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (17, 5, 2, 1249.00);

/*REVIEWS*/
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (2, 1, 5, 'Highly Recommended', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ligula ipsum, volutpat efficitur maximus et, lobortis sed lorem. Suspendisse iaculis erat ac mauris imperdiet, nec auctor felis tincidunt. Suspendisse varius semper odio eu scelerisque. Suspendisse ac est at tortor vulputate rutrum. Cras porta quam eget feugiat pellentesque. Nullam ut vestibulum risus. Praesent dapibus augue ut leo cursus lobortis.', '2017-11-22');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (2, 27, 4, 'Amazing!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vel imperdiet purus. Etiam eu aliquam ipsum, et maximus nisl. Nulla at porttitor ligula. Ut ut fringilla nunc. Donec metus enim.', '2017-12-14');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (3, 1, 3, 'Good Phone', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ligula ipsum, volutpat efficitur maximus et, lobortis sed lorem. Suspendisse iaculis erat ac mauris imperdiet, nec auctor felis tincidunt. Suspendisse varius semper odio eu scelerisque. Suspendisse ac est at tortor vulputate rutrum. Cras porta quam eget feugiat pellentesque. Nullam ut vestibulum risus. Praesent dapibus augue ut leo cursus lobortis.', '2017-10-01');

/*VALUES-LIST*/
/*1*/
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 1);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 2);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 3);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 4);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 5);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 6);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 7);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 8);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 9);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 10);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 11);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 12);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 12);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 12);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 12);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 12);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 12);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 13);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 13);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 13);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 13);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 13);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 13);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 14);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 14);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 14);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 14);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 14);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 14);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 15);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 15);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 15);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 15);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 15);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 15);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 16);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 16);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 16);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 16);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 16);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 16);

/*2*/
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (13, 17);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (14, 17);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (15, 17);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (16, 17);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (17, 17);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (18, 17);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (24, 17);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (26, 17);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (13, 18);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (14, 18);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (15, 18);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (16, 18);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (17, 18);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (18, 18);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (24, 18);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (26, 18);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (13, 19);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (14, 19);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (15, 19);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (16, 19);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (17, 19);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (18, 19);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (24, 19);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (26, 19);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (13, 20);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (14, 20);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (15, 20);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (16, 20);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (17, 20);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (18, 20);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (24, 20);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (26, 20);

/*3*/
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (28, 21);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (29, 21);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (30, 21);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (31, 21);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (38, 21);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (28, 22);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (29, 22);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (30, 22);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (31, 22);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (38, 22);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (28, 23);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (29, 23);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (30, 23);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (31, 23);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (38, 23);

/*4*/
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (40, 24);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (42, 24);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (40, 25);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (42, 25);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (40, 26);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (42, 26);

/*VALUES*/
INSERT INTO values (name, "values_lists_id") VALUES ('Android', 1);
INSERT INTO values (name, "values_lists_id") VALUES ('6 inches', 2);
INSERT INTO values (name, "values_lists_id") VALUES ('2880x1440 px', 2);
INSERT INTO values (name, "values_lists_id") VALUES ('Qualcomm MSM8998 Snapdragon 835', 3);
INSERT INTO values (name, "values_lists_id") VALUES ('64 GB', 4);
INSERT INTO values (name, "values_lists_id") VALUES ('12.2 MP', 5);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 6);

INSERT INTO values (name, "values_lists_id") VALUES ('Android', 7);
INSERT INTO values (name, "values_lists_id") VALUES ('5 inches', 8);
INSERT INTO values (name, "values_lists_id") VALUES ('1920x1080 px', 8);
INSERT INTO values (name, "values_lists_id") VALUES ('Qualcomm MSM8998 Snapdragon 835', 9);
INSERT INTO values (name, "values_lists_id") VALUES ('64 GB', 10);
INSERT INTO values (name, "values_lists_id") VALUES ('12.2 MP', 11);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 12);

INSERT INTO values (name, "values_lists_id") VALUES ('iOS', 13);
INSERT INTO values (name, "values_lists_id") VALUES ('5.8 inches', 14);
INSERT INTO values (name, "values_lists_id") VALUES ('2436x1125 px', 14);
INSERT INTO values (name, "values_lists_id") VALUES ('Retina HD', 14);
INSERT INTO values (name, "values_lists_id") VALUES ('Apple A11', 15);
INSERT INTO values (name, "values_lists_id") VALUES ('256 GB', 16);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP + 12.0 MP', 17);
INSERT INTO values (name, "values_lists_id") VALUES ('Earpods', 18);
INSERT INTO values (name, "values_lists_id") VALUES ('Lightning Cable', 18);
INSERT INTO values (name, "values_lists_id") VALUES ('Adaptor', 18);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 18);

INSERT INTO values (name, "values_lists_id") VALUES ('iOS', 19);
INSERT INTO values (name, "values_lists_id") VALUES ('5.8 inches', 20);
INSERT INTO values (name, "values_lists_id") VALUES ('2436x1125 px', 20);
INSERT INTO values (name, "values_lists_id") VALUES ('Retina HD', 20);
INSERT INTO values (name, "values_lists_id") VALUES ('Apple A11', 21);
INSERT INTO values (name, "values_lists_id") VALUES ('256 GB', 22);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP + 12.0 MP', 23);
INSERT INTO values (name, "values_lists_id") VALUES ('Earpods', 24);
INSERT INTO values (name, "values_lists_id") VALUES ('Lightning Cable', 24);
INSERT INTO values (name, "values_lists_id") VALUES ('Adaptor', 24);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 24);

INSERT INTO values (name, "values_lists_id") VALUES ('iOS', 25);
INSERT INTO values (name, "values_lists_id") VALUES ('5.5 inches', 26);
INSERT INTO values (name, "values_lists_id") VALUES ('1920x1080 px', 26);
INSERT INTO values (name, "values_lists_id") VALUES ('Retina HD', 26);
INSERT INTO values (name, "values_lists_id") VALUES ('Apple A11', 27);
INSERT INTO values (name, "values_lists_id") VALUES ('64 GB', 28);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP + 12.0 MP', 29);
INSERT INTO values (name, "values_lists_id") VALUES ('Earpods', 30);
INSERT INTO values (name, "values_lists_id") VALUES ('Lightning Cable', 30);
INSERT INTO values (name, "values_lists_id") VALUES ('Adaptor', 30);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 30);

INSERT INTO values (name, "values_lists_id") VALUES ('iOS', 31);
INSERT INTO values (name, "values_lists_id") VALUES ('4.7 inches', 32);
INSERT INTO values (name, "values_lists_id") VALUES ('1334x750 px', 32);
INSERT INTO values (name, "values_lists_id") VALUES ('Retina HD', 32);
INSERT INTO values (name, "values_lists_id") VALUES ('Apple A11', 33);
INSERT INTO values (name, "values_lists_id") VALUES ('64 GB', 34);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP', 35);
INSERT INTO values (name, "values_lists_id") VALUES ('Earpods', 36);
INSERT INTO values (name, "values_lists_id") VALUES ('Lightning Cable', 36);
INSERT INTO values (name, "values_lists_id") VALUES ('Adaptor', 36);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 36);

INSERT INTO values (name, "values_lists_id") VALUES ('iOS', 37);
INSERT INTO values (name, "values_lists_id") VALUES ('4.7 inches', 38);
INSERT INTO values (name, "values_lists_id") VALUES ('1334x750 px', 38);
INSERT INTO values (name, "values_lists_id") VALUES ('Retina HD', 38);
INSERT INTO values (name, "values_lists_id") VALUES ('Apple A11', 39);
INSERT INTO values (name, "values_lists_id") VALUES ('32 GB', 40);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP', 41);
INSERT INTO values (name, "values_lists_id") VALUES ('Earpods', 42);
INSERT INTO values (name, "values_lists_id") VALUES ('Lightning Cable', 42);
INSERT INTO values (name, "values_lists_id") VALUES ('Adaptor', 42);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 42);

INSERT INTO values (name, "values_lists_id") VALUES ('iOS', 43);
INSERT INTO values (name, "values_lists_id") VALUES ('4.7 inches', 44);
INSERT INTO values (name, "values_lists_id") VALUES ('1334x750 px', 44);
INSERT INTO values (name, "values_lists_id") VALUES ('Apple A9', 45);
INSERT INTO values (name, "values_lists_id") VALUES ('32 GB', 46);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP', 47);
INSERT INTO values (name, "values_lists_id") VALUES ('Earpods', 48);
INSERT INTO values (name, "values_lists_id") VALUES ('Lightning Cable', 48);
INSERT INTO values (name, "values_lists_id") VALUES ('Adaptor', 48);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 48);

INSERT INTO values (name, "values_lists_id") VALUES ('Android', 49);
INSERT INTO values (name, "values_lists_id") VALUES ('6.2 inches', 50);
INSERT INTO values (name, "values_lists_id") VALUES ('Exynos 9810', 51);
INSERT INTO values (name, "values_lists_id") VALUES ('64 GB', 52);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP + 12.0 MP', 53);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 54);

INSERT INTO values (name, "values_lists_id") VALUES ('Android', 55);
INSERT INTO values (name, "values_lists_id") VALUES ('5.8 inches', 56);
INSERT INTO values (name, "values_lists_id") VALUES ('Exynos 9810', 57);
INSERT INTO values (name, "values_lists_id") VALUES ('64 GB', 58);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP', 59);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 60);

INSERT INTO values (name, "values_lists_id") VALUES ('Android', 55);
INSERT INTO values (name, "values_lists_id") VALUES ('5.8 inches', 56);
INSERT INTO values (name, "values_lists_id") VALUES ('Exynos 9810', 57);
INSERT INTO values (name, "values_lists_id") VALUES ('64 GB', 58);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP', 59);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 60);

INSERT INTO values (name, "values_lists_id") VALUES ('Android', 61);
INSERT INTO values (name, "values_lists_id") VALUES ('6.01 inches', 62);
INSERT INTO values (name, "values_lists_id") VALUES ('Qualcomm Snapdragon 835', 63);
INSERT INTO values (name, "values_lists_id") VALUES ('128 GB', 64);
INSERT INTO values (name, "values_lists_id") VALUES ('16.0 MP + 20.0 MP', 65);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 66);

INSERT INTO values (name, "values_lists_id") VALUES ('Android', 67);
INSERT INTO values (name, "values_lists_id") VALUES ('6.01 inches', 68);
INSERT INTO values (name, "values_lists_id") VALUES ('Qualcomm Snapdragon 835', 69);
INSERT INTO values (name, "values_lists_id") VALUES ('64 GB', 70);
INSERT INTO values (name, "values_lists_id") VALUES ('16.0 MP + 20.0 MP', 71);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 72);

INSERT INTO values (name, "values_lists_id") VALUES ('Android', 73);
INSERT INTO values (name, "values_lists_id") VALUES ('5.5 inches', 74);
INSERT INTO values (name, "values_lists_id") VALUES ('Qualcomm Snapdragon 835', 75);
INSERT INTO values (name, "values_lists_id") VALUES ('64 GB', 76);
INSERT INTO values (name, "values_lists_id") VALUES ('16.0 MP + 20.0 MP', 77);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 78);

INSERT INTO values (name, "values_lists_id") VALUES ('Android', 79);
INSERT INTO values (name, "values_lists_id") VALUES ('5.8 inches', 80);
INSERT INTO values (name, "values_lists_id") VALUES ('HiSilicon Kirin 970', 81);
INSERT INTO values (name, "values_lists_id") VALUES ('128 GB', 82);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP + 20.0 MP', 83);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 84);

INSERT INTO values (name, "values_lists_id") VALUES ('Android', 85);
INSERT INTO values (name, "values_lists_id") VALUES ('5.84 inches', 86);
INSERT INTO values (name, "values_lists_id") VALUES ('Huawei Kirin 659', 87);
INSERT INTO values (name, "values_lists_id") VALUES ('64 GB', 88);
INSERT INTO values (name, "values_lists_id") VALUES ('16.0 MP + 2.0 MP', 89);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 90);

INSERT INTO values (name, "values_lists_id") VALUES ('Android', 91);
INSERT INTO values (name, "values_lists_id") VALUES ('5.2 inches', 92);
INSERT INTO values (name, "values_lists_id") VALUES ('HiSilicon Kirin 655', 93);
INSERT INTO values (name, "values_lists_id") VALUES ('16 GB', 94);
INSERT INTO values (name, "values_lists_id") VALUES ('12.0 MP', 95);
INSERT INTO values (name, "values_lists_id") VALUES ('Charger', 96);

INSERT INTO values (name, "values_lists_id") VALUES ('tellus in sagittis', 97);
INSERT INTO values (name, "values_lists_id") VALUES ('non velit', 98);
INSERT INTO values (name, "values_lists_id") VALUES ('quis', 99);
INSERT INTO values (name, "values_lists_id") VALUES ('consequat dui nec', 100);
INSERT INTO values (name, "values_lists_id") VALUES ('quam', 101);
INSERT INTO values (name, "values_lists_id") VALUES ('ut ultrices vel', 102);
INSERT INTO values (name, "values_lists_id") VALUES ('accumsan tellus', 103);
INSERT INTO values (name, "values_lists_id") VALUES ('pede lobortis', 104);

INSERT INTO values (name, "values_lists_id") VALUES ('platea dictumst morbi', 105);
INSERT INTO values (name, "values_lists_id") VALUES ('adipiscing', 106);
INSERT INTO values (name, "values_lists_id") VALUES ('parturient', 107);
INSERT INTO values (name, "values_lists_id") VALUES ('vitae quam', 108);
INSERT INTO values (name, "values_lists_id") VALUES ('sem fusce consequat', 109);
INSERT INTO values (name, "values_lists_id") VALUES ('quam', 110);
INSERT INTO values (name, "values_lists_id") VALUES ('elit proin', 111);
INSERT INTO values (name, "values_lists_id") VALUES ('sagittis', 112);

INSERT INTO values (name, "values_lists_id") VALUES ('rhoncus aliquet', 113);
INSERT INTO values (name, "values_lists_id") VALUES ('vitae nisl', 114);
INSERT INTO values (name, "values_lists_id") VALUES ('faucibus cursus', 115);
INSERT INTO values (name, "values_lists_id") VALUES ('ultrices', 116);
INSERT INTO values (name, "values_lists_id") VALUES ('vitae nisi', 117);
INSERT INTO values (name, "values_lists_id") VALUES ('blandit', 118);
INSERT INTO values (name, "values_lists_id") VALUES ('cras', 119);
INSERT INTO values (name, "values_lists_id") VALUES ('iaculis diam erat', 120);

INSERT INTO values (name, "values_lists_id") VALUES ('praesent', 121);
INSERT INTO values (name, "values_lists_id") VALUES ('sed tristique', 122);
INSERT INTO values (name, "values_lists_id") VALUES ('tellus', 123);
INSERT INTO values (name, "values_lists_id") VALUES ('orci pede', 124);
INSERT INTO values (name, "values_lists_id") VALUES ('diam nam', 125);
INSERT INTO values (name, "values_lists_id") VALUES ('enim', 126);
INSERT INTO values (name, "values_lists_id") VALUES ('neque duis', 127);
INSERT INTO values (name, "values_lists_id") VALUES ('hac habitasse platea', 128);

INSERT INTO values (name, "values_lists_id") VALUES ('mi nulla', 129);
INSERT INTO values (name, "values_lists_id") VALUES ('congue eget semper', 130);
INSERT INTO values (name, "values_lists_id") VALUES ('nisl duis ac', 131);
INSERT INTO values (name, "values_lists_id") VALUES ('ut', 132);
INSERT INTO values (name, "values_lists_id") VALUES ('non quam', 133);

INSERT INTO values (name, "values_lists_id") VALUES ('blandit lacinia', 134);
INSERT INTO values (name, "values_lists_id") VALUES ('habitasse platea', 135);
INSERT INTO values (name, "values_lists_id") VALUES ('consequat in consequat', 136);
INSERT INTO values (name, "values_lists_id") VALUES ('nisl nunc', 137);
INSERT INTO values (name, "values_lists_id") VALUES ('sollicitudin vitae', 138);

INSERT INTO values (name, "values_lists_id") VALUES ('curabitur convallis duis', 139);
INSERT INTO values (name, "values_lists_id") VALUES ('at', 140);
INSERT INTO values (name, "values_lists_id") VALUES ('nisl', 141);
INSERT INTO values (name, "values_lists_id") VALUES ('tristique tortor', 142);
INSERT INTO values (name, "values_lists_id") VALUES ('ligula vehicula consequat', 143);

INSERT INTO values (name, "values_lists_id") VALUES ('parturient montes nascetur', 144);
INSERT INTO values (name, "values_lists_id") VALUES ('integer', 145);

INSERT INTO values (name, "values_lists_id") VALUES ('massa id', 146);
INSERT INTO values (name, "values_lists_id") VALUES ('in faucibus orci', 147);

INSERT INTO values (name, "values_lists_id") VALUES ('quam pede lobortis', 148);
INSERT INTO values (name, "values_lists_id") VALUES ('justo in blandit', 149);