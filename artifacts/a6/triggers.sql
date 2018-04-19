/*Quando faz um review da update ao score do product*/

CREATE FUNCTION update_product_score() RETURNS TRIGGER AS
$BODY$
BEGIN
	UPDATE products
	SET score = (AVG(score) FROM reviews WHERE product_id = New.product_id)
	WHERE "product_id" = New."product_id"
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER product_score AFTER INSERT OR UPDATE OR DELETE
ON reviews
EXECUTE PROCEDURE update_product_score();

/*Quando insere uma review o user tem que ter comprado o produto - sofia*/


/*Quando adiciona uma compra a quantidade de cada produto não pode ser maior que a quantidade disponível do mesmo*/

CREATE FUNCTION check_purchases_quantities() RETURNS TRIGGER AS
$BODY$
BEGIN
	IF 
		NOT EXISTS (SELECT quantity_available FROM products WHERE id = New.product_id AND quantity_available >= New.quantity) 
	THEN
		RAISE EXCEPTION ’You can’t buy % items of product %’ , New.quantity, New.product_id
	END IF;
	RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER check_purchase_quantities BEFORE INSERT
ON product_purchases
FOR EACH ROW
EXECUTE PROCEDURE check_purchases_quantities();


/*Quando é adicionada uma compra limpa o cart do respetivo user*/
CREATE FUNCTION clear_cart() RETURNS TRIGGER AS
$BODY$
BEGIN
	DELETE FROM product_carts
	WHERE "user_id" = New."user_id"
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER clear_cart AFTER INSERT
ON purchases
EXECUTE PROCEDURE clear_cart();


/*Se adicionar ao cart um produto que está na wishlist remove-o da mesma*/
CREATE FUNCTION remove_wishlist_product() RETURNS TRIGGER AS
$BODY$
BEGIN
	DELETE FROM wishlist
	WHERE "user_id" = New."user_id"
  AND "product_id" = New."product_id"
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER remove_wishlist_product AFTER INSERT
ON product_carts
EXECUTE PROCEDURE remove_wishlist_product();

/*Quando existe uma compra diminui o numero de available products*/
CREATE FUNCTION update_available_products() RETURNS TRIGGER AS
$BODY$
BEGIN
  UPDATE products
  SET quantity = quantity - New.quantity
  WHERE "product_id" = New."product_id"
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_available_products AFTER INSERT
ON product_purchases
EXECUTE PROCEDURE update_available_products();

/*Quando uma morada for arquivada e nao existirem compras associadas esta deve ser apagada*/

/*Quando uma categoria não tem produtos esta nao pode estar na navbar*/

	/*quando coloca uma categoria como estando na navbar esta tem que ter produtos*/

	CREATE FUNCTION navbar_category() RETURN TRIGGER AS
	$BODY$OD
	BEGIN
		IF (New.is_navbar_category = TRUE) THEN
			IF NOT EXISTS (SELECT P.id FROM products AS P WHERE P.category_id = New.id) 
		THEN
			RAISE EXCEPTION ’A navbar category need to have products’
		END IF;
		RETURN NEW;
	END
	$BODY$
	LANGUAGE plpgsql;

	CREATE TRIGGER navbar_category BEFORE UPDATE
	ON categories
	FOR EACH ROW
	EXECUTE PROCEDURE navbar_category();

/*Quando um produto é arquivado este tem que ser removido de todas as wishlists e carts*/


CREATE FUNCTION archive_product() RETURN TRIGGER AS
$BODY$
BEGIN
	DELETE FROM whishlists
	WHERE product_id = NEW.id
	DELETE FROM product_carts
	WHERE product_id = NEW.id
	
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER archive_product AFTER INSERT
ON archived_products
FOR EACH ROW
EXECUTE PROCEDURE archive_product();

