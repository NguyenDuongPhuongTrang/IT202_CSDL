use ss06;

ALTER Table Orders
DROP totalAmount;

CREATE Table Products(
	productId INT primary key,
    productName VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    
    check (price > 0)
);

CREATE Table OrderItems(
	orderId INT,
    productId INT,
    quantity INT,
    
    primary key (orderId, productId),
    foreign key (orderId) references Orders(orderId),
    foreign key (productId) references Products(productId)    
);

INSERT INTO Products
VALUES
(001, 'Bút chì', 5),
(002, 'Bút bi', 10),
(003, 'Thước kẻ', 15),
(004, 'Máy tính', 20),
(005, 'Hộp bút', 25);

INSERT INTO OrderItems
VALUES
(101, 001, 2),
(101, 002, 1),
(102, 005, 3),
(103, 004, 2),
(105, 003, 4);

SELECT p.productId, p.productName, oi.quantity
FROM Products p
JOIN OrderItems oi ON p.productId = oi.productId;

SELECT p.productId, p.productName, sum(p.price * oi.quantity) as totalPrice
FROM Products p
JOIN OrderItems oi ON p.productId = oi.productId
GROUP BY p.productId
HAVING totalPrice > 10;



