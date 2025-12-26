-- Tạo CSDL
CREATE database thuchanh;

-- Chọn CSDL
use thuchanh;

-- Tạo bảng
CREATE TABLE Category (
	categoryId char(10) PRIMARY KEY,
    categoryName VARCHAR(50) NOT NULL,
    status enum('true', 'false')
);

CREATE TABLE Product (
    productId CHAR(10) PRIMARY KEY,
    productName VARCHAR(25) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL default 0,
    manufactureDate DATE,
    description VARCHAR(255) NOT NULL,
    categoryId char(10),

    constraint fk_01 foreign key (categoryId) references Category(categoryId),
    constraint chk_01 check(price > 0),
    constraint chk_02 check(quantity >= 0)
);