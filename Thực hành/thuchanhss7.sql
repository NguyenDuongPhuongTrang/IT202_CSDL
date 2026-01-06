-- 1. Tạo Database
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- 2. Xóa bảng nếu đã tồn tại (để chạy lại nhiều lần)
DROP TABLE IF EXISTS CHI_TIET_DON_HANG;
DROP TABLE IF EXISTS DON_HANG;
DROP TABLE IF EXISTS SAN_PHAM;
DROP TABLE IF EXISTS KHACH_HANG;

-- 3. Tạo bảng KHACH_HANG
CREATE TABLE KHACH_HANG (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

-- 4. Tạo bảng SAN_PHAM
CREATE TABLE SAN_PHAM (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(12,2)
);

-- 5. Tạo bảng DON_HANG
CREATE TABLE DON_HANG (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES KHACH_HANG(customer_id)
);

-- 6. Tạo bảng CHI_TIET_DON_HANG
CREATE TABLE CHI_TIET_DON_HANG (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES DON_HANG(order_id),
    FOREIGN KEY (product_id) REFERENCES SAN_PHAM(product_id)
);

-- 7. Dữ liệu mẫu KHACH_HANG
INSERT INTO KHACH_HANG VALUES
(1, 'Nguyen Van A', 'Ha Noi'),
(2, 'Tran Thi B', 'Da Nang'),
(3, 'Le Van C', 'HCM'),
(4, 'Pham Thi D', 'Ha Noi'),
(5, 'Hoang Van E', 'Can Tho');

-- 8. Dữ liệu mẫu SAN_PHAM
INSERT INTO SAN_PHAM VALUES
(101, 'Laptop Dell', 'Electronics', 20000000),
(102, 'iPhone 14', 'Electronics', 25000000),
(103, 'Tai nghe Bluetooth', 'Accessories', 1500000),
(104, 'Ban phim co', 'Accessories', 2000000),
(105, 'Man hinh 27 inch', 'Electronics', 7000000),
(106, 'Chuot khong day', 'Accessories', 800000);

-- 9. Dữ liệu mẫu DON_HANG
INSERT INTO DON_HANG VALUES
(1001, 1, '2024-01-10'),
(1002, 2, '2024-01-12'),
(1003, 1, '2024-01-15'),
(1004, 3, '2024-01-18'),
(1005, 4, '2024-01-20'),
(1006, 5, '2024-01-22');

-- 10. Dữ liệu mẫu CHI_TIET_DON_HANG
INSERT INTO CHI_TIET_DON_HANG VALUES
(1001, 101, 1),
(1001, 103, 2),

(1002, 102, 1),

(1003, 104, 1),
(1003, 103, 1),

(1004, 101, 1),
(1004, 106, 2),

(1005, 105, 1),

(1006, 103, 3),
(1006, 106, 1);

SELECT * FROM CHI_TIET_DON_HANG;
SELECT * FROM DON_HANG;
SELECT * FROM KHACH_HANG;
SELECT * FROM SAN_PHAM;

-- Các sản phẩm có giá cao hơn mặt bằng chung
SELECT product_id, product_name FROM SAN_PHAM
WHERE price > (SELECT avg(price) FROM SAN_PHAM);

-- Các sản phẩm có số lượng bán ra thấp hơn mức trung bình
SELECT sp.product_id, sp.product_name, ct.quantity
FROM SAN_PHAM sp
JOIN CHI_TIET_DON_HANG ct ON ct.product_id = sp.product_id
WHERE ct.quantity < (SELECT avg(quantity) FROM CHI_TIET_DON_HANG);

-- Khách hàng có tổng chi tiêu cao hơn mức trung bình
SELECT 
    kh.customer_id,
    kh.customer_name,
    SUM(ct.quantity * sp.price) AS totalPrice
FROM KHACH_HANG kh
JOIN DON_HANG dh ON dh.customer_id = kh.customer_id
JOIN CHI_TIET_DON_HANG ct ON ct.order_id = dh.order_id
JOIN SAN_PHAM sp ON sp.product_id = ct.product_id
GROUP BY kh.customer_id, kh.customer_name
HAVING totalPrice > (
    SELECT AVG(totalPerCustomer)
    FROM (
        SELECT SUM(ct.quantity * sp.price) AS totalPerCustomer
        FROM KHACH_HANG kh
        JOIN DON_HANG dh ON dh.customer_id = kh.customer_id
        JOIN CHI_TIET_DON_HANG ct ON ct.order_id = dh.order_id
        JOIN SAN_PHAM sp ON sp.product_id = ct.product_id
        GROUP BY kh.customer_id
    ) t
);

-- Khách hàng chỉ mua các sản phẩm có giá cao
SELECT 
	kh.customer_id,
    kh.customer_name,
    sp.product_name,
    sp.price
FROM KHACH_HANG kh
JOIN DON_HANG dh ON dh.customer_id = kh.customer_id
JOIN CHI_TIET_DON_HANG ct ON ct.order_id = dh.order_id
JOIN SAN_PHAM sp ON sp.product_id = ct.product_id
WHERE price >= ANY (
		SELECT price FROM SAN_PHAM 
		WHERE price > (SELECT avg(price) FROM SAN_PHAM)
        );
