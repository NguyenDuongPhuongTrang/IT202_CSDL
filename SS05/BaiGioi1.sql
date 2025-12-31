use ss05;

CREATE Table orders (
    orderId int primary key auto_increment,
    customerId int not null,
    totalAmount decimal(10,2) not null,
    orderDate date not null,
    status enum('pending', 'completed', 'cancelled') not null
);

INSERT INTO orders (customerId, totalAmount, orderDate, status)
VALUES
(1, 1500000.00, '2024-10-01', 'completed'),
(2, 850000.00,  '2024-10-02', 'pending'),
(3, 3200000.00, '2024-10-03', 'completed'),
(1, 450000.00,  '2024-10-04', 'cancelled'),
(4, 1200000.00, '2024-10-05', 'pending'),
(5, 2750000.00, '2024-10-06', 'completed'),
(2, 990000.00,  '2024-10-07', 'completed'),
(6, 640000.00,  '2024-10-08', 'pending'),
(3, 1800000.00, '2024-10-09', 'completed'),
(7, 510000.00,  '2024-10-10', 'cancelled');

SELECT * FROM orders WHERE status = 'cancelled';
SELECT * FROM orders WHERE totalAmount > 5000000;

SELECT * FROM orders 
ORDER BY orderDate DESC
LIMIT 5;

SELECT * FROM orders WHERE status = 'cancelled' 
ORDER BY totalAmount DESC;
