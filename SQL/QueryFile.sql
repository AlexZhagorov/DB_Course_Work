USE [PizzaPlace]
GO
/****** Object:  StoredProcedure [dbo].[CloseOrder]    Script Date: 04.01.2024 1:13:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CloseOrder] @orderId BIGINT
AS
UPDATE Orders 
SET Orders.dateOfDelivery = GETDATE()
WHERE Orders.id = @orderId
INSERT INTO Logs(log) VALUES(FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss') + N' - Order N' + STR(@orderId) + N' is closed')
