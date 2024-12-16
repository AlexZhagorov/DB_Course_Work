CREATE TABLE Logs(
	id BIGINT PRIMARY KEY IDENTITY,
	log NCHAR(1000) NOT NULL
)

CREATE TABLE UserTypes(
	id BIGINT PRIMARY KEY IDENTITY,
	userType CHAR(3) NOT NULL UNIQUE
)

CREATE TABLE Users(
	id BIGINT PRIMARY KEY IDENTITY,
	first_name NCHAR(20) NOT NULL,
	last_name NCHAR(20) NOT NULL,
	password BIGINT NOT NULL,
	email NCHAR(100) NOT NULL UNIQUE,
	role CHAR(3) DEFAULT('usr') NOT NULL,
	phone CHAR(9) NOT NULL UNIQUE
)


CREATE TABLE Addresses(
	id BIGINT PRIMARY KEY IDENTITY,
	userId BIGINT REFERENCES Users(id),
	address NVARCHAR(200) NOT NULL,
	entrance NVARCHAR(10),
	number NCHAR(10)
)

CREATE INDEX AddressesByUsers ON Addresses(userId)

CREATE TABLE Products(
	id BIGINT PRIMARY KEY IDENTITY,
	name NCHAR(30) NOT NULL,
	type NCHAR(30) NOT NULL,
	ingredients NCHAR(100)
)

CREATE INDEX ProductsByType ON Products(type)

CREATE TABLE Coupons(
	id BIGINT PRIMARY KEY IDENTITY,
	number INT NOT NULL,
	price MONEY NOT NULL,
	dateOfStart DATE NOT NULL,
	dateOfExpiration DATE
)

CREATE INDEX CouponsByNumber ON Coupons(number) INCLUDE (dateOfStart)

CREATE TABLE Orders(
	id BIGINT PRIMARY KEY IDENTITY,
	userId BIGINT REFERENCES Users(id) NOT NULL,
	dateOfOrder DATETIME NOT NULL,
	dateOfDelivery DATETIME,
	price INT CHECK(price >=0),
	addressId BIGINT REFERENCES Addresses(id)
)

CREATE INDEX OrdersByUsers ON Orders(userId);

CREATE TABLE CouponsToOrders(
	orderId BIGINT REFERENCES Orders(id),
	couponId BIGINT REFERENCES Coupons(id),
	[count] INT DEFAULT(1)
)
CREATE INDEX CouponsInOrders ON CouponsToOrders(orderId)

CREATE TABLE Goods(
	id BIGINT PRIMARY KEY IDENTITY,
	productId BIGINT REFERENCES Products(id),
	price MONEY CHECK(price>=0),
	size CHAR(3)
)

CREATE INDEX GoodsByProduct ON Goods(productId)

CREATE TABLE GoodsToOrders(
	orderId BIGINT REFERENCES Orders(id),
	goodsId BIGINT REFERENCES Goods(id),
	[count] INT DEFAULT(1) NOT NULL
);
CREATE INDEX GoodsInOrders ON GoodsToOrders(orderId);

CREATE TABLE GoodsToCoupons(
	goodsId BIGINT REFERENCES Goods(id),
	couponId BIGINT REFERENCES Coupons(id),
	[count] INT DEFAULT(1)
);
CREATE INDEX GoodsInCoupons ON GoodsToCoupons(couponId);