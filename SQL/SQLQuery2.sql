UPDATE Addresses
SET address = N'Беды 4'
WHERE id = 10006

SELECT * FROM Orders
DELETE FROM Users WHERE id = 28

INSERT INTO Addresses(address, entrance, number, userId)
VALUES('Беды 4', '3', '5', 1)

EXEC countPrices @orderId = 3