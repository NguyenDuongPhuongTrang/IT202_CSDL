create database session8;
use session8;

create table customers(
	customerId int primary key,
    customerName varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(10) not null unique
);

create table categories(
	categoryId int primary key,
    categoryName varchar(255)
);

create table products(
	productId int primary key,
    productName varchar(255) not null unique,
	price decimal(10, 2) not null,
    categoryId int,
    
    check(price > 0),
    foreign key(categoryId) references categories(categoryId)
);

create table orders(
	orderId int primary key,
    customerId int,
    orderDate date,
    status enum("pending", "completed", "cancel") default("pending"),
    
    foreign key(customerId) references customers(customerId)
);

create table orderItems(
	orderItemId int primary key,
    orderId int,
    productId int,
    quantity int,
    
    foreign key(orderId) references orders(orderId),
    foreign key(productId) references products(productId),
    check(quantity > 0)
);

INSERT INTO customers (customerId, customerName, email, phone) VALUES
(1, 'Nguyen Van An', 'an.nguyen@gmail.com', '0901234567'),
(2, 'Tran Thi Binh', 'binh.tran@gmail.com', '0901234568'),
(3, 'Le Hoang Cuong', 'cuong.le@gmail.com', '0901234569'),
(4, 'Pham Minh Duc', 'duc.pham@gmail.com', '0901234570'),
(5, 'Vo Thi Hoa', 'hoa.vo@gmail.com', '0901234571'),
(6, 'Dang Quoc Huy', 'huy.dang@gmail.com', '0901234572'),
(7, 'Do Thanh Khang', 'khang.do@gmail.com', '0901234573'),
(8, 'Bui Thi Lan', 'lan.bui@gmail.com', '0901234574'),
(9, 'Nguyen Minh Nam', 'nam.nguyen@gmail.com', '0901234575'),
(10,'Tran Quoc Phong', 'phong.tran@gmail.com', '0901234576');

INSERT INTO categories (categoryId, categoryName) VALUES
(1, 'Điện tử'),
(2, 'Gia dụng'),
(3, 'Thời trang'),
(4, 'Thực phẩm'),
(5, 'Sách'),
(6, 'Đồ chơi'),
(7, 'Thể thao'),
(8, 'Mỹ phẩm'),
(9, 'Nội thất'),
(10, 'Văn phòng phẩm');

INSERT INTO products (productId, productName, price, categoryId) VALUES
(1, 'Dien thoai Samsung A15', 4500000.00, 1),
(2, 'Laptop Dell Inspiron', 18500000.00, 1),
(3, 'Noi com dien Sharp', 1200000.00, 2),
(4, 'May hut bui Panasonic', 3200000.00, 2),
(5, 'Ao thun nam', 250000.00, 3),
(6, 'Quan jean nu', 450000.00, 3),
(7, 'Sach lap trinh SQL', 180000.00, 5),
(8, 'Bong da the thao', 300000.00, 7),
(9, 'Son moi cao cap', 520000.00, 8),
(10, 'Ban lam viec go', 2500000.00, 9);

INSERT INTO orders (orderId, customerId, orderDate, status) VALUES
(1, 1, '2025-01-02', 'completed'),
(2, 1, '2025-01-05', 'completed'),
(3, 1, '2025-01-08', 'completed'),
(4, 1, '2025-01-12', 'pending'),
(5, 1, '2025-01-15', 'completed'),
(6, 1, '2025-01-18', 'cancel'),

(7, 2, '2025-01-03', 'completed'),
(8, 2, '2025-01-10', 'pending'),
(9, 2, '2025-01-20', 'completed'),
(10, 2, '2025-01-25', 'completed'),

(11, 3, '2025-01-06', 'completed'),
(12, 3, '2025-01-22', 'cancel'),

(13, 4, '2025-01-07', 'completed'),

(14, 5, '2025-01-09', 'completed'),
(15, 5, '2025-01-28', 'pending'),

(16, 6, '2025-01-11', 'completed'),

(17, 7, '2025-01-13', 'completed'),
(18, 7, '2025-01-26', 'completed'),

(19, 8, '2025-01-14', 'pending'),
(20, 8, '2025-01-30', 'completed');


INSERT INTO orderItems (orderItemId, orderId, productId, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 5, 2),
(3, 2, 2, 1),
(4, 2, 7, 3),
(5, 3, 3, 1),
(6, 3, 8, 2),
(7, 4, 4, 1),
(8, 4, 6, 2),
(9, 5, 9, 1),
(10, 6, 1, 2),
(11, 6, 10, 1),
(12, 7, 5, 3),
(13, 8, 7, 2),
(14, 8, 8, 1),
(15, 9, 2, 1),
(16, 9, 4, 1),
(17, 10, 3, 2),
(18, 11, 6, 1),
(19, 11, 9, 2),
(20, 12, 10, 1);

-- Lấy danh sách khách hàng, sản phẩm, đơn hàng
select * from customers;
select * from products;
select * from orders;

-- Thống kê số lượng đơn hàng
select c.customerId, c.customerName, count(o.orderId) from customers c
join orders o on o.customerId = c.customerId
group by c.customerId;

-- Thống kê số lượng sản phẩm bán ra
select count(*) from orders
where status = "completed";

-- Tìm sản phẩm có giá cao nhất, thấp nhất, trung bình
select * from products p
where p.price = (
	select max(p.price) from products p
);

select * from products p
where p.price = (
	select min(p.price) from products p
);

-- Tìm khách hàng mua nhiều đơn hàng
select c.*, count(o.orderId) from customers c
join orders o on o.customerId = c.customerId
group by c.customerId
having count(o.orderId) = (
	select max(totalOrder) from (
		select count(o.orderId) as totalOrder from orders o
        group by o.customerId
    ) as temp
);
  