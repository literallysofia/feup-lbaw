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

/*ADMINS*/
INSERT INTO admins ("user_id") VALUES (1); /*1*/
INSERT INTO admins ("user_id") VALUES (2); /*2*/
INSERT INTO admins ("user_id") VALUES (3); /*3*/
INSERT INTO admins ("user_id") VALUES (4); /*4*/

/*COUNTRIES*/
INSERT INTO countries (name) VALUES ('Venezuela'); /*1*/
INSERT INTO countries (name) VALUES ('China'); /*2*/
INSERT INTO countries (name) VALUES ('Mongolia'); /*3*/
INSERT INTO countries (name) VALUES ('Colombia'); /*4*/
INSERT INTO countries (name) VALUES ('Vietnam'); /*5*/
INSERT INTO countries (name) VALUES ('Russia'); /*6*/
INSERT INTO countries (name) VALUES ('Indonesia'); /*7*/
INSERT INTO countries (name) VALUES ('Brazil'); /*8*/
INSERT INTO countries (name) VALUES ('United States'); /*9*/
INSERT INTO countries (name) VALUES ('France'); /*10*/
INSERT INTO countries (name) VALUES ('Tajikistan'); /*11*/
INSERT INTO countries (name) VALUES ('Portugal'); /*12*/
INSERT INTO countries (name) VALUES ('Peru'); /*13*/
INSERT INTO countries (name) VALUES ('Nigeria'); /*14*/

/*CITIES*/
INSERT INTO cities (name,"country_id") VALUES ('Rubio', 1);
INSERT INTO cities (name,"country_id") VALUES ('Jiayuguan', 2);
INSERT INTO cities (name,"country_id") VALUES ('Huanggang', 2);
INSERT INTO cities (name,"country_id") VALUES ('Ereencav', 3);
INSERT INTO cities (name,"country_id") VALUES ('El Cocuy', 4);
INSERT INTO cities (name,"country_id") VALUES ('Xinzheng', 2);
INSERT INTO cities (name,"country_id") VALUES ('Gawul', 7);
INSERT INTO cities (name,"country_id") VALUES ('Trà My', 5);
INSERT INTO cities (name,"country_id") VALUES ('Mikun’', 6);
INSERT INTO cities (name,"country_id") VALUES ('Ambarita', 7);
INSERT INTO cities (name,"country_id") VALUES ('Taquarituba', 8);
INSERT INTO cities (name,"country_id") VALUES ('Arlington', 9);
INSERT INTO cities (name,"country_id") VALUES ('Caen', 10);
INSERT INTO cities (name,"country_id") VALUES ('Itacorubi', 8);
INSERT INTO cities (name,"country_id") VALUES ('Darband', 11);
INSERT INTO cities (name,"country_id") VALUES ('Seixal', 12);
INSERT INTO cities (name,"country_id") VALUES ('Zlatoust', 6);
INSERT INTO cities (name,"country_id") VALUES ('Mucllo', 13);
INSERT INTO cities (name,"country_id") VALUES ('Dashi', 2);
INSERT INTO cities (name,"country_id") VALUES ('Kuta', 14);

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

/*FAQS*/
INSERT INTO faqs (question, answer) VALUES ('Sed sagittis?', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.');
INSERT INTO faqs (question, answer) VALUES ('Nullam varius?', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO faqs (question, answer) VALUES ('Ut tellus. Nulla ut erat id mauris vulputate elementum?', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.');
INSERT INTO faqs (question, answer) VALUES ('Suspendisse accumsan tortor quis turpi?', 'Aenean fermentum.');
INSERT INTO faqs (question, answer) VALUES ('Curabitur at ipsum ac tellus semper interdum?', 'Morbi porttitor lorem id ligula.');
INSERT INTO faqs (question, answer) VALUES ('Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum?', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO faqs (question, answer) VALUES ('Nullam sit amet turpis elementum ligula vehicula consequat?', 'Suspendisse potenti. In eleifend quam a odio.');

/*CATEGORIES*/
INSERT INTO categories (name, "is_navbar_category") VALUES ('Smartphones', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Tablets', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Computers', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Monitors', true);
INSERT INTO categories (name, "is_navbar_category") VALUES ('Acessories', true);

/*PRODUCTS*/
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple iPhone X - 64GB - Space Grey', '1179.00', 100, 3, 1, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple iPhone X - 256GB - Space Grey', '1359.00', 50, 4, 1, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple iPhone X - 64GB - Silver', '1179.00', 40, 5, 1, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple iPhone X - 256GB - Silver', '1359.00', 80, 4, 1, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple iPhone 8 - 64GB - Gold', '829.00', 60, 4, 1, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple iPhone 8 - 256GB - Space Gray', '1009.00', 30, 5, 1, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Samsung Galaxy S9+ - 64GB - Midnight Black', '969.90', 100, 3, 1, 'Samsung');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Samsung Galaxy S9 - 64GB - Blue', '869.99', 90, 4, 1, 'Samsung');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Samsung Galaxy S9 - 64GB - Purple', '869.99', 100, 5, 1, 'Samsung');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple iPhone 8 Plus - 64GB - Silver', '939.00', 40, 2, 1, 'Apple');

INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple iPad Pro 12,9" - 256GB - Space Grey', '1249.00', 100, 5, 2, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple iPad Pro 12,9" - 64GB - Gold', '1079.00', 50, 5, 2, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple iPad Pro 12,9" - 64GB - Silver', '953.00', 60, 5, 2, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Samsung T560 Galaxy Tab E 9.6" - Black', '199.99', 80, 2, 2, 'Samsung');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Samsung Galaxy Tab S2 8.0" - T719 - Black', '459.99', 100, 1, 2, 'Samsung');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Samsung Galaxy Tab S2 9.7" - T819 - Black', '529.99', 90, 5, 2, 'Samsung');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Asus ZenPad 10" Z301MF-1H011A - Grey', '219.99', 20, 5, 2, 'Asus');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Asus ZenPad 8 Z380M - Dark Gray', '169.99', 10, 3, 2, 'Asus');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Huawei MediaPad M3 8.4"', '321.00', 100, 1, 2, 'Huawei');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Huawei MediaPad M2 10.0 - 64GB -Moonlight Silver', '549.02', 90, 2, 2, 'Huawei');

INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple MacBook Pro 13" Retina i5-2,3GHz - 128GB - Space Gray', '1549.00', 50, 2, 3, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple MacBook Pro 13" Retina i7-3,5GHz - 512GB - Touch Bar - Space Gray', '2950.27', 10, 1, 3, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple MacBook Air 13" i5-1,8GHz - 256GB', '1379.00', 50, 1, 3, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Apple MacBook Air 13" i7-2,2GHz - 512GB', '1810.27', 20, 1, 3, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Asus Zenbook UX430UA-57CHDCB1', '949.99', 80, 1, 3, 'Asus');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Asus Gaming ROG FX503VD-77A05', '1199.99', 90, 3, 3, 'Asus');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Microsoft Surface Pro - Core i5 - 128GB', '1169.00', 100, 5, 3, 'Microsoft');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Microsoft Surface Laptop - Platina - Core i5 - 128GB', '1169.00', 30, 1, 3, 'Microsoft');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Lenovo Ideapad 710S-13IKB - i5-7200U', '999.99', 80, 1, 3, 'Lenovo');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('HP 15-bs118np', '799.99', 60, 3, 3, 'HP');

INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Gaming Asus FHD VP278QG - 27"', '259.99', 80, 3, 4, 'Asus');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Dell UHD 4K S2817Q - 28"', '469.99', 20, 5, 4, 'Dell');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Samsung Monitor FHD C27F390FHU 27"', '329.99', 10, 1, 4, 'Samsung');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('iMac 21,5" Retina 5K - 2,3 GHz - 1 TB', '1349.00', 90, 3, 4, 'Apple');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('iMac 27" Retina 5K - 3,8 GHz - 2 TB', '2699.00', 15, 1, 4, 'Apple');

INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('HP Mouse Wireless X4500 - Black', '29.99', 20, 1, 5, 'HP');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Headphones Gaming HyperX Cloud II - Gun Metal', '109.99', 80, 5, 5, 'Hyperx');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Headphones Beats Studio3 Wireless - Black Shadow', '349.99', 10, 2, 5, 'Beats');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Power Bank Xiaomi Mi Power 20000mAh - White', '45.99', 50, 1, 5, 'Xiaomi');
INSERT INTO products (name, price, quantity_available, score, category_id, brand) VALUES ('Power Bank Asus ZenPower 10050mAh - Black', '40.99', 40, 1, 5, 'Asus');

/*PHOTOS*/
INSERT INTO photos (id, path, "product_id") VALUES (1, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 1);
INSERT INTO photos (id, path, "product_id") VALUES (2, 'http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 2);
INSERT INTO photos (id, path, "product_id") VALUES (3, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 3);
INSERT INTO photos (id, path, "product_id") VALUES (4, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 4);
INSERT INTO photos (id, path, "product_id") VALUES (5, 'http://dummyimage.com/1000x810.jpg/dddddd/000000', 5);
INSERT INTO photos (id, path, "product_id") VALUES (6, 'http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 6);
INSERT INTO photos (id, path, "product_id") VALUES (7, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 7);
INSERT INTO photos (id, path, "product_id") VALUES (8, 'http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 8);
INSERT INTO photos (id, path, "product_id") VALUES (9, 'http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 9);
INSERT INTO photos (id, path, "product_id") VALUES (10, 'http://dummyimage.com/1000x810.jpg/dddddd/000000', 10);
INSERT INTO photos (id, path, "product_id") VALUES (11, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 11);
INSERT INTO photos (id, path, "product_id") VALUES (12, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 12);
INSERT INTO photos (id, path, "product_id") VALUES (13, 'http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 13);
INSERT INTO photos (id, path, "product_id") VALUES (14, 'http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 14);
INSERT INTO photos (id, path, "product_id") VALUES (15, 'http://dummyimage.com/1000x810.jpg/dddddd/000000', 15);
INSERT INTO photos (id, path, "product_id") VALUES (16, 'http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 16);
INSERT INTO photos (id, path, "product_id") VALUES (17, 'http://dummyimage.com/1000x810.jpg/dddddd/000000', 17);
INSERT INTO photos (id, path, "product_id") VALUES (18, 'http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 18);
INSERT INTO photos (id, path, "product_id") VALUES (19, 'http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 19);
INSERT INTO photos (id, path, "product_id") VALUES (20, 'http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 20);
INSERT INTO photos (id, path, "product_id") VALUES (21, 'http://dummyimage.com/1000x810.jpg/dddddd/000000', 21);
INSERT INTO photos (id, path, "product_id") VALUES (22, 'http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 22);
INSERT INTO photos (id, path, "product_id") VALUES (23, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 23);
INSERT INTO photos (id, path, "product_id") VALUES (24, 'http://dummyimage.com/1000x810.jpg/dddddd/000000', 24);
INSERT INTO photos (id, path, "product_id") VALUES (25, 'http://dummyimage.com/1000x810.jpg/dddddd/000000', 25);
INSERT INTO photos (id, path, "product_id") VALUES (26, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 26);
INSERT INTO photos (id, path, "product_id") VALUES (27, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 27);
INSERT INTO photos (id, path, "product_id") VALUES (28, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 28);
INSERT INTO photos (id, path, "product_id") VALUES (29, 'http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 29);
INSERT INTO photos (id, path, "product_id") VALUES (30, 'http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 30);
INSERT INTO photos (id, path, "product_id") VALUES (31, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 31);
INSERT INTO photos (id, path, "product_id") VALUES (32, 'http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 32);
INSERT INTO photos (id, path, "product_id") VALUES (33, 'http://dummyimage.com/1000x810.jpg/dddddd/000000', 33);
INSERT INTO photos (id, path, "product_id") VALUES (34, 'http://dummyimage.com/1000x810.jpg/dddddd/000000', 34);
INSERT INTO photos (id, path, "product_id") VALUES (35, 'http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 35);
INSERT INTO photos (id, path, "product_id") VALUES (36, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 36);
INSERT INTO photos (id, path, "product_id") VALUES (37, 'http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 37);
INSERT INTO photos (id, path, "product_id") VALUES (38, 'http://dummyimage.com/1000x810.jpg/ff4444/ffffff', 38);
INSERT INTO photos (id, path, "product_id") VALUES (39, 'http://dummyimage.com/1000x810.jpg/5fa2dd/ffffff', 39);
INSERT INTO photos (id, path, "product_id") VALUES (40, 'http://dummyimage.com/1000x810.jpg/cc0000/ffffff', 40);

/*PURCHASE*/
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (1, '2017-08-07', 2914.73, 2, 4, 'Processing');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (2, '2017-10-31', 1709.06, 7, 1, 'Shipped');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (3, '2017-10-04', 3964.32, 7, 1, 'Delivered');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (4, '2017-08-18', 1408.06, 9, 16, 'Processing');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (5, '2017-04-11', 1115.11, 8, 9, 'Shipped');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (6, '2017-12-12', 4507.83, 8, 9, 'Shipped');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (7, '2018-01-20', 899.21, 14, 18, 'Processing');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (8, '2018-02-28', 3471.12, 16, 13, 'Processing');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (9, '2017-02-22', 625.19, 19, 6, 'Shipped');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (10, '2017-04-02', 4929.18, 13, 19, 'Delivered');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (11, '2017-10-10', 3464.1, 3, 2, 'Shipped');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (12, '2017-07-31', 4273.67, 7, 1, 'Processing');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (13, '2017-11-18', 538.7, 9, 17, 'Processing');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (14, '2017-06-15', 3259.77, 14, 18, 'Delivered');
INSERT INTO purchases (id, date, total, user_id, address_id, status) VALUES (15, '2017-02-15', 1201.51, 10, 20, 'Shipped');

/*PRODUCT-PURCHASE*/
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (1, 14, 1, 1106.96);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (2, 4, 2, 717.73);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (3, 8, 1, 1072.94);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (4, 8, 1, 1107.96);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (5, 12, 2, 556.97);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (6, 15, 1, 910.6);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (7, 9, 1, 1015.66);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (8, 7, 2, 1064.08);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (9, 14, 2, 840.37);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (10, 3, 2, 885.43);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (11, 9, 1, 462.09);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (12, 5, 2, 666.96);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (13, 5, 2, 689.05);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (14, 5, 2, 1180.96);
INSERT INTO product_purchases (product_id, purchase_id, quantity, price) VALUES (15, 15, 1, 596.35);