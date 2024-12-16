ALTER PROCEDURE CalculateOrderPrice
    @orderId BIGINT
AS
BEGIN
	IF EXISTS (SELECT 1 FROM Orders WHERE id = @orderId)
	BEGIN
		DECLARE @productTotal MONEY;
		DECLARE @couponTotal MONEY;
		DECLARE @totalPrice MONEY;

		SELECT @productTotal = SUM(G.price * GO.[count])
		FROM GoodsToOrders GO
		INNER JOIN Goods G ON GO.goodsId = G.id
		WHERE GO.orderId = @orderId;

		SELECT @couponTotal = ISNULL(SUM(C.price * CO.[count]), 0)
		FROM CouponsToOrders CO
		INNER JOIN Coupons C ON CO.couponId = C.id
		WHERE CO.orderId = @orderId;

		SET @totalPrice = ISNULL(@productTotal, 0) + ISNULL(@couponTotal, 0);

		UPDATE Orders
		SET price = @totalPrice
		WHERE id = @orderId
	END
	ELSE
	BEGIN
		INSERT Logs
		VALUES(FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss') + N'- Order with id = ' + STR(@orderId) + N' is not found in db.')
	END
END
