-- Процедура авторизации

USE [PizzaPlace]
GO

CREATE PROCEDURE authorizate
	@email NCHAR(100),
	@password BIGINT
AS
SELECT [id] FROM [dbo].[Users]
WHERE [email]=@email AND [password]=@password

GO

-- Процедура регистрации

USE [PizzaPlace]
GO

CREATE PROCEDURE registrate
	@email NCHAR(100),
    @phone CHAR(9),
	@password BIGINT,
    @type CHAR(3)
AS
BEGIN
DECLARE @userTypeId BIGINT;
SET @userTypeId = (
    SELECT [id] FROM [dbo].[UserTypes]
    WHERE [userType]=@type
    ); 
INSERT INTO [dbo].[Users]
           ([first_name]
           ,[last_name]
           ,[email]
           ,[phone]
           ,[password]
           ,[userTypeId])
     VALUES
           ('Имя'
           ,'Фамилия'
           ,@email
           ,@phone
           ,@password
           ,@userTypeId);
END;

GO

-- Процедура получения пользователя по идентификатору

USE [PizzaPlace]
GO

CREATE PROCEDURE get_user
	@id BIGINT
AS
SELECT [Users].[id]
      ,[first_name]
      ,[last_name]
      ,[email]
      ,[userType]
      ,[phone] FROM [dbo].[Users]
    INNER JOIN [dbo].[UserTypes]
	ON [UserTypes].[id]=[Users].[userTypeId]
WHERE [Users].[id]=@id

GO

-- Процедура получения адреса пользователя по идентификатору

USE [PizzaPlace]
GO

CREATE PROCEDURE get_address
	@id BIGINT
AS
SELECT [id]
    ,[address]
    ,[entrance]
    ,[number] FROM [dbo].[Addresses]
WHERE [userId]=@id

GO

-- Процедура получения каталога еды

USE [PizzaPlace]
GO

CREATE PROCEDURE get_catalog
AS
SELECT [Goods].[id],
	[price],
	[size],
	[name],
	[type],
	[ingredients]
	FROM [dbo].[Goods] 
	INNER JOIN [dbo].[FoodType]
	ON [FoodType].[id]=[Goods].[foodTypeId]

GO

-- Процедура получения заказов пользователя

USE [PizzaPlace]
GO

CREATE PROCEDURE get_myorders
	@userId BIGINT
AS
SELECT [Orders].[id],
	[userId],
	[dateOfOrder],
	[dateOfDelivery],
	[Orders].[price],
	[addressId],
	[count],
	[size],
	[Goods].[price],
	[name],
	[type]
	FROM [dbo].[Orders]
	INNER JOIN [dbo].[GoodsToOrders]
	ON [Orders].[id]=[GoodsToOrders].[orderId]
	INNER JOIN [dbo].[Goods]
	ON [Goods].[id]=[GoodsToOrders].[goodsId]
	INNER JOIN [dbo].[FoodType]
	ON [FoodType].[id]=[Goods].[foodTypeId]
WHERE [userId]=@userId

GO

-- Процедура получения отзывов пользователя

USE [PizzaPlace]
GO

CREATE PROCEDURE get_feedbacks
	@userId BIGINT
AS
SELECT [id]
    ,[userId]
    ,[comment]
    ,[grade]
    ,[dateOfComment]
    FROM [dbo].[Feedbacks]
WHERE [userId]=@userId

GO

-- Процедура получения пользователей

USE [PizzaPlace]
GO

CREATE PROCEDURE get_users
AS
SELECT [Users].[id]
      ,[first_name]
      ,[last_name]
      ,[email]
      ,[userType]
      ,[phone]
      ,[address]
      ,[entrance]
      ,[number]
    FROM [dbo].[Users]
    INNER JOIN [dbo].[UserTypes]
	ON [UserTypes].[id]=[Users].[userTypeId]
    LEFT JOIN [dbo].[Addresses]
	ON [Addresses].[userId]=[Users].[id]

GO

-- Процедура получения еды

USE [PizzaPlace]
GO

CREATE PROCEDURE get_food
AS
SELECT [id],
	[name],
	[type],
	[ingredients]
	FROM [dbo].[FoodType]

GO

-- Процедура получения товаров

USE [PizzaPlace]
GO

CREATE PROCEDURE get_goods
AS
SELECT [Goods].[id],
    [foodTypeId],
	[price],
	[size],
	[name]
	FROM [dbo].[Goods] 
	INNER JOIN [dbo].[FoodType]
	ON [FoodType].[id]=[Goods].[foodTypeId]

GO

-- Процедура получения купонов

USE [PizzaPlace]
GO

CREATE PROCEDURE get_coupons
AS
SELECT [Coupons].[id],
	[number],
	[price],
	[dateOfStart],
    [dateOfExpiration],
    [goodsId],
    [orderId],
    [CouponsToGoods].[count],
    [CouponsToOrders].[count]
	FROM [dbo].[Coupons] 
	LEFT JOIN [dbo].[CouponsToGoods]
	ON [Coupons].[id]=[CouponsToGoods].[couponId]
    LEFT JOIN [dbo].[CouponsToOrders]
	ON [Coupons].[id]=[CouponsToOrders].[couponId]

GO

-- Процедура получения журнала

USE [PizzaPlace]
GO

CREATE PROCEDURE get_log
AS
SELECT [id],
    [log]
	FROM [dbo].[Logs] 

GO

USE [PizzaPlace]
GO

-- Процедура получения адресов

USE [PizzaPlace]
GO

CREATE PROCEDURE get_addresses
AS
SELECT [Users].[id],
	[phone],
	[address],
	[entrance],
	[number]
	FROM [dbo].[Users]
	INNER JOIN [dbo].[Addresses]
	ON [Addresses].[userId]=[Users].[id]

GO

-- Процедура получения заказов пользователя

USE [PizzaPlace]
GO

CREATE PROCEDURE get_orders
AS
SELECT [Orders].[id],
	[userId],
	[dateOfOrder],
	[dateOfDelivery],
	[Orders].[price],
	[addressId],
	[count],
	[size],
	[Goods].[price],
	[name],
	[type]
	FROM [dbo].[Orders]
	INNER JOIN [dbo].[GoodsToOrders]
	ON [Orders].[id]=[GoodsToOrders].[orderId]
	INNER JOIN [dbo].[Goods]
	ON [Goods].[id]=[GoodsToOrders].[goodsId]
	INNER JOIN [dbo].[FoodType]
	ON [FoodType].[id]=[Goods].[foodTypeId]

GO

-- Процедура обновления персональной информации

USE [PizzaPlace]
GO

CREATE PROCEDURE update_info
    @id BIGINT,
    @first_name NCHAR(20),
    @last_name NCHAR(20),
    @email NCHAR(100),
    @phone CHAR(9),
	@address NVARCHAR(200),
	@entrance NVARCHAR(10),
    @number NCHAR(10)
AS
BEGIN
    UPDATE [dbo].[Addresses]
        SET [address]=@address,
                [entrance]=@entrance,
                [number]=@number
    WHERE [userId]=@id;
    UPDATE [dbo].[Users]
        SET [first_name]=@first_name,
                [last_name]=@last_name,
                [email]=@email,
                [phone]=@phone
    WHERE [id]=@id;
END

GO

-- Процедура добавления отзыва

USE [PizzaPlace]
GO

CREATE PROCEDURE add_feedbacks
    @id BIGINT,
    @comment NVARCHAR(200),
    @grade INT
AS
INSERT INTO [dbo].[Feedbacks] VALUES
    (@id, @comment, @grade, GETDATE())

GO

-- Процедура добавления товара

USE [PizzaPlace]
GO

CREATE PROCEDURE add_goods
    @foodTypeId BIGINT,
    @price MONEY,
    @size CHAR(3)
AS
INSERT INTO [dbo].[Goods] VALUES
    (@foodTypeId, @price, @size)

GO

-- Процедура добавления еды

USE [PizzaPlace]
GO

CREATE PROCEDURE add_food
    @name NCHAR(30),
    @type NCHAR(30),
    @ingredients NCHAR(100)
AS
INSERT INTO [dbo].[FoodType] VALUES
    (@name, @type, @ingredients)

GO

-- Процедура добавления купона

USE [PizzaPlace]
GO

CREATE PROCEDURE add_coupons
    @number INT,
    @price MONEY,
    @dateOfStart DATE,
    @dateOfExpiration DATE,
    @goodsId BIGINT,
    @orderId BIGINT,
    @countGoods INT,
    @countOrder INT
AS
BEGIN
    INSERT INTO [dbo].[Coupons] VALUES
        (@number, @price, @dateOfStart, @dateOfExpiration);
    INSERT INTO [dbo].[CouponsToGoods] VALUES
        (@goodsId, (SELECT MAX([id]) FROM [dbo].[Coupons]), @countGoods);
    INSERT INTO [dbo].[CouponsToOrders] VALUES
        (@orderId, (SELECT MAX([id]) FROM [dbo].[Coupons]), @countOrder);
END

GO

-- Процедура обновления отзыва

USE [PizzaPlace]
GO

CREATE PROCEDURE update_feedbacks
    @id BIGINT,
    @userId BIGINT,
    @comment NVARCHAR(200),
    @grade INT
AS
UPDATE [dbo].[Feedbacks] SET
    [userId]=@userId, [comment]=@comment, [grade]=@grade
    WHERE [id]=@id;

GO

-- Процедура обновления товара

USE [PizzaPlace]
GO

CREATE PROCEDURE update_goods
    @id BIGINT,
    @foodTypeId BIGINT,
    @price MONEY,
    @size CHAR(3)
AS
UPDATE [dbo].[Goods] SET
    [foodTypeId]=@foodTypeId, [price]=@price, [size]=@size
    WHERE [id]=@id;

GO

-- Процедура обновления еды

USE [PizzaPlace]
GO

CREATE PROCEDURE update_food
    @id BIGINT,
    @name NCHAR(30),
    @type NCHAR(30),
    @ingredients NCHAR(100)
AS
UPDATE [dbo].[FoodType] SET
    [name]=@name, [type]=@type, [ingredients]=@ingredients
    WHERE [id]=@id;

GO

-- Процедура обновления купона

USE [PizzaPlace]
GO

CREATE PROCEDURE update_coupons
    @id BIGINT,
    @number INT,
    @price MONEY,
    @dateOfStart DATE,
    @dateOfExpiration DATE,
    @goodsId BIGINT,
    @orderId BIGINT,
    @countGoods INT,
    @countOrder INT
AS
BEGIN
    UPDATE [dbo].[Coupons] SET
        [number]=@number, [price]=@price, [dateOfStart]=@dateOfStart, [dateOfExpiration]=@dateOfExpiration
        WHERE [id]=@id;
    UPDATE [dbo].[CouponsToGoods] SET
        [goodsId]=@goodsId, [count]=@countGoods
        WHERE [couponId]=@id;
    UPDATE [dbo].[CouponsToOrders] SET
        [orderId]=@orderId, [count]=@countOrder
        WHERE [couponId]=@id;
END

GO

-- Процедура удаления отзыва

USE [PizzaPlace]
GO

CREATE PROCEDURE delete_feedbacks
    @id BIGINT
AS
DELETE FROM [dbo].[Feedbacks]
    WHERE [id]=@id;

GO

-- Процедура удаления товара

USE [PizzaPlace]
GO

CREATE PROCEDURE delete_goods
    @id BIGINT
AS
DELETE FROM [dbo].[Goods]
    WHERE [id]=@id;

GO

-- Процедура удаления еды

USE [PizzaPlace]
GO

CREATE PROCEDURE delete_food
    @id BIGINT
AS
DELETE FROM [dbo].[FoodType]
    WHERE [id]=@id;

GO

-- Процедура удаления купона

USE [PizzaPlace]
GO

CREATE PROCEDURE delete_coupons
    @id BIGINT
AS
BEGIN
    DELETE FROM [dbo].[Coupons]
        WHERE [id]=@id;
    DELETE FROM [dbo].[CouponsToGoods]
        WHERE [couponId]=@id;
    DELETE FROM [dbo].[CouponsToOrders]
        WHERE [couponId]=@id;
END

GO

-- Триггер на отзыв

USE [PizzaPlace]
GO

CREATE TRIGGER feedbacks_trigger
ON [dbo].[Feedbacks]
AFTER DELETE, UPDATE, INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted) AND EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('deleted ', [userId], ' ', [comment], ' ', [grade], ' ', [dateOfComment]) FROM deleted));
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('inserted ', [userId], ' ', [comment], ' ', [grade], ' ', [dateOfComment]) FROM inserted));
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('deleted ', [userId], ' ', [comment], ' ', [grade], ' ', [dateOfComment]) FROM deleted));
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('inserted ', [userId], ' ', [comment], ' ', [grade], ' ', [dateOfComment]) FROM inserted));
    END
END;

GO

-- Триггер на товар

USE [PizzaPlace]
GO

CREATE TRIGGER goods_trigger
ON [dbo].[Goods]
AFTER DELETE, UPDATE, INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted) AND EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('deleted ', [foodTypeId], ' ', [price], ' ', [size]) FROM deleted));
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('inserted ', [foodTypeId], ' ', [price], ' ', [size]) FROM inserted));
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('deleted ', [foodTypeId], ' ', [price], ' ', [size]) FROM deleted));
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('inserted ', [foodTypeId], ' ', [price], ' ', [size]) FROM inserted));
    END
END;

GO

-- Триггер на еду

USE [PizzaPlace]
GO

CREATE TRIGGER foodtype_trigger
ON [dbo].[FoodType]
AFTER DELETE, UPDATE, INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM deleted) AND EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('deleted ', [name], ' ', [type], ' ', [ingredients]) FROM deleted));
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('inserted ', [name], ' ', [type], ' ', [ingredients]) FROM inserted));
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('deleted ', [name], ' ', [type], ' ', [ingredients]) FROM deleted));
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO [dbo].[Logs] VALUES ((SELECT CONCAT('inserted ', [name], ' ', [type], ' ', [ingredients]) FROM inserted));
    END
END;

GO
