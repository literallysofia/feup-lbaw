CREATE DOMAIN "Today" AS date NOT NULL DEFAULT ('now'::text)::date;

CREATE TABLE addresses (
    id integer PRIMARY KEY,
    name text NOT NULL,
    street text NOT NULL,
    "postal_code" text NOT NULL,
    "city_id" integer NOT NULL REFERENCES cities(id) ON DELETE CASCADE,
    "user_id" integer NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE admins (
    "user_id" integer PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE archived_products (
    "product_id" integer PRIMARY KEY REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE categories (
    id integer PRIMARY KEY,
    name text NOT NULL UNIQUE,
    "is_navbar_category" boolean DEFAULT false NOT NULL
);

CREATE TABLE category_properties (
    id integer PRIMARY KEY,
    "category_id" integer NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    "property_id" integer NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
    "is_required_property" boolean DEFAULT false NOT NULL
);

CREATE TABLE cities (
    id integer PRIMARY KEY,
    name text NOT NULL UNIQUE,
    "country_id" integer NOT NULL REFERENCES countries(id) ON DELETE CASCADE
);

CREATE TABLE countries (
    id integer PRIMARY KEY,
    name text NOT NULL UNIQUE
);

CREATE TABLE delivery_types (
    id integer PRIMARY KEY,
    name text NOT NULL UNIQUE,
    cost double precision NOT NULL UNIQUE
);

CREATE TABLE faqs (
    id integer PRIMARY KEY,
    question text NOT NULL UNIQUE,
    answer text NOT NULL
);

CREATE TABLE photos (
    id integer PRIMARY KEY,
    path text NOT NULL,
    "product_id" integer NOT NULL REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE products (
    id integer PRIMARY KEY,
    name text NOT NULL,
    price double precision NOT NULL,
    quantity_available integer NOT NULL,
    score integer NOT NULL,
    "category_id" integer NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    CONSTRAINT price CHECK ((price > (0)::double precision)),
    CONSTRAINT quantity_available CHECK ((quantity_available >= 0)),
    CONSTRAINT score CHECK (score >= 0 AND score <= 5)
);

CREATE TABLE product_carts (
    id integer PRIMARY KEY,
    "user_id" integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    quantity integer NOT NULL,
    CONSTRAINT quantity CHECK ((quantity > 0))
);

CREATE TABLE product_purchases (
    "product_id" integer PRIMARY KEY REFERENCES products(id) ON DELETE CASCADE,
    "purchase_id" integer NOT NULL REFERENCES purchases(id) ON DELETE CASCADE,
    quantity integer NOT NULL,
    price double precision NOT NULL,
    CONSTRAINT price CHECK ((price > (0)::double precision)),
    CONSTRAINT quantity CHECK ((quantity > 0))
);

CREATE TABLE properties (
    id integer PRIMARY KEY,
    name text NOT NULL UNIQUE
);

CREATE TABLE purchases (
    id integer PRIMARY KEY,
    "date" TIMESTAMP WITH TIME zone DEFAULT now() NOT NULL,
    total double precision NOT NULL,
    "user_id" integer NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    "address_id" integer NOT NULL REFERENCES addresses(id) ON DELETE CASCADE,
    status text DEFAULT 'Processing'::text NOT NULL,
    CONSTRAINT status CHECK ((TYPE = ANY (ARRAY['Processing'::text, 'Shipped'::text, 'Delivered'::text]))),
    CONSTRAINT total CHECK ((total > (0)::double precision))
);

CREATE TABLE reviews (
    "user_id" integer PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    "product_id" integer PRIMARY KEY REFERENCES products(id) ON DELETE CASCADE,
    score integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    CONSTRAINT score CHECK (((score >= 0) AND (score <= 5)))
);

CREATE TABLE users (
    id integer PRIMARY KEY,
    name text NOT NULL,
    username text NOT NULL UNIQUE,
    email text NOT NULL UNIQUE,
    password text NOT NULL
);

CREATE TABLE values (
    id integer PRIMARY KEY,
    name text,
    "values_list_id" integer NOT NULL REFERENCES values_lists(id) ON DELETE CASCADE
);

CREATE TABLE values_lists (
    id integer PRIMARY KEY,
    "category_id" integer NOT NULL REFERENCES category_properties(id) ON DELETE CASCADE,
    "product_id" integer NOT NULL REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE wishlists (
    "user_id" integer PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    "product_id" integer PRIMARY KEY REFERENCES products(id) ON DELETE CASCADE
);