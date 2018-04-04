| Query reference   | SELECT04                               |
| ----------------- | -------------------------------------- |
| Query description | User purchases of a certain type |
| Query frequency   | dozens per day                     |
```sql
SELECT PRCHS.id, PRCHS."date", PRCHS.status, PRCHS.total
FROM purchases AS PRCHS
WHERE PRCHS."user_id" = $id
AND PRCHS.status = $type;
```

| Query reference   | SELECT05                               |
| ----------------- | -------------------------------------- |
| Query description | Get purchase products |
| Query frequency   | dozens per day                     |
```sql
SELECT PRDCT.id, PRDCT.name, PP.price, PP.quantity
FROM purchases AS PRCHS, products AS PRDCT, product_purchases AS PP
WHERE PRCHS.id = $id
AND PP."purchase_id" = PRCHS.id
AND PP."product_id" = PRDCT.id;
```

| Query reference   | SELECT06                               |
| ----------------- | -------------------------------------- |
| Query description | Get purchase address |
| Query frequency   | dozens per day                     |
```sql
SELECT A.street, A."postal_code", CTY.name, CNTR.name
FROM purchases AS P, addresses AS A, cities AS CTY, countries AS CNTR
WHERE P.id = $id
AND P."address_id" = A.id
AND A."city_id" = CTY.id
AND CTY."country_id" = CNTR.id;
```

| Query reference   | SELECT07                               |
| ----------------- | -------------------------------------- |
| Query description | Get purchases from any user of a certain type |
| Query frequency   | dozens per day                     |
```sql
SELECT PRCHS.id, PRCHS."date", PRCHS.status, PRCHS.total, PRCHS.user_id
FROM users AS U, purchases AS PRCHS
WHERE PRCHS.status = $type;
```

| Query reference   | SELECT08                               |
| ----------------- | -------------------------------------- |
| Query description | Get purchase user name |
| Query frequency   | dozens per day                     |
```sql
SELECT users.username
FROM purchases
WHERE purchases.user_id = $userId;
```

| Query reference   | SELECT09                               |
| ----------------- | -------------------------------------- |
| Query description | Get properties |
| Query frequency   | dozens per day                     |
```sql
SELECT name
FROM properties;
```

| Query reference   | SELECT10                               |
| ----------------- | -------------------------------------- |
| Query description | Get all properties' names from each category |
| Query frequency   | dozens per day                     |
```sql
SELECT categories.id,categories.name
FROM categories;

SELECT category_properties.property_id,category_properties.is_required_property
FROM category_properties
WHERE category_id = $category_id;

SELECT name
FROM properties
WHERE properties.id = $id;
```

| Query reference   | SELECT11                               |
| ----------------- | -------------------------------------- |
| Query description | Get faqs |
| Query frequency   | units per day                     |
```sql
SELECT question,answer
FROM faqs;
```

| Query reference   | SELECT12                               |
| ----------------- | -------------------------------------- |
| Query description | Dropdown navigation admin |
| Query frequency   | dozens per day                     |
```sql
SELECT Categories.name
FROM categories AS Categories
WHERE  (SELECT COUNT(*)
       FROM products AS Products
       WHERE Products.category_id = Categories.id) > 1;
```

| Query reference   | SELECT13                               |
| ----------------- | -------------------------------------- |
| Query description | Get all products from category |
| Query frequency   | hundreds per day                     |
```sql
SELECT id
FROM categories
WHERE name = $categoryName;

SELECT products.id, products.name, products.price
FROM products 
WHERE category_id = $categoryId
AND products.id NOT IN(SELECT * FROM archived_products);
```

| Query reference   | SELECT14                               |
| ----------------- | -------------------------------------- |
| Query description | Get products from a category that are in specified price range |
| Query frequency   | hundreds per day                     |
```sql
SELECT products.id, products.name, products.price
FROM products
WHERE category_id = $categoryId
AND price < $maxPrice AND products.id NOT IN(SELECT * FROM archived_products);
```

| Query reference   | SELECT15                               |
| ----------------- | -------------------------------------- |
| Query description | Search products |
| Query frequency   | hundreds per day                     |
```sql
SELECT *
FROM products
WHERE LOWER(products.name) LIKE $search
AND products.id NOT IN(SELECT * FROM archived_products);
```

| Query reference   | SELECT16                               |
| ----------------- | -------------------------------------- |
| Query description | Homepage products |
| Query frequency   | hundreds per day                     |
```sql
SELECT name, price
FROM products
WHERE id = $prod_id;
```

| Query reference   | SELECT17                               |
| ----------------- | -------------------------------------- |
| Query description | Get isNavBar categories |
| Query frequency   | hundreds per day                     |
```sql
SELECT id, name
FROM categories
WHERE is_navbar_category = TRUE;
```

| Query reference   | SELECT18                               |
| ----------------- | -------------------------------------- |
| Query description | Get Categories product not archived
 |
| Query frequency   | hundreds per day                     |
```sql
SELECT P.id, P.name, P.price
FROM products AS P
WHERE category_id = $cat_id
AND P.id NOT IN (SELECT product_id FROM archived_products);

SELECT path
FROM photos
WHERE product_id = $prod_id
ORDER BY id
LIMIT 1;
```

| Query reference   | SELECT19                               |
| ----------------- | -------------------------------------- |
| Query description | Get for each category (required properties-only x first) - get categories’ properties values |
| Query frequency   | dozens per day                     |
```sql
SELECT V.id, V.name
FROM values AS V
JOIN values_lists AS VL
JOIN category_properties AS CP
WHERE CP.is_required_property = true
LIMIT 5;
```

| Query reference   | SELECT20                               |
| ----------------- | -------------------------------------- |
| Query description | Get Checkout |
| Query frequency   | hundreds per day                     |
```sql
SELECT name, cost
FROM delivery_types;
```

| Query reference   | SELECT21                               |
| ----------------- | -------------------------------------- |
| Query description | Get cart |
| Query frequency   | hundreds per day                     |
```sql
SELECT product_id, quantity
FROM product_carts
WHERE user_id = $user_id;
```

| Query reference   | SELECT22                               |
| ----------------- | -------------------------------------- |
| Query description | Get wishlist |
| Query frequency   | hundreds per day                     |
```sql
SELECT product_id
FROM wishlists
WHERE user_id = $user_id;
```

| Query reference   | SELECT23                               |
| ----------------- | -------------------------------------- |
| Query description | Get city and coutries |
| Query frequency   | units per day                     |
```sql
SELECT *
FROM countries;

SELECT name
FROM cities
WHERE country_id = $countryId;
```

| Query reference   | SELECT24                               |
| ----------------- | -------------------------------------- |
| Query description | Get product info for product page |
| Query frequency   | hundreds per day                     |
```sql
SELECT name, price, score, brand,quantity
FROM products
WHERE id = $prod_id;
```

| Query reference   | SELECT25                               |
| ----------------- | -------------------------------------- |
| Query description | Get photos of produc |
| Query frequency   | hundreds per day                     |
```sql
SELECT path
FROM photos
WHERE product_id = $prod_id;
```

| Query reference   | SELECT26                               |
| ----------------- | -------------------------------------- |
| Query description | Get properties of product |
| Query frequency   | hundreds per day                     |
```sql
SELECT V.name, P.name
FROM values AS V, values_lists AS VL, category_properties AS CP, properties AS P
WHERE VL.product_id = $prod_id
AND V.values_list_id = VL.id
AND VL.category_property_id = CP.id AND CP.property_id = P.id;
```

| Query reference   | SELECT27                               |
| ----------------- | -------------------------------------- |
| Query description | Get reviews |
| Query frequency   | hundreds per day                     |
```sql
SELECT R.title, R.content, R.date, R.score, U.name
FROM reviews AS R, users AS U
WHERE R.user_id = U.id AND R.product_id = $prod_id;
```