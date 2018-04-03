
/*UPDATE USER INFO (?) DONE*/
UPDATE users SET email = $email WHERE id = $id;
UPDATE users SET username=$username WHERE id = $id;
UPDATE users SET name=$name WHERE id = $id;
UPDATE users SET password = $password WHERE id=$id;


/*Add address DONE*/
INSERT INTO addresses (name,street,postal_code,city_id,user_id) VALUES ($name,$street,$postal_code,$city_id,$id);

/*Properties DONE*/
SELECT name FROM properties
INSERT INTO properties (name) VALUES ($name);

/*FAQS DONE*/
SELECT question,answer FROM faqs;
INSERT INTO faqs (question,answer) VALUES ($question,$answer);
DELETE FROM faqs WHERE answer=$answer;


/*GET ALL PROPERTIES NAMES FROM EACH CATEGORY DONE*/
SELECT categories.id,categories.name FROM categories
SELECT category_properties.property_id,category_properties.is_required_property
    FROM category_properties WHERE category_id =$category_id;
SELECT name FROM properties WHERE properties.id = $id;

/*GET ALL PRODUCTS FROM CATEGORY DONE*/
SELECT id FROM categories WHERE name=$categoryName;
SELECT products.id,products.name,products.price FROM products WHERE category_id=$categoryId

/*UPDATE ON HOLD PURCHASE STATUS DONE*/
UPDATE purchases SET status=$status WHERE purchase_id =$purchaseId

/*GET PRODUCT INFO  DONE*/
SELECT products.* FROM products;
SELECT path FROM photos WHERE product_id = $productId ORDER BY id LIMIT 1;

/*ADD PHOTO TO PRODUCT DONE*/
INSERT INTO photos(path,product_id) VALUES ($pathname,$productId);

/*GET TECH SPECS                            TODO*/
SELECT * FROM category_properties WHERE product_id =$productId;

/*GET PRODUCTS FROM A CATEGORY THAT ARE IN SPECIFIED PRICE RANGE DONE*/
SELECT products.id,products.name,products.price FROM products WHERE category_id = $categoryId AND price < $maxPrice
SELECT path FROM photos WHERE product_id = $productId;

/*REVIEWS DONE*/
INSERT INTO reviews (user_id,product_id,score,title,content) VALUES ($userID,$productID,$score,$title,$content);
DELETE FROM reviews where user_id=$user_id AND product_id=$product_id


/*SEARCH PRODUCTS DONE*/
SELECT * FROM products WHERE LOWER(products.name) LIKE $search AND products.id NOT IN(SELECT * FROM archived_products)

/**
SELECT * FROM values_lists WHERE category_property_id=$category_property_id
SELECT name FROM values WHERE values_list_id = $values_list_id;  */




/************************************LUIS**********************************/
/*Homepage product TESTED DONE*/
	

	SELECT name, price FROM products WHERE id = $prod_id 

	/* get also photos*/
/*get isNavBar categories TESTED DONE*/

	SELECT id, name FROM categories WHERE is_navbar_category = TRUE


/*get Categories product  - get simple product not archived DONE*/

	SELECT P.id, P.name, P.price FROM products AS P WHERE category_id = $cat_id AND P.id NOT IN (SELECT product_id FROM archived_products)

	SELECT path FROM photos WHERE product_id = $prod_id ORDER BY id LIMIT 1


/*get for each category (required properties-only x first) - get categories’ properties values DONE*/

	SELECT V.id, V.name FROM 
            values AS V JOIN values_lists AS VL JOIN category_properties AS CP 
            WHERE CP.is_required_property = true 
            LIMIT 5

/*get info product page DONE*/

    /* Get product*/
	SELECT name, price, score, brand FROM products WHERE id = $prod_id

     /*Get photos*/

	SELECT path FROM photos WHERE product_id = $prod_id

     /*Get properties*/

	SELECT V.name, P.name FROM values AS V, values_lists AS VL, category_properties AS CP, properties AS P 
    WHERE VL.product_id = $prod_id AND V.values_list_id = VL.id AND VL.category_property_id = CP.id AND CP.property_id = P.id

    /* Get reviews*/
	
	SELECT R.title, R.content, R.date, R.score, U.name FROM reviews AS R, users AS U WHERE R.user_id = U.id AND R.product_id = $prod_id  
	

/*Get Wishlist DONE*/
	
	SELECT product_id FROM wishlists WHERE user_id = $user_id

/*Get Cart DONE*/

	SELECT product_id, quantity FROM product_carts WHERE user_id = $user_id

/*GET Checkout DONE*/
	SELECT name,cost FROM delivery_types