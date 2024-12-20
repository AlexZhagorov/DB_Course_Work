USE [PizzaPlace]
GO
/****** Object:  Trigger [dbo].[addToCouponCount]    Script Date: 10.02.2024 02:31:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[addToCouponCount] ON [dbo].[CouponsToOrders]
INSTEAD OF INSERT
AS
if (SELECT dateOfExpiration FROM Coupons WHERE id = (SELECT couponId FROM inserted)) < GETDATE()
	INSERT Logs
	VALUES(FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss') + N'Attempt to add an expired coupon to order.')
ELSE

BEGIN

if EXISTS (SELECT orderId, couponId FROM CouponsToOrders WHERE orderId = (SELECT orderId FROM inserted) AND couponId = (SELECT couponId FROM inserted))
BEGIN
  UPDATE CouponsToOrders 
  SET [count] = [count] + (SELECT [count] FROM INSERTED)
  WHERE orderId = (SELECT orderId FROM inserted) AND couponId = (SELECT couponId FROM inserted)
END
ELSE
BEGIN
  INSERT INTO CouponsToOrders(orderId, couponId, [count]) (SELECT orderId, couponId, [count] FROM inserted)
END;

DECLARE @orderIdToCalculate BIGINT;
DECLARE orderCursor CURSOR FOR SELECT DISTINCT orderId FROM inserted;
OPEN orderCursor;
FETCH NEXT FROM orderCursor INTO @orderIdToCalculate;
WHILE @@FETCH_STATUS = 0
BEGIN
     EXEC CalculateOrderPrice @orderIdToCalculate;
     FETCH NEXT FROM orderCursor INTO @orderIdToCalculate;
END;
CLOSE orderCursor;
DEALLOCATE orderCursor;

INSERT INTO Logs([log]) VALUES ( FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss') + N' - Trigger at insert into CouponsToOrders orderId: ' + 
STR((SELECT orderId FROM INSERTED)) + N', couponId: ' + STR((SELECT couponId FROM INSERTED)) + N', count: ' + STR((SELECT [count] 
FROM INSERTED)) + N', price of order: ' + STR((SELECT price FROM Orders WHERE id = (SELECT orderId FROM INSERTED))));

END;