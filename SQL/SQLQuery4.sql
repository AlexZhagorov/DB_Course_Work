USE [PizzaPlace]
GO
/****** Object:  Trigger [dbo].[addToGoodsCount]    Script Date: 10.02.2024 02:41:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[addToGoodsCount] ON [dbo].[GoodsToOrders]
INSTEAD OF INSERT
AS
if EXISTS (SELECT orderId, goodsId FROM GoodsToOrders WHERE orderId = (SELECT orderId FROM inserted) AND goodsId = (SELECT goodsId FROM inserted))
BEGIN
  UPDATE GoodsToOrders 
  SET [count] = [count] + (SELECT [count] FROM INSERTED)
  WHERE orderId = (SELECT orderId FROM inserted) AND goodsId = (SELECT goodsId FROM inserted)
END
ELSE
BEGIN
  INSERT INTO GoodsToOrders(orderId, goodsId, [count]) (SELECT orderId, goodsId, [count] FROM inserted)
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

INSERT INTO Logs([log]) VALUES ( FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss') + N' - Trigger work at insert into GoodsToOrders orderId: ' + 
STR((SELECT orderId FROM INSERTED)) + N', goodsId: ' + STR((SELECT goodsId FROM INSERTED)) + N', count: ' + STR((SELECT [count] 
FROM INSERTED)) + N', price of order: ' + STR((SELECT price FROM Orders WHERE id = (SELECT orderId FROM INSERTED))));