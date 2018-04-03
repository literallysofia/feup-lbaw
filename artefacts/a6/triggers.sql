/*Quando faz um review da update ao score do product*/

CREATE FUNCTION update_product_score() RETURNS TRIGGER AS
$BODY$
BEGIN
	UPDATE products
	SET score = (AVG(score) FROM reviews WHERE product_id = New.product_id)
	WHERE product_id = New.product_id
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER product_score AFTER INSERT OR UPDATE OR DELETE
ON reviews
EXECUTE PROCEDURE update_product_score();

/*Quando insere uma review o user tem que ter comprado o produto - sofia*/


/*Quando adiciona uma compra a quantidade de cada produto não pode ser maior que a quantidade disponível do mesmo*/


/*Quando é adicionada uma compra limpa o cart do respetivo user*/


/*Se comprar um produto que está na wishlist remove-o da mesma*/


/*Quando existe uma compra diminui o numero de available products*/


/*Quando uma morada for arquivada e nao existirem compras associadas esta deve ser apagada*/


/*Quando um produto é arquivado se não tiver compras associadas deve ser apagado*/

/*Quando uma categoria não tem produtos esta nao pode estar na navbar*/

/*Quando um produto é arquivado este tem que ser removido de todas as wishlists e carts*/
