CREATE database ss05;
use ss05;

CREATE Table product (
    productId int primary key auto_increment,
    productName varchar(255) not null,
    price decimal(10,2) not null,
    stock int not null,
    status enum('active', 'inactive') not null default 'active'
);

INSERT INTO product (productName, price, stock, status) 
VALUES
('Bàn phím cơ', 850000.00, 50, 'active'),
('Chuột không dây', 320000.00, 120, 'active'),
('Màn hình 24 inch', 3200000.00, 25, 'active'),
('Tai nghe gaming', 650000.00, 60, 'active'),
('Laptop văn phòng', 12500000.00, 15, 'active'),
('USB 32GB', 150000.00, 200, 'active'),
('Ổ cứng SSD 512GB', 1800000.00, 40, 'active'),
('Webcam Full HD', 900000.00, 30, 'inactive'),
('Loa bluetooth', 720000.00, 70, 'active'),
('Bàn làm việc', 2100000.00, 10, 'inactive');

SELECT * FROM product;
SELECT * FROM product WHERE status = 'active';
SELECT * FROM product WHERE price > 1000000;
SELECT * FROM product WHERE status = 'active'
ORDER BY price ASC;

