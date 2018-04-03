/* INSERT FAQ   DONE*/
INSERT INTO faqs (question, answer)
VALUES ($question, $answer);

/* DROPDOWN NAVIGATION ADMIN    DONE*/
SELECT Categories.name
FROM categories AS Categories, 
WHERE  (SELECT COUNT(*)
        FROM products AS Products
        WHERE Products.category_id = Categories.id) > 1;

/* INSERT REVIEW  DONE*/
INSERT INTO reviews (score, title, content)
VALUES ($score, $title, $content)


CREATE FUNCTION add_review() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF NOT EXISTS (SELECT Product.product_id
                 FROM purchases AS Purchases, product_purchases AS Product, users AS Users
                 WHERE Purchases.id = Product.purchase_id AND New.user_id = Purchases.user_id
                 AND New.product_id = Product.product_id AND Users.id = *LOGGED_USER_ID*) THEN
        RAISE EXCEPTION 'You can not review a product you have not purchased.';
    END IF;
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
 
CREATE TRIGGER add_review
    BEFORE INSERT OR UPDATE ON review
        FOR EACH ROW
            EXECUTE PROCEDURE add_review();

/* ADD/EDIT PRODUCT */
/* INFO */
SELECT name, price, quantity_available, 
FROM products,
WHERE products.id = $id;

/* PHOTOS */
SELECT *
FROM photos AS Photos, products AS Products,
WHERE Photos."product_id" = Product.id;

INSERT INTO products (name, price, quantity_available, score)
VALUES ($name, $price, $quantity_available, $score);

