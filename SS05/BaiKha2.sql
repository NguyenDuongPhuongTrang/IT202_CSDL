use ss05;

CREATE Table customers (
    customerId int primary key auto_increment,
    fullName varchar(255) not null,
    email varchar(255) not null unique,
    city varchar(255),
    status enum('active', 'inactive') not null default 'active'
);

INSERT INTO customers (fullName, email, city, status) 
VALUES
('Nguyễn Văn An', 'an.nguyen@gmail.com', 'Hà Nội', 'active'),
('Trần Thị Bình', 'binh.tran@gmail.com', 'TP.HCM', 'active'),
('Lê Quốc Cường', 'cuong.le@gmail.com', 'Đà Nẵng', 'active'),
('Phạm Minh Đức', 'duc.pham@gmail.com', 'Hải Phòng', 'inactive'),
('Hoàng Thu Hà', 'ha.hoang@gmail.com', 'Hà Nội', 'active'),
('Vũ Thanh Long', 'long.vu@gmail.com', 'TP.HCM', 'active'),
('Đỗ Ngọc Mai', 'mai.do@gmail.com', 'Nghệ An', 'inactive'),
('Bùi Anh Tuấn', 'tuan.bui@gmail.com', 'Hà Nội', 'inactive'),
('Phan Thị Lan', 'lan.phan@gmail.com', 'Huế', 'active'),
('Ngô Đức Huy', 'huy.ngo@gmail.com', 'Bình Dương', 'active');

SELECT * FROM customers;
SELECT * FROM customers WHERE city = 'TP.HCM';
SELECT * FROM customers WHERE city ='Hà Nội' and status = 'active';
SELECT * FROM customers ORDER BY fullName ASC;

