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


/*Quando um produto é arquivado se não tiver compras associadas deve ser apagado*/
CREATE FUNCTION delete_product() RETURNS TRIGGER AS
$BODY$
BEGIN
  DELETE FROM products
  WHERE "product_id" = New."product_id"
  AND "product_id" NOT IN (SELECT "product_id" FROM product_purchases)
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER delete_product AFTER INSERT
ON archived_products
EXECUTE PROCEDURE delete_product();

/*Quando uma categoria não tem produtos esta nao pode estar na navbar*/

/*Quando um produto é arquivado este tem que ser removido de todas as wishlists e carts*/
