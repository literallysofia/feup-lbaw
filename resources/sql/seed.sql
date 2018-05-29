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
    remember_token VARCHAR
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
    CONSTRAINT price CHECK ((price > (0)::double precision)),
    CONSTRAINT quantity_available CHECK ((quantity_available >= 0)),
    CONSTRAINT score CHECK (score >= 0 AND score <= 5)
);


DROP TABLE IF EXISTS archived_products CASCADE;
CREATE TABLE archived_products (
    "product_id" integer PRIMARY KEY REFERENCES products(id) ON DELETE CASCADE
);

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

/** POPULATE **/

/*COUNTRIES*/
INSERT INTO countries (name) VALUES ('Venezuela');
INSERT INTO countries (name) VALUES ('China');
INSERT INTO countries (name) VALUES ('Mongolia');
INSERT INTO countries (name) VALUES ('Colombia');
INSERT INTO countries (name) VALUES ('Vietnam');
INSERT INTO countries (name) VALUES ('Russia');
INSERT INTO countries (name) VALUES ('Indonesia');
INSERT INTO countries (name) VALUES ('Brazil');
INSERT INTO countries (name) VALUES ('United States');
INSERT INTO countries (name) VALUES ('France');
INSERT INTO countries (name) VALUES ('Tajikistan');
INSERT INTO countries (name) VALUES ('Portugal');
INSERT INTO countries (name) VALUES ('Peru');
INSERT INTO countries (name) VALUES ('Nigeria');

/*CITIES*/
INSERT INTO cities (name, "country_id") VALUES ('Rubio', 1);
INSERT INTO cities (name, "country_id") VALUES ('Jiayuguan', 2);
INSERT INTO cities (name, "country_id") VALUES ('Huanggang', 2);
INSERT INTO cities (name, "country_id") VALUES ('Ereencav', 3);
INSERT INTO cities (name, "country_id") VALUES ('El Cocuy', 4);
INSERT INTO cities (name, "country_id") VALUES ('Xinzheng', 2);
INSERT INTO cities (name, "country_id") VALUES ('Gawul', 7);
INSERT INTO cities (name, "country_id") VALUES ('Trà My', 5);
INSERT INTO cities (name, "country_id") VALUES ('Mikun’', 6);
INSERT INTO cities (name, "country_id") VALUES ('Ambarita', 7);
INSERT INTO cities (name, "country_id") VALUES ('Taquarituba', 8);
INSERT INTO cities (name, "country_id") VALUES ('Arlington', 9);
INSERT INTO cities (name, "country_id") VALUES ('Caen', 10);
INSERT INTO cities (name, "country_id") VALUES ('Itacorubi', 8);
INSERT INTO cities (name, "country_id") VALUES ('Darband', 11);
INSERT INTO cities (name, "country_id") VALUES ('Seixal', 12);
INSERT INTO cities (name, "country_id") VALUES ('Zlatoust', 6);
INSERT INTO cities (name, "country_id") VALUES ('Mucllo', 13);
INSERT INTO cities (name, "country_id") VALUES ('Dashi', 2);
INSERT INTO cities (name, "country_id") VALUES ('Kuta', 14);

/*USERS*/
INSERT INTO users (name, username, email, password) VALUES ('Dominik Courtliff', 'dcourtliff0', 'dcourtliff0@washington.edu', 'AP8LWaw');
INSERT INTO users (name, username, email, password) VALUES ('Chester Lownes', 'clownes1', 'clownes1@washingtonpost.com', 'LbkRHs');
INSERT INTO users (name, username, email, password) VALUES ('Kathe Omar', 'komar2', 'komar2@e-recht24.de', '2T7AIM');
INSERT INTO users (name, username, email, password) VALUES ('Ethelda Houseago', 'ehouseago3', 'ehouseago3@acquirethisname.com', 'afSIgLsK6M');
INSERT INTO users (name, username, email, password) VALUES ('Amalia Glayzer', 'aglayzer4', 'aglayzer4@bandcamp.com', 'X3hO0S54dSG');
INSERT INTO users (name, username, email, password) VALUES ('Bidget Gehrels', 'bgehrels5', 'bgehrels5@redcross.org', 'YstABQ9w');
INSERT INTO users (name, username, email, password) VALUES ('Davide Wardale', 'dwardale6', 'dwardale6@e-recht24.de', 'BohbUPUS9LkP');
INSERT INTO users (name, username, email, password) VALUES ('Blondie MacPhee', 'bmacphee7', 'bmacphee7@dell.com', 'yk1syP');
INSERT INTO users (name, username, email, password) VALUES ('Rubi Duncklee', 'rduncklee8', 'rduncklee8@npr.org', 'kwDVrx631e');
INSERT INTO users (name, username, email, password) VALUES ('Zorina Hiseman', 'zhiseman9', 'zhiseman9@usa.gov', 'AKniryg');
INSERT INTO users (name, username, email, password) VALUES ('Zola Bosquet', 'zbosqueta', 'zbosqueta@un.org', '5h0MqBhj91HU');
INSERT INTO users (name, username, email, password) VALUES ('Colman Dobey', 'cdobeyb', 'cdobeyb@sciencedaily.com', 'JQGVzuqymhAc');
INSERT INTO users (name, username, email, password) VALUES ('Chrissie Dudbridge', 'cdudbridgec', 'cdudbridgec@dot.gov', 'QWaoJCPAy');
INSERT INTO users (name, username, email, password) VALUES ('Clare Pash', 'cpashd', 'cpashd@51.la', '1fjSLVI08l9k');
INSERT INTO users (name, username, email, password) VALUES ('Daisy Matusov', 'dmatusove', 'dmatusove@ucsd.edu', 'FDE5AhcJ');
INSERT INTO users (name, username, email, password) VALUES ('Gualterio Flanders', 'gflandersf', 'gflandersf@prweb.com', 'QWbc7824');
INSERT INTO users (name, username, email, password) VALUES ('Ulises Reubel', 'ureubelg', 'ureubelg@etsy.com', 'wu7vgJ');
INSERT INTO users (name, username, email, password) VALUES ('Edy MacMenamin', 'emacmenaminh', 'emacmenaminh@ed.gov', 'pvwtW3DT');
INSERT INTO users (name, username, email, password) VALUES ('Zachariah Chadburn', 'zchadburni', 'zchadburni@typepad.com', 'Wcjj8vZSA');
INSERT INTO users (name, username, email, password) VALUES ('Jorry MacAndie', 'jmacandiej', 'jmacandiej@wordpress.com', 'Q9oAsh5');
INSERT INTO users (name, username, email, password) VALUES ('Test', 'test', 'sweventechshop@gmail.com', '$2y$10$v.JHOjwkOhrK1ZsTY4Mgf.9zY.7MziX8KhtgofT6kaQpNvx1j07NO'); /*password: testtest*/
INSERT INTO users (name, username, email, password) VALUES ('Sweven Tech Shop', 'swevenAdmin', 'sweven@sweven.com', '$2y$10$3Wc9dkxovmxwQZObfnJfEuOiTDCPPNPL6HdYKpQ/I7qbQrP9U58AK'); /*password: Sweven61*/


/*ADDRESSES*/
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Dennis', '18740-000', 1, 21);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('country house', 'Dahle', '18740-000', 2, 21);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('company', 'Luster', '22205', 3, 21);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Monica', '88000-000', 4, 21);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Manitowish', '151287', 5, 21);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Dovetail', '22205', 6, 19);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Garrison', '88000-000', 7, 2);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Loeprich', '88000-000', 8, 13);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Prairieview', '169060', 9, 8);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Fairfield', '88000-000', 10, 16);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', '1st', '18740-000', 11, 2);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Waxwing', '22205', 12, 15);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Memorial', '14908 CEDEX 9', 13, 16);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Nova', '88000-000', 14, 12);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Ramsey', '18740-000', 15, 4);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Monument', '2530-254', 16, 9);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Valley Edge', '456209', 17, 9);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Thierer', '88000-000', 18, 14);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Meadow Vale', '456209', 19, 13);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Veith', '18740-000', 20, 10);

/*ADMINS*/
INSERT INTO admins ("user_id") VALUES (1);
INSERT INTO admins ("user_id") VALUES (2);
INSERT INTO admins ("user_id") VALUES (3);
INSERT INTO admins ("user_id") VALUES (4);
INSERT INTO admins ("user_id") VALUES (22);


/*CATEGORIES*/
INSERT INTO categories (name, "is_navbar_category") VALUES ('Smartphones', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Tablets', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Computers', false);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Monitors', true);
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

/*ARCHIVED-PRODUCTS*/
INSERT INTO archived_products ("product_id") VALUES (10);
INSERT INTO archived_products ("product_id") VALUES (12);

/*DELIVERY_TYPES*/
INSERT INTO delivery_types (name, price) VALUES ('Standard Delivery', '0.99');
INSERT INTO delivery_types (name, price) VALUES ('Express Delivery', '9.99');
INSERT INTO delivery_types (name, price) VALUES ('Priority Delivery', '19.99');

/*FAQS*/
INSERT INTO faqs (question, answer) VALUES ('Sed sagittis?', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.');
INSERT INTO faqs (question, answer) VALUES ('Nullam varius?', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO faqs (question, answer) VALUES ('Ut tellus. Nulla ut erat id mauris vulputate elementum?', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.');
INSERT INTO faqs (question, answer) VALUES ('Suspendisse accumsan tortor quis turpi?', 'Aenean fermentum.');
INSERT INTO faqs (question, answer) VALUES ('Curabitur at ipsum ac tellus semper interdum?', 'Morbi porttitor lorem id ligula.');
INSERT INTO faqs (question, answer) VALUES ('Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum?', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO faqs (question, answer) VALUES ('Nullam sit amet turpis elementum ligula vehicula consequat?', 'Suspendisse potenti. In eleifend quam a odio.');

/*PHOTOS*/
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 1);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 2);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 3);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 4);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/dddddd/000000', 5);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 6);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 7);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 8);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 9);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/dddddd/000000', 10);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 11);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 12);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 13);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 14);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/dddddd/000000', 15);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 16);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 17);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 18);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 19);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 20);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/dddddd/000000', 21);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 22);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 23);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 24);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 25);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/dddddd/000000', 26);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 27);
INSERT INTO photos (path, "product_id") VALUES ('http://dummyimage.com/1000x810.jpg/dddddd/000000', 28);

/*WISHLIST*/
INSERT INTO wishlists ("user_id", "product_id") VALUES (2, 2);
INSERT INTO wishlists ("user_id", "product_id") VALUES (5, 15);
INSERT INTO wishlists ("user_id", "product_id") VALUES (6, 4);
INSERT INTO wishlists ("user_id", "product_id") VALUES (7, 5);
INSERT INTO wishlists ("user_id", "product_id") VALUES (8, 7);
INSERT INTO wishlists ("user_id", "product_id") VALUES (10, 9);
INSERT INTO wishlists ("user_id", "product_id") VALUES (10, 10);
INSERT INTO wishlists ("user_id", "product_id") VALUES (10, 13);
INSERT INTO wishlists ("user_id", "product_id") VALUES (21, 8);
INSERT INTO wishlists ("user_id", "product_id") VALUES (21, 3);

/*PRODUCT-CARTS*/
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (6, 16, 2);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (6, 2, 2);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (2, 2, 1);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (19, 7, 1);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (2, 9, 2);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (3, 13, 3);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (11, 12, 2);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (9, 1, 1);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (10, 5, 1);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (17, 6, 3);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (15, 7, 1);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (12, 12, 1);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (13, 4, 2);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (21, 4, 90);

/*PURCHASES*/
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-08-07', 2542.42, 21, 4, 2, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-10-31', 1072.94, 21, 1, 2, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-10-04', 2878.82, 21, 1, 3, 'Delivered');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-08-18', 1119.94, 21, 16, 3, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-04-11', 1115.11, 8, 9, 2, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-12-12', 4507.83, 8, 9, 3, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2018-01-20', 899.21, 14, 18, 2, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2018-02-28', 3471.12, 16, 13, 1, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-02-22', 625.19, 19, 6, 1, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-04-02', 4929.18, 13, 19, 2, 'Delivered');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-10-10', 3464.1, 3, 2, 3, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-07-31', 4273.67, 7, 1, 1, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-11-18', 538.7, 9, 17, 2, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-06-15', 3259.77, 14, 18, 3, 'Delivered');
INSERT INTO purchases (date, total, "user_id", "address_id", "delivery_type_id", status) VALUES ('2017-02-15', 1201.51, 10, 20, 2, 'Shipped');

/*PRODUCT-PURCHASES*/
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (1, 1, 1, 1106.96);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (2, 1, 2, 717.73);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (3, 2, 1, 1072.94);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (4, 3, 1, 1107.96);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (5, 4, 2, 556.97);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (6, 15, 1, 910.6);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (7, 9, 1, 1015.66);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (8, 7, 2, 1064.08);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (9, 14, 2, 840.37);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (10, 3, 2, 885.43);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (11, 9, 1, 462.09);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (12, 5, 2, 666.96);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (13, 5, 2, 689.05);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (14, 5, 2, 1180.96);
INSERT INTO product_purchase ("product_id", "purchase_id", quantity, price) VALUES (15, 15, 1, 596.35);

/*REVIEWS*/
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (9, 2, 1, 'Some title', 'Some content.', '2017-06-22');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (21, 1, 1, 'Some title', 'Some content.', '2017-06-22');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (9, 1, 1, 'Some title', 'Yo', '2017-08-22');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (10, 6, 5, 'Some title', 'Some content.', '2017-08-12');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (16, 3, 4, 'Some title', 'Some content.', '2018-02-04');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (19, 11, 2, 'Some title', 'Some content.', '2017-03-13');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (10, 15, 3, 'Some title', 'Some content.', '2017-12-28');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (8, 12, 4, 'Some title', 'Some content.', '2018-03-22');


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