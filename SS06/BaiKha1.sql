CREATE database ss06;
use ss06;

CREATE Table Customers (
    customerId int primary key,
    fullName VARCHAR(255) NOT NULL,
    city varchar(255)
);

CREATE Table Orders (
    orderId int primary key,
    customerId int,
    orderDate date NOT NULL,
    status ENUM('pending', 'completed', 'cancelled') NOT NULL,
    
    constraint fk_order_customer foreign key (customerId) references Customers(customerId)
);

INSERT INTO Customers
VALUES
(1, 'Nguyễn Văn An', 'Hà Nội'),
(2, 'Trần Thị Bình', 'TP.HCM'),
(3, 'Lê Quốc Cường', 'Đà Nẵng'),
(4, 'Phạm Minh Đức', 'Hải Phòng'),
(5, 'Hoàng Thu Hà', 'Cần Thơ');

INSERT INTO Orders
VALUES
(101, 1, '2024-10-01', 'completed'),
(102, 2, '2024-10-02', 'pending'),
(103, 3, '2024-10-03', 'completed'),
(104, 1, '2024-10-04', 'cancelled'),
(105, 4, '2024-10-05', 'pending');

SELECT o.orderId, c.fullName
FROM Orders o
JOIN Customers c ON c.customerId = o.customerId;

SELECT c.customerId, c.fullName, COUNT(o.orderId) as Total
FROM Orders o
JOIN Customers c ON c.customerId = o.customerId
GROUP BY c.customerId, c.fullName;

SELECT c.customerId, c.fullName, COUNT(o.orderId) as Total
FROM Orders o
JOIN Customers c ON c.customerId = o.customerId
GROUP BY c.customerId, c.fullName
HAVING Total >= 1;



