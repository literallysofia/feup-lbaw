/*1 - GET ALL FAQS*/
SELECT * FROM faqs;

/*2 - SIGN IN*/

/*3 - SIGN UP*/

/*4 - USER INFO FOR PROFILE*/
SELECT name, username, email
FROM users
WHERE id = *LOGGED_USER_ID*

/*5 - GET USER ADRESSES*/
SELECT A.name, A.street, A.postal_code, CTY.name, CNTR.name
FROM users AS U, addresses AS A, cities AS CTY, countries AS CNTR
WHERE U.id = *LOGGED_USER_ID*,
A.user_id = U.id,
A.city_id = CTY.id,
CTY.country_id = CNTR.id

/*6 - GET OH HOLD USER PURCHASES*/


/*7 - GET FINISHED USER PURCHASES*/
