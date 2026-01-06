CREATE database ss07;
use ss07;

CREATE Table customers (
	customerId int primary key,
    customerName varchar(255) not null,
    email varchar(255) not null unique
);

CREATE Table orders(
	orderId int primary key,
    customerId int,
    orderDate date not null,
    totalAmount decimal(10,2),
    
    foreign key (customerId) references customers(customerId)
);

INSERT INTO customers
VALUES
(1, 'Nguyen Van An', 'an.nguyen@gmail.com'),
(2, 'Tran Thi Binh', 'binh.tran@gmail.com'),
(3, 'Le Van Cuong', 'cuong.le@gmail.com'),
(4, 'Pham Thi Dao', 'dao.pham@gmail.com'),
(5, 'Hoang Van Em', 'em.hoang@gmail.com'),
(6, 'Do Thi Giang', 'giang.do@gmail.com'),
(7, 'Vu Van Hung', 'hung.vu@gmail.com'),
(8, 'Bui Thi Lan', 'lan.bui@gmail.com'),
(9, 'Dang Van Minh', 'minh.dang@gmail.com'),
(10, 'Phan Thi Nhung', 'nhung.phan@gmail.com');

INSERT INTO orders (orderId, customerId, orderDate)
VALUES
(101, 1, '2025-01-05'),
(102, 2, '2025-01-06'),
(103, 3, '2025-01-07'),
(104, 1, '2025-01-08'),
(105, 4, '2025-01-09'),
(106, 5, '2025-01-10'),
(107, 6, '2025-01-11'),
(108, 7, '2025-01-12'),
(109, 8, '2025-01-13'),
(110, 9, '2025-01-14');

SELECT customerId, customerName FROM customers 
WHERE customerId IN (SELECT customerId FROM orders);


