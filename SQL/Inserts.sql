SELECT * FROM Orders
INSERT INTO Users(first_name, last_name, password, role, email, phone) VALUES
(N'Артем',N'Артемов', -765329698, 'USR', 'emptyemail1@gmail.com', '295553535'),
(N'Николай',N'Николаев', -765329698, 'USR', 'emptyemail2@gmail.com', '295553536'),
(N'Кирилл',N'Кириллов', -765329698, 'USR', 'emptyemail3@gmail.com', '295553537'),
(N'Алексей',N'Алексеев', -765329698, 'USR', 'emptyemail4@gmail.com', '295553538'),
(N'Мария',N'Марьевна', -765329698, 'USR', 'emptyemail1@mail.ru', '295553530'),
(N'Азамат',N'Куляев', -765329698, 'USR', 'emptyemail2@mail.com', '295553531'),
(N'Иоанн',N'Пицевич', -765329698, 'USR', 'scrrrraa@gmail.com', '295553532'),
(N'Юзер',N'Юзерович', -765329698, 'USR', 'trututut1@gmail.com', '295553533'),
(N'Лицо',N'Лицо', -765329698, 'USR', 'pampampam@gmail.com', '295553534'),
(N'Иосий',N'Фаляев', -765329698, 'USR', 'ss1488@gmail.com', '295553539'),
(N'Эдик',N'Алоизович', -765329698, 'USR', 'superhitler@gmail.com', '445553535'),
(N'Фима',N'Рабинович', -765329698, 'USR', 'hamasmustdie@gmail.com', '445553530'),
(N'Кал',N'Акар', -765329698, 'USR', 'kakovidnyi@gmail.com', '445553531'),
(N'Флопа',N'Котов', -765329698, 'USR', 'struy@gmail.com', '445553532'),
(N'Александр',N'Петров', -765329698, 'STF', 'tvoyamamasha@gmail.com', '445553533'),
(N'Jay-z',N'hater', -765329698, 'ADM', 'ye@gmail.com', '445553534')

INSERT INTO Products(name, type, ingredients) VALUES
(N'Карбонара', N'Пицца', N'карбонара, тесто, сыр'),
(N'Охотничья', N'Пицца', N'баварский колбаски сасасиски тесто'),
(N'Турецкая', N'Пицца',  N'Еврейские детишки, слезы гомосексуалистов, картошка, тесто для пиццы'),
(N'4 сыра', N'Пицца', N'сыр сыр сыр сыр тесто, сыр'),
(N'Якутская', N'Пицца', N'тесто'),

(N'Cocka-Cola', N'Напитки', N'Вы знаете'),
(N'Pensi', N'Напитки', N'Вы не знаете'),
(N'Fonta', N'Напитки', N'Фонта'),
(N'Sdrite', N'Напитки', N'Спрайт'),

(N'Набор вилок "Семейный"', N'Приборы', N'3 вилки'),
(N'Набор вилок "Волк"', N'Приборы', N'1 вилка'),

(N'Соус сальса', N'Соусы', N'соус сальса'),
(N'Соус от Педро', N'Соусы', N'1 вилка')

INSERT INTO Addresses (userId, address, entrance, number) VALUES
(1, N'Улица Пушкина Дом колотушкина', N'1', '1'),
(3, N'Улица Мечети Христовой 17', N'1', '1'),
(5, N'Улица Одесская д.34', N'5', '56'),
(7, N'Проспект лохматых 78', N'7', '1'),
(10, N'Улица Жилая', N'2', '34')

INSERT INTO Orders(userId, addressId, dateOfOrder, dateOfDelivery) VALUES
(1, 1, DATETIMEFROMPARTS(2023, 11, 8, 11, 29, 0 ,0), DATETIMEFROMPARTS(2023, 11, 8, 12, 0, 0 ,0)),
(4, 2, DATETIMEFROMPARTS(2023, 10, 8, 11, 29, 0 ,0), DATETIMEFROMPARTS(2023, 10, 8, 12, 0, 0 ,0)),
(3, 3, DATETIMEFROMPARTS(2023, 11, 8, 11, 17, 0 ,0), DATETIMEFROMPARTS(2023, 11, 8, 12, 0, 0 ,0)),
(3, 1, DATETIMEFROMPARTS(2023, 11, 6, 17, 29, 0 ,0), DATETIMEFROMPARTS(2023, 11, 6, 18, 0, 0 ,0)),
(5, 5, DATETIMEFROMPARTS(2023, 11, 7, 18, 29, 0 ,0), DATETIMEFROMPARTS(2023, 11, 8, 19, 29, 0 ,0)),
(6, 3, DATETIMEFROMPARTS(2023, 11, 1, 13, 0, 0 ,0), DATETIMEFROMPARTS(2023, 11, 1, 13, 30, 0 ,0)),
(8, 1, DATETIMEFROMPARTS(2023, 11, 8, 10, 29, 0 ,0), DATETIMEFROMPARTS(2023, 11, 8, 1, 0, 0 ,0))

INSERT INTO Coupons(number, price, dateOfStart, dateOfExpiration) VALUES
(1111, 20, DATEFROMPARTS(2023, 11, 1), DATEFROMPARTS(2023, 12,1)),
(2222, 20, DATEFROMPARTS(2023, 11, 1), DATEFROMPARTS(2023, 12,1)),
(3333, 20, DATEFROMPARTS(2023, 10, 1), DATEFROMPARTS(2024, 1,1)),
(4444, 20, DATEFROMPARTS(2023, 9, 1), DATEFROMPARTS(2023, 10,1)),
(5555, 20, DATEFROMPARTS(2023, 11, 1), DATEFROMPARTS(2023, 12,1))

INSERT INTO CouponsToOrders(orderId, couponId, [count]) VALUES
(3, 3, 10),
(4, 2, 10),
(5, 5, 30)

INSERT INTO Goods(productId, size, price) VALUES
(1, 'S', 10),
(1, 'M', 15),
(1, 'L', 17),
(2, 'S', 11),
(2, 'M', 16),
(4, 'L', 18),
(3, 'S', 10),
(3, 'M', 16),
(5, 'L', 7),
(6, 'M', 3),
(7, 'M', 3),
(8, 'M', 3),
(9, 'M', 3),
(10, NULL, 2),
(11, NULL, 1),
(12, 'S', 3),
(13, 'S', 3)

SELECT * FROM Orders
INSERT INTO GoodsToCoupons(couponId, goodsId, [count]) VALUES
(1, 2, 2),
(2, 4, 2),
(2, 11, 2),
(3, 12, 10),
(4, 7, 2),
(5, 9, 3),
(5,13,2);

INSERT INTO GoodsToOrders(orderId, goodsId, [count]) VALUES
(4, 7, 3),
(3, 11,3),
(3, 8,1),
(6, 2,1),
(8, 8,4);

