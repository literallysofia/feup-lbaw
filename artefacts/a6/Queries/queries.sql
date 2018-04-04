                           --USER RELATED QUERIES - SELECTORS

--get user info thousands per day
SELECT users.name, users.username, users.email
FROM users
WHERE id = $id;

--get user addresses dozens per day
SELECT A.id, A.name, A.street, A."postal_code", CTY.name, CNTR.name
FROM addresses AS A, cities AS CTY, countries AS CNTR
WHERE A."user_id" = $id
AND A."city_id" = CTY.id
AND CTY."country_id" = CNTR.id
AND A.isArchived = false;                           
                           
--sign in hundreds per day
SELECT id
FROM users
WHERE username = $username
AND password = $hashedPassword;

SELECT id
FROM users
WHERE email = $email
AND password = $hashedPassword;          

--User Purchases of a Certain Type dozens per day
SELECT PRCHS.id, PRCHS."date", PRCHS.status, PRCHS.total
FROM purchases AS PRCHS 
WHERE PRCHS."user_id" = $id 
AND PRCHS.status = $type; 

--get purchase products * dozens per day
SELECT PRDCT.id, PRDCT.name, PP.price, PP.quantity
FROM purchases AS PRCHS, products AS PRDCT, product_purchases AS PP,
WHERE PRCHS.id = $id
AND PP."purchase_id" = PRCHS.id
AND PP."product_id" = PRDCT.id;

--get purchase address * dozens per day
SELECT A.street, A."postal_code", CTY.name, CNTR.name
FROM purchases AS P, addresses AS A, cities AS CTY, countries AS CNTR
WHERE P.id = $id
AND P."address_id" = A.id
AND A."city_id" = CTY.id
AND CTY."country_id" = CNTR.id                
                           
                           

                           --ADMIN RELATED QUERIES SELECTORS

--get   purchases from any user from specific type (EXTREMELY SIMILAR TO THE ONE IN USER SECTION) dozens per day
SELECT PRCHS.id, PRCHS."date", PRCHS.status, PRCHS.total,PRCHS.user_id
FROM users AS U, purchases AS PRCHS
WHERE PRCHS.status =$type

--get purchase products dozens per day
    --*SEE IN USER SECTION

--get purchase address dozens per day
    --*SEE IN USER SECTION
    

--get purchase user name dozens per day
SELECT users.username FROM purchases WHERE purchases.user_id =$userId

--get properties dozens per day
SELECT name FROM properties

--GET ALL PROPERTIES NAMES FROM EACH CATEGORY dozens per day
SELECT categories.id,categories.name FROM categories
SELECT category_properties.property_id,category_properties.is_required_property
    FROM category_properties WHERE category_id =$category_id;
SELECT name FROM properties WHERE properties.id = $id;

--get faqs units per day
SELECT question,answer FROM faqs;      

-- DROPDOWN NAVIGATION ADMIN dozens per day
SELECT Categories.name
FROM categories AS Categories 
WHERE  (SELECT COUNT(*)
        FROM products AS Products
        WHERE Products.category_id = Categories.id) > 1;



                            --OTHER RELATED  QUERIES SELECTORS       

--get all products from category 
SELECT id FROM categories WHERE name=$categoryName; 
SELECT products.id,products.name,products.price FROM products WHERE category_id=$categoryId AND products.id NOT IN(SELECT * FROM archived_products)

--GET PRODUCTS FROM A CATEGORY THAT ARE IN SPECIFIED PRICE RANGE
SELECT products.id,products.name,products.price FROM products WHERE category_id = $categoryId AND price < $maxPrice  AND products.id NOT IN(SELECT * FROM archived_products)
  /*GET PHOTOS AS IS IN PRODUCT RELATED QUERIES*/

--SEARCH PRODUCTS --hundreds per day
SELECT * FROM products WHERE LOWER(products.name) LIKE $search AND products.id NOT IN(SELECT * FROM archived_products)

--Homepage product --hundreds per day
SELECT name, price FROM products WHERE id = $prod_id 
	/* get also photos*/
 
--get isNavBar categories --hundreds per day
SELECT id, name FROM categories WHERE is_navbar_category = TRUE

--get Categories product  - get simple product not archived 
SELECT P.id, P.name, P.price FROM products AS P WHERE category_id = $cat_id AND P.id NOT IN (SELECT product_id FROM archived_products)
SELECT path FROM photos WHERE product_id = $prod_id ORDER BY id LIMIT 1

/*get for each category (required properties-only x first) - get categories’ properties values NEED FIX*/
SELECT V.id, V.name FROM 
    values AS V JOIN values_lists AS VL JOIN category_properties AS CP 
     WHERE CP.is_required_property = true 
     LIMIT 5

--get Checkout dozens per day
SELECT name,cost FROM delivery_types

--get cart hundred per day
SELECT product_id, quantity FROM product_carts WHERE user_id = $user_id

--get wishlist hundreds per day
SELECT product_id FROM wishlists WHERE user_id = $user_id

--get city and coutries units per day
SELECT * FROM countries
SELECT name FROM cities WHERE country_id =$countryId

                            --PRODUCT RELATED  QUERIES SELECTOR
--get info product page

    -- Get product hundreds per day
	SELECT name, price, score, brand,quantity FROM products WHERE id = $prod_id

     --Get photos hundreds per day
    SELECT path FROM photos WHERE product_id = $prod_id

    --Get properties hundreds per day
	SELECT V.name, P.name FROM values AS V, values_lists AS VL, category_properties AS CP, properties AS P 
    WHERE VL.product_id = $prod_id AND V.values_list_id = VL.id AND VL.category_property_id = CP.id AND CP.property_id = P.id

    --Get reviews hundreds per day
	SELECT R.title, R.content, R.date, R.score, U.name FROM reviews AS R, users AS U WHERE R.user_id = U.id AND R.product_id = $prod_id 

    --get add/edit product page
    --get product units per month
       --*SAME as in info product page

    --get photos units per month
      --*SAME as in info product page
    
    --get properties units per month
        --*SAME as in info product page



                            --USER RELATED QUERIES UPDATES

--update user info units per day
UPDATE users
SET name=$name, username=$username, email=$email, password=$hashedPassword
WHERE id=$id;

--Update Archive Address units per day
UPDATE addresses
SET isArchived=$isArchived
WHERE id=$id;


                            --ADMIN RELATED QUERIES UPDATES

--UPDATE ON HOLD PURCHASE STATUS hundreds per day
UPDATE purchases SET status=$status WHERE purchase_id =$purchaseId


                            --OTHER RELATED QUERIES UPDATES

--Update product from cart quantity units per day
UPDATE product_carts SET quantity=$quantity WHERE product_id=$prodId AND user_id=$id;


                            --PRODUCT RELATED QUERIES UPDATES

--change products values units per month
UPDATE products SET name=$name,price=$price,quantity=$quantity,brand=$brand WHERE id=$id
UPDATE photos SET path=$pathname WHERE product_id=$prod_id
UPDATE "values" SET name=$name WHERE values_list_id IN (SELECT * FROM values_lists WHERE product_id=$product_id)


                            --USER RELATED QUERIES INSERTS

--Add address units per year
INSERT INTO addresses (name,street,postal_code,city_id,user_id) VALUES ($name,$street,$postal_code,$city_id,$id);

--sign up  units per day
INSERT INTO users (name, username, email, password)
VALUES ($name, $username, $email, $hashedPassword);

--insert review dozens per day
INSERT INTO reviews (user_id,product_id,score,title,content) VALUES ($userID,$productID,$score,$title,$content);       


                            --ADMIN RELATED QUERIES INSERTS         

--add property  dozens per year                    
INSERT INTO properties (name) VALUES ($name);

--add category units per year
INSERT INTO categories (name,is_navbar_category) VALUES ($name,$required)

--add category properties dozens per year
INSERT INTO category_properties (category_id,property_id) VALUES ($category_id,$property_id)

--insert new  faq units per year
INSERT INTO faqs (question,answer) VALUES ($question,$answer);

--delete product units per year
INSERT INTO archived_products(product_id) VALUES ($productId);

                           
                            --OTHER RELATED QUERIES INSERTS

--insert wishlist units per day
INSERT INTO wishlists (user_id,product_id) VALUES ($userid,$productid)

--insert new product to cart hundreds per day
INSERT INTO product_carts (product_id,user_id,quantity) VALUES ($proId,$id,$quantity)

--add purchase and products of that purchase dozens per day
INSERT INTO purchases (total,user_id,address_id) VALUES ($total,$userid,$address_id)
INSERT INTO product_purchases (product_id,purchase_id,quantity,price) VALUES ($proId,$purchId,$quantity,$price)


                            --PRODUCT RELATED QUERIES INSERTS

 --insert products units per month
INSERT INTO products (name,price,quantity_available,score,category_id,brand) VALUES ($name,$price,$quantity_available,$score,$category_id,$brand)
INSERT INTO photos (path,product_id) VALUES ($pathname,$proID)
INSERT INTO "values" (name,values_list_id) VALUES ($name,$values_list_id)


                            --USER RELATED QUERIES DELETES

--delete user review  dozens per day
DELETE FROM reviews where user_id=$user_id AND product_id=$product_id


                            --ADMIN RELATED QUERIES DELETES

--delete properties units per month
DELETE FROM properties WHERE properties.name = $name;

--delete faqs units per year
DELETE FROM faqs WHERE question=$question;


                            --OTHER RELATED QUERIES DELETES

-- delete product Wishlist units per day
DELETE FROM whishlist WHERE user_id=$user_id AND product_id=$product_id

--Remove Cart dozens per day
DELETE FROM product_carts WHERE product_id=$prodId AND user_id=$id;