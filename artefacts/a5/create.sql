--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.wishlist DROP CONSTRAINT "wishlist_idUser_fkey";
ALTER TABLE ONLY public.wishlist DROP CONSTRAINT "wishlist_idProduct_fkey";
ALTER TABLE ONLY public.values_list DROP CONSTRAINT "values_list_idProduct_fkey";
ALTER TABLE ONLY public.values_list DROP CONSTRAINT "values_list_idCategoryProperty_fkey";
ALTER TABLE ONLY public.value DROP CONSTRAINT "value_idValueList_fkey";
ALTER TABLE ONLY public.review DROP CONSTRAINT "review_idUser_fkey";
ALTER TABLE ONLY public.review DROP CONSTRAINT "review_idProduct_fkey";
ALTER TABLE ONLY public.purchase DROP CONSTRAINT "purchase_idUser_fkey";
ALTER TABLE ONLY public.purchase DROP CONSTRAINT "purchase_idAddress_fkey";
ALTER TABLE ONLY public.product_purchase DROP CONSTRAINT "product_purchase_idPurchase_fkey";
ALTER TABLE ONLY public.product_purchase DROP CONSTRAINT "product_purchase_idProduct_fkey";
ALTER TABLE ONLY public.product DROP CONSTRAINT "product_idCategory_fkey";
ALTER TABLE ONLY public.product_cart DROP CONSTRAINT "product_cart_idUser_fkey";
ALTER TABLE ONLY public.photo DROP CONSTRAINT "photo_idProduct_fkey";
ALTER TABLE ONLY public.city DROP CONSTRAINT "city_idCountry_fkey";
ALTER TABLE ONLY public.category_property DROP CONSTRAINT "category_property_idProperty_fkey";
ALTER TABLE ONLY public.category_property DROP CONSTRAINT "category_property_idCategory_fkey";
ALTER TABLE ONLY public.archived_product DROP CONSTRAINT "archived_product_idProduct_fkey";
ALTER TABLE ONLY public.admin DROP CONSTRAINT "admin_idUser_fkey";
ALTER TABLE ONLY public.address DROP CONSTRAINT "address_idUser_fkey";
ALTER TABLE ONLY public.address DROP CONSTRAINT "address_idCity_fkey";
ALTER TABLE ONLY public.wishlist DROP CONSTRAINT wishlist_pkey;
ALTER TABLE ONLY public.values_list DROP CONSTRAINT values_list_pkey;
ALTER TABLE ONLY public.value DROP CONSTRAINT value_pkey;
ALTER TABLE ONLY public."user" DROP CONSTRAINT user_username_key;
ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
ALTER TABLE ONLY public."user" DROP CONSTRAINT user_email_key;
ALTER TABLE ONLY public.review DROP CONSTRAINT review_pkey;
ALTER TABLE ONLY public.purchase DROP CONSTRAINT purchase_pkey;
ALTER TABLE ONLY public.property DROP CONSTRAINT property_pkey;
ALTER TABLE ONLY public.property DROP CONSTRAINT property_name_key;
ALTER TABLE ONLY public.product_purchase DROP CONSTRAINT product_purchase_pkey;
ALTER TABLE ONLY public.product DROP CONSTRAINT product_id_key;
ALTER TABLE ONLY public.product_cart DROP CONSTRAINT product_cart_pkey;
ALTER TABLE ONLY public.photo DROP CONSTRAINT photo_pkey;
ALTER TABLE ONLY public.faq DROP CONSTRAINT faq_question_key;
ALTER TABLE ONLY public.faq DROP CONSTRAINT faq_pkey;
ALTER TABLE ONLY public.delivery_type DROP CONSTRAINT delivery_type_pkey;
ALTER TABLE ONLY public.delivery_type DROP CONSTRAINT delivery_type_name_key;
ALTER TABLE ONLY public.delivery_type DROP CONSTRAINT delivery_type_cost_key;
ALTER TABLE ONLY public.country DROP CONSTRAINT country_pkey;
ALTER TABLE ONLY public.country DROP CONSTRAINT country_name_key;
ALTER TABLE ONLY public.city DROP CONSTRAINT city_pkey;
ALTER TABLE ONLY public.city DROP CONSTRAINT city_name_key;
ALTER TABLE ONLY public.category DROP CONSTRAINT categoy_pkey;
ALTER TABLE ONLY public.category DROP CONSTRAINT categoy_name_key;
ALTER TABLE ONLY public.category_property DROP CONSTRAINT category_property_pkey;
ALTER TABLE ONLY public.archived_product DROP CONSTRAINT archived_product_pkey;
ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
ALTER TABLE ONLY public.address DROP CONSTRAINT address_pkey;
ALTER TABLE public."user" ALTER COLUMN password DROP DEFAULT;
ALTER TABLE public."user" ALTER COLUMN email DROP DEFAULT;
ALTER TABLE public."user" ALTER COLUMN username DROP DEFAULT;
ALTER TABLE public."user" ALTER COLUMN name DROP DEFAULT;
ALTER TABLE public.faq ALTER COLUMN answer DROP DEFAULT;
DROP TABLE public.wishlist;
DROP TABLE public.values_list;
DROP TABLE public.value;
DROP SEQUENCE public.user_username_seq;
DROP SEQUENCE public.user_password_seq;
DROP SEQUENCE public.user_name_seq;
DROP SEQUENCE public.user_email_seq;
DROP TABLE public."user";
DROP TABLE public.review;
DROP TABLE public.purchase;
DROP TABLE public.property;
DROP TABLE public.product_purchase;
DROP TABLE public.product_cart;
DROP TABLE public.product;
DROP TABLE public.photo;
DROP SEQUENCE public.faq_answer_seq;
DROP TABLE public.faq;
DROP TABLE public.delivery_type;
DROP TABLE public.country;
DROP TABLE public.city;
DROP TABLE public.category_property;
DROP TABLE public.category;
DROP TABLE public.archived_product;
DROP TABLE public.admin;
DROP TABLE public.address;
DROP DOMAIN public."Today";
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: lbaw1761
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO lbaw1761;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: lbaw1761
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET search_path = public, pg_catalog;

--
-- Name: Today; Type: DOMAIN; Schema: public; Owner: lbaw1761
--

CREATE DOMAIN "Today" AS date NOT NULL DEFAULT ('now'::text)::date;


ALTER DOMAIN "Today" OWNER TO lbaw1761;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE address (
    id integer NOT NULL,
    name text NOT NULL,
    street text NOT NULL,
    "postalCode" text NOT NULL,
    "idCity" integer NOT NULL,
    "idUser" integer NOT NULL
);


ALTER TABLE address OWNER TO lbaw1761;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE admin (
    "idUser" integer NOT NULL
);


ALTER TABLE admin OWNER TO lbaw1761;

--
-- Name: archived_product; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE archived_product (
    "idProduct" integer NOT NULL
);


ALTER TABLE archived_product OWNER TO lbaw1761;

--
-- Name: category; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE category (
    id integer NOT NULL,
    name text NOT NULL,
    "isNavBar" boolean DEFAULT false NOT NULL
);


ALTER TABLE category OWNER TO lbaw1761;

--
-- Name: category_property; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE category_property (
    id integer NOT NULL,
    "idCategory" integer NOT NULL,
    "idProperty" integer NOT NULL,
    "isRequiredProperty" boolean DEFAULT false NOT NULL
);


ALTER TABLE category_property OWNER TO lbaw1761;

--
-- Name: city; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE city (
    id integer NOT NULL,
    name integer NOT NULL,
    "idCountry" integer NOT NULL
);


ALTER TABLE city OWNER TO lbaw1761;

--
-- Name: country; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE country (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE country OWNER TO lbaw1761;

--
-- Name: delivery_type; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE delivery_type (
    id integer NOT NULL,
    name text NOT NULL,
    cost double precision NOT NULL
);


ALTER TABLE delivery_type OWNER TO lbaw1761;

--
-- Name: faq; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE faq (
    id integer NOT NULL,
    question text NOT NULL,
    answer integer NOT NULL
);


ALTER TABLE faq OWNER TO lbaw1761;

--
-- Name: faq_answer_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1761
--

CREATE SEQUENCE faq_answer_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE faq_answer_seq OWNER TO lbaw1761;

--
-- Name: faq_answer_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1761
--

ALTER SEQUENCE faq_answer_seq OWNED BY faq.answer;


--
-- Name: photo; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE photo (
    id integer NOT NULL,
    path path NOT NULL,
    "idProduct" integer NOT NULL
);


ALTER TABLE photo OWNER TO lbaw1761;

--
-- Name: product; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE product (
    id integer,
    name text NOT NULL,
    price double precision NOT NULL,
    quantityavailable integer NOT NULL,
    score integer NOT NULL,
    "idCategory" integer NOT NULL,
    CONSTRAINT price CHECK ((price > (0)::double precision)),
    CONSTRAINT quantityavailable CHECK ((quantityavailable >= 0))
);


ALTER TABLE product OWNER TO lbaw1761;

--
-- Name: product_cart; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE product_cart (
    id integer NOT NULL,
    "idUser" integer NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT quantity CHECK ((quantity > 0))
);


ALTER TABLE product_cart OWNER TO lbaw1761;

--
-- Name: product_purchase; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE product_purchase (
    "idProduct" integer NOT NULL,
    "idPurchase" integer NOT NULL,
    quantity integer NOT NULL,
    price double precision NOT NULL,
    CONSTRAINT price CHECK ((price > (0)::double precision)),
    CONSTRAINT quantity CHECK ((quantity > 0))
);


ALTER TABLE product_purchase OWNER TO lbaw1761;

--
-- Name: property; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE property (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE property OWNER TO lbaw1761;

--
-- Name: purchase; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE purchase (
    id integer NOT NULL,
    date date DEFAULT ('now'::text)::date NOT NULL,
    total double precision NOT NULL,
    "idUser" integer NOT NULL,
    "idAddress" integer NOT NULL,
    status text DEFAULT 'processing'::text NOT NULL,
    CONSTRAINT total CHECK ((total > (0)::double precision))
);


ALTER TABLE purchase OWNER TO lbaw1761;

--
-- Name: review; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE review (
    "idUser" integer NOT NULL,
    "idProduct" integer NOT NULL,
    score smallint NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    CONSTRAINT score CHECK (((score >= 0) AND (score <= 5)))
);


ALTER TABLE review OWNER TO lbaw1761;

--
-- Name: user; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE "user" (
    id integer NOT NULL,
    name integer NOT NULL,
    username integer NOT NULL,
    email integer NOT NULL,
    password integer NOT NULL
);


ALTER TABLE "user" OWNER TO lbaw1761;

--
-- Name: user_email_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1761
--

CREATE SEQUENCE user_email_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_email_seq OWNER TO lbaw1761;

--
-- Name: user_email_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1761
--

ALTER SEQUENCE user_email_seq OWNED BY "user".email;


--
-- Name: user_name_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1761
--

CREATE SEQUENCE user_name_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_name_seq OWNER TO lbaw1761;

--
-- Name: user_name_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1761
--

ALTER SEQUENCE user_name_seq OWNED BY "user".name;


--
-- Name: user_password_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1761
--

CREATE SEQUENCE user_password_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_password_seq OWNER TO lbaw1761;

--
-- Name: user_password_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1761
--

ALTER SEQUENCE user_password_seq OWNED BY "user".password;


--
-- Name: user_username_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1761
--

CREATE SEQUENCE user_username_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_username_seq OWNER TO lbaw1761;

--
-- Name: user_username_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1761
--

ALTER SEQUENCE user_username_seq OWNED BY "user".username;


--
-- Name: value; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE value (
    id integer NOT NULL,
    name text,
    "idValueList" integer NOT NULL
);


ALTER TABLE value OWNER TO lbaw1761;

--
-- Name: values_list; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE values_list (
    id integer NOT NULL,
    "idCategoryProperty" integer NOT NULL,
    "idProduct" integer NOT NULL
);


ALTER TABLE values_list OWNER TO lbaw1761;

--
-- Name: wishlist; Type: TABLE; Schema: public; Owner: lbaw1761; Tablespace: 
--

CREATE TABLE wishlist (
    "idUser" integer NOT NULL,
    "idProduct" integer NOT NULL
);


ALTER TABLE wishlist OWNER TO lbaw1761;

--
-- Name: answer; Type: DEFAULT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY faq ALTER COLUMN answer SET DEFAULT nextval('faq_answer_seq'::regclass);


--
-- Name: name; Type: DEFAULT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY "user" ALTER COLUMN name SET DEFAULT nextval('user_name_seq'::regclass);


--
-- Name: username; Type: DEFAULT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY "user" ALTER COLUMN username SET DEFAULT nextval('user_username_seq'::regclass);


--
-- Name: email; Type: DEFAULT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY "user" ALTER COLUMN email SET DEFAULT nextval('user_email_seq'::regclass);


--
-- Name: password; Type: DEFAULT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY "user" ALTER COLUMN password SET DEFAULT nextval('user_password_seq'::regclass);


--
-- Name: address_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: admin_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY ("idUser");


--
-- Name: archived_product_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY archived_product
    ADD CONSTRAINT archived_product_pkey PRIMARY KEY ("idProduct");


--
-- Name: category_property_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY category_property
    ADD CONSTRAINT category_property_pkey PRIMARY KEY (id);


--
-- Name: categoy_name_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT categoy_name_key UNIQUE (name);


--
-- Name: categoy_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY category
    ADD CONSTRAINT categoy_pkey PRIMARY KEY (id);


--
-- Name: city_name_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY city
    ADD CONSTRAINT city_name_key UNIQUE (name);


--
-- Name: city_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- Name: country_name_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_name_key UNIQUE (name);


--
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- Name: delivery_type_cost_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY delivery_type
    ADD CONSTRAINT delivery_type_cost_key UNIQUE (cost);


--
-- Name: delivery_type_name_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY delivery_type
    ADD CONSTRAINT delivery_type_name_key UNIQUE (name);


--
-- Name: delivery_type_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY delivery_type
    ADD CONSTRAINT delivery_type_pkey PRIMARY KEY (id);


--
-- Name: faq_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY faq
    ADD CONSTRAINT faq_pkey PRIMARY KEY (id);


--
-- Name: faq_question_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY faq
    ADD CONSTRAINT faq_question_key UNIQUE (question);


--
-- Name: photo_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: product_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY product_cart
    ADD CONSTRAINT product_cart_pkey PRIMARY KEY (id, "idUser");


--
-- Name: product_id_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_id_key UNIQUE (id);


--
-- Name: product_purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY product_purchase
    ADD CONSTRAINT product_purchase_pkey PRIMARY KEY ("idProduct", "idPurchase");


--
-- Name: property_name_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY property
    ADD CONSTRAINT property_name_key UNIQUE (name);


--
-- Name: property_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY property
    ADD CONSTRAINT property_pkey PRIMARY KEY (id);


--
-- Name: purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (id);


--
-- Name: review_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY review
    ADD CONSTRAINT review_pkey PRIMARY KEY ("idUser", "idProduct");


--
-- Name: user_email_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_username_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: value_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY value
    ADD CONSTRAINT value_pkey PRIMARY KEY (id);


--
-- Name: values_list_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY values_list
    ADD CONSTRAINT values_list_pkey PRIMARY KEY (id);


--
-- Name: wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1761; Tablespace: 
--

ALTER TABLE ONLY wishlist
    ADD CONSTRAINT wishlist_pkey PRIMARY KEY ("idUser", "idProduct");


--
-- Name: address_idCity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY address
    ADD CONSTRAINT "address_idCity_fkey" FOREIGN KEY ("idCity") REFERENCES city(id) ON DELETE CASCADE;


--
-- Name: address_idUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY address
    ADD CONSTRAINT "address_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "user"(id) ON DELETE CASCADE;


--
-- Name: admin_idUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY admin
    ADD CONSTRAINT "admin_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "user"(id) ON DELETE CASCADE;


--
-- Name: archived_product_idProduct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY archived_product
    ADD CONSTRAINT "archived_product_idProduct_fkey" FOREIGN KEY ("idProduct") REFERENCES product(id) ON DELETE CASCADE;


--
-- Name: category_property_idCategory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY category_property
    ADD CONSTRAINT "category_property_idCategory_fkey" FOREIGN KEY ("idCategory") REFERENCES category(id) ON DELETE CASCADE;


--
-- Name: category_property_idProperty_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY category_property
    ADD CONSTRAINT "category_property_idProperty_fkey" FOREIGN KEY ("idProperty") REFERENCES property(id) ON DELETE CASCADE;


--
-- Name: city_idCountry_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY city
    ADD CONSTRAINT "city_idCountry_fkey" FOREIGN KEY ("idCountry") REFERENCES country(id) ON DELETE CASCADE;


--
-- Name: photo_idProduct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY photo
    ADD CONSTRAINT "photo_idProduct_fkey" FOREIGN KEY ("idProduct") REFERENCES product(id) ON DELETE CASCADE;


--
-- Name: product_cart_idUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY product_cart
    ADD CONSTRAINT "product_cart_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "user"(id) ON DELETE CASCADE;


--
-- Name: product_idCategory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY product
    ADD CONSTRAINT "product_idCategory_fkey" FOREIGN KEY ("idCategory") REFERENCES category(id) ON DELETE CASCADE;


--
-- Name: product_purchase_idProduct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY product_purchase
    ADD CONSTRAINT "product_purchase_idProduct_fkey" FOREIGN KEY ("idProduct") REFERENCES product(id) ON DELETE CASCADE;


--
-- Name: product_purchase_idPurchase_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY product_purchase
    ADD CONSTRAINT "product_purchase_idPurchase_fkey" FOREIGN KEY ("idPurchase") REFERENCES purchase(id) ON DELETE CASCADE;


--
-- Name: purchase_idAddress_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY purchase
    ADD CONSTRAINT "purchase_idAddress_fkey" FOREIGN KEY ("idAddress") REFERENCES address(id) ON DELETE CASCADE;


--
-- Name: purchase_idUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY purchase
    ADD CONSTRAINT "purchase_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "user"(id) ON DELETE CASCADE;


--
-- Name: review_idProduct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY review
    ADD CONSTRAINT "review_idProduct_fkey" FOREIGN KEY ("idProduct") REFERENCES product(id) ON DELETE CASCADE;


--
-- Name: review_idUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY review
    ADD CONSTRAINT "review_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "user"(id) ON DELETE CASCADE;


--
-- Name: value_idValueList_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY value
    ADD CONSTRAINT "value_idValueList_fkey" FOREIGN KEY ("idValueList") REFERENCES values_list(id) ON DELETE CASCADE;


--
-- Name: values_list_idCategoryProperty_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY values_list
    ADD CONSTRAINT "values_list_idCategoryProperty_fkey" FOREIGN KEY ("idCategoryProperty") REFERENCES category_property(id) ON DELETE CASCADE;


--
-- Name: values_list_idProduct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY values_list
    ADD CONSTRAINT "values_list_idProduct_fkey" FOREIGN KEY ("idProduct") REFERENCES product(id) ON DELETE CASCADE;


--
-- Name: wishlist_idProduct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY wishlist
    ADD CONSTRAINT "wishlist_idProduct_fkey" FOREIGN KEY ("idProduct") REFERENCES product(id) ON DELETE CASCADE;


--
-- Name: wishlist_idUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1761
--

ALTER TABLE ONLY wishlist
    ADD CONSTRAINT "wishlist_idUser_fkey" FOREIGN KEY ("idUser") REFERENCES "user"(id) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: lbaw1761
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM lbaw1761;
GRANT ALL ON SCHEMA public TO lbaw1761;


--
-- PostgreSQL database dump complete
--

