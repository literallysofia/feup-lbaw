

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
INSERT INTO admins ("user_id") values (1); /*1*/
INSERT INTO admins ("user_id") values (2); /*2*/
INSERT INTO admins ("user_id") values (3); /*3*/
INSERT INTO admins ("user_id") values (4); /*4*/

/*COUNTRIES*/
INSERT INTO countries (name) values ('Venezuela'); /*1*/
INSERT INTO countries (name) values ('China'); /*2*/
INSERT INTO countries (name) values ('Mongolia'); /*3*/
INSERT INTO countries (name) values ('Colombia'); /*4*/
INSERT INTO countries (name) values ('Vietnam'); /*5*/
INSERT INTO countries (name) values ('Russia'); /*6*/
INSERT INTO countries (name) values ('Indonesia'); /*7*/
INSERT INTO countries (name) values ('Brazil'); /*8*/
INSERT INTO countries (name) values ('United States'); /*9*/
INSERT INTO countries (name) values ('France'); /*10*/
INSERT INTO countries (name) values ('Tajikistan'); /*11*/
INSERT INTO countries (name) values ('Portugal'); /*12*/
INSERT INTO countries (name) values ('Peru'); /*13*/
INSERT INTO countries (name) values ('Nigeria'); /*14*/

/*CITIES*/
INSERT INTO cities (name,"country_id") values ('Rubio', 1);
INSERT INTO cities (name,"country_id") values ('Jiayuguan', 2);
INSERT INTO cities (name,"country_id") values ('Huanggang', 2);
INSERT INTO cities (name,"country_id") values ('Ereencav', 3);
INSERT INTO cities (name,"country_id") values ('El Cocuy', 4);
INSERT INTO cities (name,"country_id") values ('Xinzheng', 2);
INSERT INTO cities (name,"country_id") values ('Gawul', 7);
INSERT INTO cities (name,"country_id") values ('Trà My', 5);
INSERT INTO cities (name,"country_id") values ('Mikun’', 6);
INSERT INTO cities (name,"country_id") values ('Ambarita', 7);
INSERT INTO cities (name,"country_id") values ('Taquarituba', 8);
INSERT INTO cities (name,"country_id") values ('Arlington', 9);
INSERT INTO cities (name,"country_id") values ('Caen', 10);
INSERT INTO cities (name,"country_id") values ('Itacorubi', 8);
INSERT INTO cities (name,"country_id") values ('Darband', 11);
INSERT INTO cities (name,"country_id") values ('Seixal', 12);
INSERT INTO cities (name,"country_id") values ('Zlatoust', 6);
INSERT INTO cities (name,"country_id") values ('Mucllo', 13);
INSERT INTO cities (name,"country_id") values ('Dashi', 2);
INSERT INTO cities (name,"country_id") values ('Kuta', 14);


/*ADDRESSES*/
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('home', 'Dennis', '18740-000', 1, 7);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('country house', 'Dahle', '18740-000', 2, 3);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('company', 'Luster', '22205', 3, 18);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('home', 'Monica', '88000-000', 4, 2);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('work', 'Manitowish', '151287', 5, 16);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('work', 'Dovetail', '22205', 6, 19);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('home', 'Garrison', '88000-000', 7, 2);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('home', 'Loeprich', '88000-000', 8, 13);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('work', 'Prairieview', '169060', 9, 8);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('work', 'Fairfield', '88000-000', 10, 16);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('home', '1st', '18740-000', 11, 2);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('work', 'Waxwing', '22205', 12, 15);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('work', 'Memorial', '14908 CEDEX 9', 13, 16);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('work', 'Nova', '88000-000', 14, 12);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('home', 'Ramsey', '18740-000', 15, 4);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('home', 'Monument', '2530-254', 16, 9);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('home', 'Valley Edge', '456209', 17, 9);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('work', 'Thierer', '88000-000', 18, 14);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('work', 'Meadow Vale', '456209', 19, 13);
INSERT INTO addresses (name, street, "postal_code", "city_id", "user_id") values ('home', 'Veith', '18740-000', 20, 10);

/*FAQS*/
INSERT INTO faqs (question, answer) values ('Sed sagittis?', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.');
INSERT INTO faqs (question, answer) values ('Nullam varius?', 'Aliquam quis turpis eget elit sodales scelerisque.');
INSERT INTO faqs (question, answer) values ('Ut tellus. Nulla ut erat id mauris vulputate elementum?', 'Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.');
INSERT INTO faqs (question, answer) values ('Suspendisse accumsan tortor quis turpi?', 'Aenean fermentum.');
INSERT INTO faqs (question, answer) values ('Curabitur at ipsum ac tellus semper interdum?', 'Morbi porttitor lorem id ligula.');
INSERT INTO faqs (question, answer) values ('Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum?', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.');
INSERT INTO faqs (question, answer) values ('Nullam sit amet turpis elementum ligula vehicula consequat?', 'Suspendisse potenti. In eleifend quam a odio.');
