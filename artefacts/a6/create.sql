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
