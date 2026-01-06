use ss07;

CREATE Table products (
	productId int primary key,
    productName varchar(255) not null,
    price decimal(10,2)
);

CREATE Table orderItems(
	orderId int,
    productId int,
    quantity int not null,
    
    primary key (orderId, productId),
    foreign key (orderId) references orders(orderId),
    foreign key (productId) references products(productId)
);

INSERT INTO products 
VALUES
(1, 'Laptop Dell', 15000000.00),
(2, 'Chuột không dây', 350000.00),
(3, 'Bàn phím cơ', 1200000.00),
(4, 'Màn hình 24 inch', 4200000.00),
(5, 'Tai nghe Bluetooth', 950000.00),
(6, 'USB 64GB', 280000.00),
(7, 'Ổ cứng SSD 512GB', 2200000.00),
(8, 'Webcam HD', 750000.00),
(9, 'Loa Bluetooth', 1350000.00),
(10, 'Balo laptop', 650000.00);

INSERT INTO orderItems
VALUES
(101, 1, 1),
(101, 2, 2),
(102, 7, 1),
(102, 6, 3),
(103, 5, 1),
(104, 9, 1),
(105, 7, 2),
(106, 10, 1),
(107, 8, 1),
(108, 9, 2);

SELECT productId, productName 
FROM products
WHERE productId IN 
	(SELECT productId
	FROM orderItems);