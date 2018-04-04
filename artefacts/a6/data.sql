/*ADDRESSES*/
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Dennis', '18740-000', 1, 7);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('country house', 'Dahle', '18740-000', 2, 3);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('company', 'Luster', '22205', 3, 18);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('home', 'Monica', '88000-000', 4, 2);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") VALUES ('work', 'Manitowish', '151287', 5, 16);
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

/*ARCHIVED-PRODUCTS*/
INSERT INTO archived_products ("product_id") VALUES (10);
INSERT INTO archived_products ("product_id") VALUES (12);

/*CATEGORIES*/
INSERT INTO categories (name, "is_navbar_category") VALUES ('Smartphones', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Tablets', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Computers', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Monitors', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Accessories', true);

/*CATEGORIES-PROPERTIES*/
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 1, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 2, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 3, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 4, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 7, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 8, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 10, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 11, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 12, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 13, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 15, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (1, 16, true);

INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 1, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 2, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 3, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 4, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 5, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 6, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 7, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 8, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 9, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 10, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 11, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 12, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 13, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 14, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (2, 16, true);

INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 1, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 2, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 3, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 4, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 7, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 8, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 10, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 11, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 12, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 13, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 14, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 15, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (3, 16, true);

INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (4, 1, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (4, 3, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (4, 8, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (4, 13, true);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (4, 16, false);

INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 1, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 7, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 8, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 11, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 12, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 13, false);
INSERT INTO category_properties ("category_id", "property_id", "is_required_property") VALUES (5, 16, false);

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

/*DELIVERY_TYPES*/
INSERT INTO delivery_types (name, cost) VALUES ('Standard Delivery', '0.99');
INSERT INTO delivery_types (name, cost) VALUES ('Express Delivery', '9.99');
INSERT INTO delivery_types (name, cost) VALUES ('Priority Delivery', '19.99');

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

/*PRODUCT-CARTS*/
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (6, 16, 2);
INSERT INTO product_carts ("user_id", "product_id", quantity) VALUES (6, 2, 2);
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

/*PRODUCT-PURCHASES*/
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (1, 14, 1, 1106.96);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (2, 4, 2, 717.73);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (3, 8, 1, 1072.94);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (4, 8, 1, 1107.96);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (5, 12, 2, 556.97);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (6, 15, 1, 910.6);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (7, 9, 1, 1015.66);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (8, 7, 2, 1064.08);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (9, 14, 2, 840.37);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (10, 3, 2, 885.43);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (11, 9, 1, 462.09);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (12, 5, 2, 666.96);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (13, 5, 2, 689.05);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (14, 5, 2, 1180.96);
INSERT INTO product_purchases ("product_id", "purchase_id", quantity, price) VALUES (15, 15, 1, 596.35);

/*PRODUCTS*/
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Apple iPhone X - 64GB - Space Grey', '1179.00', 100, 3, 1, 'Apple');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Apple iPhone 8 - 64GB - Gold', '829.00', 60, 4, 1, 'Apple');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Samsung Galaxy S9+ - 64GB - Midnight Black', '969.90', 100, 3, 1, 'Samsung');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Samsung Galaxy S9 - 64GB - Blue', '869.99', 90, 4, 1, 'Samsung');

INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Apple iPad Pro 12,9" - 256GB - Space Grey', '1249.00', 100, 5, 2, 'Apple');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Samsung Galaxy Tab S2 9.7" - T819 - Black', '529.99', 90, 5, 2, 'Samsung');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Asus ZenPad 10" Z301MF-1H011A - Grey', '219.99', 20, 5, 2, 'Asus');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Huawei MediaPad M3 8.4"', '321.00', 100, 1, 2, 'Huawei');

INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Apple MacBook Pro 13" Retina i5-2,3GHz - 128GB - Space Gray', '1549.00', 50, 2, 3, 'Apple');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Apple MacBook Air 13" i5-1,8GHz - 256GB', '1379.00', 50, 1, 3, 'Apple');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Asus Zenbook UX430UA-57CHDCB1', '949.99', 80, 1, 3, 'Asus');

INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Gaming Asus FHD VP278QG - 27"', '259.99', 80, 3, 4, 'Asus');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('iMac 21,5" Retina 5K - 2,3 GHz - 1 TB', '1349.00', 90, 3, 4, 'Apple');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('iMac 27" Retina 5K - 3,8 GHz - 2 TB', '2699.00', 15, 1, 4, 'Apple');

INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Headphones Beats Studio3 Wireless - Black Shadow', '349.99', 10, 2, 5, 'Beats');
INSERT INTO products (name, price, "quantity_available", score, "category_id", brand) VALUES ('Power Bank Xiaomi Mi Power 20000mAh - White', '45.99', 50, 1, 5, 'Xiaomi');

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
INSERT INTO properties (name) VALUES ('Sensors');
INSERT INTO properties (name) VALUES ('Accessories');

/*PURCHASES*/
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-08-07', 2914.73, 2, 4, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-10-31', 1709.06, 7, 1, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-10-04', 3964.32, 7, 1, 'Delivered');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-08-18', 1408.06, 9, 16, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-04-11', 1115.11, 8, 9, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-12-12', 4507.83, 8, 9, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2018-01-20', 899.21, 14, 18, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2018-02-28', 3471.12, 16, 13, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-02-22', 625.19, 19, 6, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-04-02', 4929.18, 13, 19, 'Delivered');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-10-10', 3464.1, 3, 2, 'Shipped');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-07-31', 4273.67, 7, 1, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-11-18', 538.7, 9, 17, 'Processing');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-06-15', 3259.77, 14, 18, 'Delivered');
INSERT INTO purchases (date, total, "user_id", "address_id", status) VALUES ('2017-02-15', 1201.51, 10, 20, 'Shipped');

/*REVIEWS*/
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (9, 2, 1, 'Some title', 'Some content.', '2017-06-22');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (10, 6, 5, 'Some title', 'Some content.', '2017-08-12');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (16, 3, 4, 'Some title', 'Some content.', '2018-02-04');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (19, 11, 2, 'Some title', 'Some content.', '2017-03-13');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (10, 15, 3, 'Some title', 'Some content.', '2017-12-28');
INSERT INTO reviews ("user_id", "product_id", score, title, content, date) VALUES (8, 12, 4, 'Some title', 'Some content.', '2018-03-22');

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

/*VALUES*/
INSERT INTO values (name, "values_list_id") VALUES ('cubilia curae', 1);
INSERT INTO values (name, "values_list_id") VALUES ('parturient montes', 2);
INSERT INTO values (name, "values_list_id") VALUES ('platea', 3);
INSERT INTO values (name, "values_list_id") VALUES ('adipiscing lorem', 4);
INSERT INTO values (name, "values_list_id") VALUES ('nulla tellus in', 5);
INSERT INTO values (name, "values_list_id") VALUES ('imperdiet', 6);
INSERT INTO values (name, "values_list_id") VALUES ('justo eu', 7);
INSERT INTO values (name, "values_list_id") VALUES ('vestibulum vestibulum', 8);
INSERT INTO values (name, "values_list_id") VALUES ('id justo', 9);
INSERT INTO values (name, "values_list_id") VALUES ('rutrum rutrum neque', 10);
INSERT INTO values (name, "values_list_id") VALUES ('vel', 11);
INSERT INTO values (name, "values_list_id") VALUES ('curabitur in libero', 12);
INSERT INTO values (name, "values_list_id") VALUES ('maecenas ut', 13);
INSERT INTO values (name, "values_list_id") VALUES ('curabitur at ipsum', 14);
INSERT INTO values (name, "values_list_id") VALUES ('sed accumsan felis', 15);
INSERT INTO values (name, "values_list_id") VALUES ('in magna', 16);
INSERT INTO values (name, "values_list_id") VALUES ('quisque', 17);
INSERT INTO values (name, "values_list_id") VALUES ('nulla ultrices', 18);
INSERT INTO values (name, "values_list_id") VALUES ('ac consequat metus', 19);
INSERT INTO values (name, "values_list_id") VALUES ('ac lobortis', 20);
INSERT INTO values (name, "values_list_id") VALUES ('quis', 21);
INSERT INTO values (name, "values_list_id") VALUES ('varius', 22);
INSERT INTO values (name, "values_list_id") VALUES ('vivamus vestibulum', 23);
INSERT INTO values (name, "values_list_id") VALUES ('sed', 24);
INSERT INTO values (name, "values_list_id") VALUES ('suscipit', 25);
INSERT INTO values (name, "values_list_id") VALUES ('est quam pharetra', 26);
INSERT INTO values (name, "values_list_id") VALUES ('luctus ultricies', 27);
INSERT INTO values (name, "values_list_id") VALUES ('quisque id', 28);
INSERT INTO values (name, "values_list_id") VALUES ('sapien cursus vestibulum', 29);
INSERT INTO values (name, "values_list_id") VALUES ('ultrices aliquet maecenas', 30);
INSERT INTO values (name, "values_list_id") VALUES ('in faucibus', 31);
INSERT INTO values (name, "values_list_id") VALUES ('quis', 32);
INSERT INTO values (name, "values_list_id") VALUES ('dui', 33);
INSERT INTO values (name, "values_list_id") VALUES ('luctus et', 34);
INSERT INTO values (name, "values_list_id") VALUES ('nulla', 35);
INSERT INTO values (name, "values_list_id") VALUES ('diam', 36);
INSERT INTO values (name, "values_list_id") VALUES ('id pretium iaculis', 37);
INSERT INTO values (name, "values_list_id") VALUES ('lacus at', 38);
INSERT INTO values (name, "values_list_id") VALUES ('nibh quisque id', 39);
INSERT INTO values (name, "values_list_id") VALUES ('posuere', 40);
INSERT INTO values (name, "values_list_id") VALUES ('molestie nibh', 41);
INSERT INTO values (name, "values_list_id") VALUES ('ultrices vel augue', 42);
INSERT INTO values (name, "values_list_id") VALUES ('turpis sed ante', 43);
INSERT INTO values (name, "values_list_id") VALUES ('in', 44);
INSERT INTO values (name, "values_list_id") VALUES ('sit', 45);
INSERT INTO values (name, "values_list_id") VALUES ('tempus', 46);
INSERT INTO values (name, "values_list_id") VALUES ('nonummy', 47);
INSERT INTO values (name, "values_list_id") VALUES ('nec dui luctus', 48);
INSERT INTO values (name, "values_list_id") VALUES ('vel lectus in', 49);
INSERT INTO values (name, "values_list_id") VALUES ('ultrices erat tortor', 50);
INSERT INTO values (name, "values_list_id") VALUES ('at', 51);
INSERT INTO values (name, "values_list_id") VALUES ('quis orci eget', 52);
INSERT INTO values (name, "values_list_id") VALUES ('porta', 53);
INSERT INTO values (name, "values_list_id") VALUES ('ut', 54);
INSERT INTO values (name, "values_list_id") VALUES ('est quam pharetra', 55);
INSERT INTO values (name, "values_list_id") VALUES ('erat', 56);
INSERT INTO values (name, "values_list_id") VALUES ('ac', 57);
INSERT INTO values (name, "values_list_id") VALUES ('luctus tincidunt', 58);
INSERT INTO values (name, "values_list_id") VALUES ('tortor', 59);
INSERT INTO values (name, "values_list_id") VALUES ('at turpis donec', 60);
INSERT INTO values (name, "values_list_id") VALUES ('interdum', 61);
INSERT INTO values (name, "values_list_id") VALUES ('in lectus', 62);
INSERT INTO values (name, "values_list_id") VALUES ('pede', 63);
INSERT INTO values (name, "values_list_id") VALUES ('et magnis dis', 64);
INSERT INTO values (name, "values_list_id") VALUES ('amet lobortis sapien', 65);
INSERT INTO values (name, "values_list_id") VALUES ('morbi', 66);
INSERT INTO values (name, "values_list_id") VALUES ('luctus cum', 67);
INSERT INTO values (name, "values_list_id") VALUES ('donec', 68);
INSERT INTO values (name, "values_list_id") VALUES ('faucibus', 69);
INSERT INTO values (name, "values_list_id") VALUES ('pretium iaculis justo', 70);
INSERT INTO values (name, "values_list_id") VALUES ('integer ac leo', 71);
INSERT INTO values (name, "values_list_id") VALUES ('nulla sed', 72);
INSERT INTO values (name, "values_list_id") VALUES ('cubilia curae', 73);
INSERT INTO values (name, "values_list_id") VALUES ('est donec odio', 74);
INSERT INTO values (name, "values_list_id") VALUES ('et commodo vulputate', 75);
INSERT INTO values (name, "values_list_id") VALUES ('sapien urna', 76);
INSERT INTO values (name, "values_list_id") VALUES ('amet consectetuer', 77);
INSERT INTO values (name, "values_list_id") VALUES ('ante', 78);
INSERT INTO values (name, "values_list_id") VALUES ('amet eleifend', 79);
INSERT INTO values (name, "values_list_id") VALUES ('rutrum', 80);
INSERT INTO values (name, "values_list_id") VALUES ('aliquam', 81);
INSERT INTO values (name, "values_list_id") VALUES ('mus', 82);
INSERT INTO values (name, "values_list_id") VALUES ('tristique in tempus', 83);
INSERT INTO values (name, "values_list_id") VALUES ('at', 84);
INSERT INTO values (name, "values_list_id") VALUES ('phasellus', 85);
INSERT INTO values (name, "values_list_id") VALUES ('id consequat', 86);
INSERT INTO values (name, "values_list_id") VALUES ('pellentesque', 87);
INSERT INTO values (name, "values_list_id") VALUES ('auctor sed', 88);
INSERT INTO values (name, "values_list_id") VALUES ('bibendum', 89);
INSERT INTO values (name, "values_list_id") VALUES ('interdum', 90);
INSERT INTO values (name, "values_list_id") VALUES ('nec dui luctus', 91);
INSERT INTO values (name, "values_list_id") VALUES ('vehicula condimentum curabitur', 92);
INSERT INTO values (name, "values_list_id") VALUES ('sit amet lobortis', 93);
INSERT INTO values (name, "values_list_id") VALUES ('vivamus vestibulum sagittis', 94);
INSERT INTO values (name, "values_list_id") VALUES ('duis ac', 95);
INSERT INTO values (name, "values_list_id") VALUES ('erat quisque', 96);
INSERT INTO values (name, "values_list_id") VALUES ('nam', 97);
INSERT INTO values (name, "values_list_id") VALUES ('aliquam', 98);
INSERT INTO values (name, "values_list_id") VALUES ('sapien', 99);
INSERT INTO values (name, "values_list_id") VALUES ('sit amet cursus', 100);
INSERT INTO values (name, "values_list_id") VALUES ('tempus semper', 101);
INSERT INTO values (name, "values_list_id") VALUES ('in', 102);
INSERT INTO values (name, "values_list_id") VALUES ('tortor quis turpis', 103);
INSERT INTO values (name, "values_list_id") VALUES ('vivamus metus', 104);
INSERT INTO values (name, "values_list_id") VALUES ('ante ipsum primis', 105);
INSERT INTO values (name, "values_list_id") VALUES ('consequat morbi a', 106);
INSERT INTO values (name, "values_list_id") VALUES ('dui proin', 107);


/*VALUES-LIST*/
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (6, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (9, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 1);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (12, 1);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (6, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (9, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 2);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (12, 2);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (6, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (9, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 3);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (12, 3);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (2, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (3, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (4, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (5, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (6, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (7, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (9, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (11, 4);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (12, 4);

/*2*/
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (14, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (15, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (16, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (17, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (18, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (19, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (20, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (24, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (25, 5);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (27, 5);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (14, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (15, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (16, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (17, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (18, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (19, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (20, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (24, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (25, 6);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (27, 6);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (14, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (15, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (16, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (17, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (18, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (19, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (20, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (24, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (25, 7);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (27, 7);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (14, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (15, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (16, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (17, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (18, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (19, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (20, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (24, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (25, 8);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (27, 8);

/*3*/
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (29, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (30, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (31, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (32, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (33, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (36, 9);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (40, 9);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (29, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (30, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (31, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (32, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (33, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (36, 10);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (40, 10);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (29, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (30, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (31, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (32, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (33, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (36, 11);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (40, 11);

/*4*/
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (42, 12);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (43, 12);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (44, 12);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (42, 13);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (43, 13);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (44, 13);

INSERT INTO values_lists ("category_property_id", "product_id") VALUES (42, 14);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (43, 14);
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (44, 14);

/*5*/
INSERT INTO values_lists ("category_property_id", "product_id") VALUES (50, 16);

/*WISHLIST*/
INSERT INTO wishlists ("user_id", "product_id") VALUES (10, 8);
INSERT INTO wishlists ("user_id", "product_id") VALUES (7, 5);
INSERT INTO wishlists ("user_id", "product_id") VALUES (10, 9);
INSERT INTO wishlists ("user_id", "product_id") VALUES (10, 10);
INSERT INTO wishlists ("user_id", "product_id") VALUES (6, 3);
INSERT INTO wishlists ("user_id", "product_id") VALUES (10, 13);
INSERT INTO wishlists ("user_id", "product_id") VALUES (2, 2);
INSERT INTO wishlists ("user_id", "product_id") VALUES (8, 7);
INSERT INTO wishlists ("user_id", "product_id") VALUES (5, 15);
INSERT INTO wishlists ("user_id", "product_id") VALUES (6, 4);