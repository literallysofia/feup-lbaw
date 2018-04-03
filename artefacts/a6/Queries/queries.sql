                            --USER RELATED QUERIES
--update user info
UPDATE users SET email = $email WHERE id = $id;
UPDATE users SET username=$username WHERE id = $id;
UPDATE users SET name=$name WHERE id = $id;
UPDATE users SET password = $hashedPassword WHERE id=$id;

--update user info v2
UPDATE users
SET name=$name, username=$username, email=$email, password=$hashedPassword
WHERE id=$id;

--get user info
SELECT users.name, users.username, users.email
FROM users
WHERE id = $id;

--get user addresses
SELECT A.id, A.name, A.street, A."postal_code", CTY.name, CNTR.name
FROM addresses AS A, cities AS CTY, countries AS CNTR
WHERE A."user_id" = $id
AND A."city_id" = CTY.id
AND CTY."country_id" = CNTR.id;

--Add address
INSERT INTO addresses (name,street,postal_code,city_id,user_id) VALUES ($name,$street,$postal_code,$city_id,$id);

--IMPORTANTE IMPLICA MUDANCA NA BD deletes address from user
DELETE FROM addresses
WHERE user_id=$uID;

--sign in 
SELECT id
FROM users
WHERE username = $username
AND password = $hashedPassword;

SELECT id
FROM users
WHERE email = $email
AND password = $hashedPassword;

--sign up 
INSERT INTO users (name, username, email, password)
VALUES ($name, $username, $email, $hashedPassword);


--get on hold user purchases
SELECT PRCHS.id, PRCHS."date", PRCHS.status, PRCHS.total
FROM users AS U, purchases AS PRCHS
WHERE PRCHS."user_id" = $id AND PRCHS.status in ('Processing', 'Shipped');


-- get finished user purchases
SELECT PRCHS.id, PRCHS."date", PRCHS.status, PRCHS.total
FROM users AS U, purchases AS PRCHS
WHERE PRCHS."user_id" = $id AND PRCHS.status = 'Delivered';


--get purchase products *
SELECT PRDCT.id, PRDCT.name, PP.price, PP.quantity
FROM purchases AS PRCHS, products AS PRDCT, product_purchases AS PP,
WHERE PRCHS.id = $id
AND PP."purchase_id" = PRCHS.id
AND PP."product_id" = PRDCT.id;


--get purchase address *
SELECT A.street, A."postal_code", CTY.name, CNTR.name
FROM purchases AS P, addresses AS A, cities AS CTY, countries AS CNTR
WHERE P.id = $id
AND P."address_id" = A.id
AND A."city_id" = CTY.id
AND CTY."country_id" = CNTR.id;

/*REVIEWS*/
INSERT INTO reviews (user_id,product_id,score,title,content) VALUES ($userID,$productID,$score,$title,$content);
DELETE FROM reviews where user_id=$user_id AND product_id=$product_id

                                        --ADMIN RELATED QUERIES

--get on hold  purchases from any user (EXTREMELY SIMILAR TO THE ONE IN USER SECTION)
SELECT PRCHS.id, PRCHS."date", PRCHS.status, PRCHS.total,PRCHS.user_id
FROM users AS U, purchases AS PRCHS
WHERE PRCHS.status in ('Processing', 'Shipped');

/*UPDATE ON HOLD PURCHASE STATUS*/
UPDATE purchases SET status=$status WHERE purchase_id =$purchaseId

-- get finished purchases from any user (EXTREMELY SIMILAR TO THE ONE IN USER SECTION)
SELECT PRCHS.id, PRCHS."date", PRCHS.status, PRCHS.total,PRCHS.user_id
FROM users AS U, purchases AS PRCHS
WHERE PRCHS.status = 'Delivered';

--get purchase products
    --*SEE IN USER SECTION

--get purchase address
    --*SEE IN USER SECTION

--get purchase user name
SELECT users.username FROM purchases WHERE purchases.user_id =$userId


--get/add/delete properties
SELECT name FROM properties
INSERT INTO properties (name) VALUES ($name);
DELETE FROM properties WHERE properties.name = $name;

/*GET ALL PROPERTIES NAMES FROM EACH CATEGORY*/
SELECT categories.id,categories.name FROM categories
SELECT category_properties.property_id,category_properties.is_required_property
    FROM category_properties WHERE category_id =$category_id;
SELECT name FROM properties WHERE properties.id = $id;

--add category
INSERT INTO categories (name,is_navbar_category) VALUES ($name,$required)

/*FAQS*/
SELECT question,answer FROM faqs;
INSERT INTO faqs (question,answer) VALUES ($question,$answer);
DELETE FROM faqs WHERE answer=$answer;

/* DROPDOWN NAVIGATION ADMIN */
SELECT Categories.name
FROM categories AS Categories 
WHERE  (SELECT COUNT(*)
        FROM products AS Products
        WHERE Products.category_id = Categories.id) > 1;



                                                --OTHER RELATED QUERIES

--get all products from category
SELECT id FROM categories WHERE name=$categoryName;
SELECT products.id,products.name,products.price FROM products WHERE category_id=$categoryId AND products.id NOT IN(SELECT * FROM archived_products)

/*GET PRODUCTS FROM A CATEGORY THAT ARE IN SPECIFIED PRICE RANGE*/
SELECT products.id,products.name,products.price FROM products WHERE category_id = $categoryId AND price < $maxPrice  AND products.id NOT IN(SELECT * FROM archived_products)
SELECT path FROM photos WHERE product_id = $productId;

/*SEARCH PRODUCTS DONE*/
SELECT * FROM products WHERE LOWER(products.name) LIKE $search AND products.id NOT IN(SELECT * FROM archived_products)


--Homepage product
SELECT name, price FROM products WHERE id = $prod_id 
	/* get also photos*/
 
--get isNavBar categories
SELECT id, name FROM categories WHERE is_navbar_category = TRUE

--get Categories product  - get simple product not archived 
SELECT P.id, P.name, P.price FROM products AS P WHERE category_id = $cat_id AND P.id NOT IN (SELECT product_id FROM archived_products)
SELECT path FROM photos WHERE product_id = $prod_id ORDER BY id LIMIT 1

/*get for each category (required properties-only x first) - get categories’ properties values NEED FIX*/
SELECT V.id, V.name FROM 
    values AS V JOIN values_lists AS VL JOIN category_properties AS CP 
     WHERE CP.is_required_property = true 
     LIMIT 5

--get info product page

    /* Get product*/
	SELECT name, price, score, brand FROM products WHERE id = $prod_id

     /*Get photos*/
     SELECT path FROM photos WHERE product_id = $prod_id

     /*Get properties*/
	SELECT V.name, P.name FROM values AS V, values_lists AS VL, category_properties AS CP, properties AS P 
    WHERE VL.product_id = $prod_id AND V.values_list_id = VL.id AND VL.category_property_id = CP.id AND CP.property_id = P.id

    /* Get reviews*/
	SELECT R.title, R.content, R.date, R.score, U.name FROM reviews AS R, users AS U WHERE R.user_id = U.id AND R.product_id = $prod_id  

--Get Wishlist
SELECT product_id FROM wishlists WHERE user_id = $user_id

--Get Cart
SELECT product_id, quantity FROM product_carts WHERE user_id = $user_id

--get Checkout
SELECT name,cost FROM delivery_types