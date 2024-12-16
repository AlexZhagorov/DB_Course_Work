CREATE VIEW ReadableGoods
AS
SELECT Goods.id, Products.name, Products.ingredients, Goods.price, Goods.size
FROM Goods
JOIN Products ON Goods.productId = Products.id