/*All faqs*/
/*units per day*/
SELECT question, answer FROM faqs;

/*Sign in*/
/*hundreds per day*/
SELECT id
FROM users
WHERE username = $username
AND password = $hashedPassword;

/*Sign in 2*/
/*hundreds per day*/
SELECT id
FROM users
WHERE email = $email
AND password = $hashedPassword;

/*Sign up*/
/*units per day*/
INSERT INTO users (name, username, email, password)
VALUES ($name, $username, $email, $hashedPassword);

/*User Info*/
/*thousands per day*/
SELECT name, username, email
FROM users
WHERE id = $id;

/*Update User Info*/
/*units per day*/
UPDATE users
SET name=$name, username=$username, email=$email, password=$hashedPassword
WHERE id=$id;

/*NOT TESTED*/
/*User Addresses*/
/*dozens per day*/
SELECT A.id, A.name, A.street, A."postal_code", CTY.name, CNTR.name
FROM addresses AS A, cities AS CTY, countries AS CNTR
WHERE A."user_id" = $id
AND A."city_id" = CTY.id
AND CTY."country_id" = CNTR.id
AND A.isArchived = false;

/*NOT TESTED*/
/*Update Archive Address*/
/*units per day*/
UPDATE addresses
SET isArchived=$isArchived
WHERE id=$id;

/*User Purchases of a Certain Type*/
/*dozens per day*/
SELECT PRCHS.id, PRCHS."date", PRCHS.status, PRCHS.total
FROM purchases AS PRCHS
WHERE PRCHS."user_id" = $id
AND PRCHS.status = $type;

/*Products of a purchase*/
/*dozens per day*/
SELECT PRDCT.id, PRDCT.name, PP.price, PP.quantity
FROM purchases AS PRCHS, products AS PRDCT, product_purchases AS PP
WHERE PRCHS.id = $id
AND PP."purchase_id" = PRCHS.id
AND PP."product_id" = PRDCT.id;

/*Address of a Purchase*/
/*dozens per day*/
SELECT A.street, A."postal_code", CTY.name, CNTR.name
FROM purchases AS P, addresses AS A, cities AS CTY, countries AS CNTR
WHERE P.id = $id
AND P."address_id" = A.id
AND A."city_id" = CTY.id
AND CTY."country_id" = CNTR.id;
