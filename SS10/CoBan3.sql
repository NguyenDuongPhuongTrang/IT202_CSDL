use social_network_pro;

-- 2) Viết câu truy vấn Select tìm tất cả những User ở Hà Nội. Sử dụng EXPLAIN ANALYZE để kiểm tra truy vấn thực tế.
explain analyze
select * from users
where hometown = 'Ha Noi';

-- -> Filter: (users.hometown = \'Ha Noi\')  (cost=2.25 rows=2) (actual time=0.0717..0.103 rows=7 loops=1)\n    -> Table scan on users  (cost=2.25 rows=20) (actual time=0.0624..0.0888 rows=20 loops=1)\n'

-- 3) Tạo một chỉ mục có tên idx_hometown cho cột hometown của bảng User. 
create index idx_hometown
on users (hometown);

-- 4) Chạy lại yêu cầu số (2) với EXPLAIN ANALYZE để kiểm tra kết quả sau khi đánh chỉ mục . 
-- So sánh kết quả trước và sau khi đánh chỉ mục.
explain analyze
select * from users
where hometown = 'Ha Noi';

-- -> Index lookup on users using idx_hometown (hometown=\'Ha Noi\')  (cost=1.2 rows=7) (actual time=0.075..0.0884 rows=7 loops=1)\n'

-- Trước khi tạo index: CSDL phải quét toàn bộ bảng (Table Scan) rồi mới lọc hometown = 'Ha Noi', tốn tài nguyên và kém hiệu quả khi dữ liệu lớn.
-- Sau khi tạo index: CSDL dùng Index Lookup, truy xuất trực tiếp các bản ghi cần thiết, giảm số dòng quét và chi phí thực thi, truy vấn hiệu quả hơn.

-- 5) Hãy xóa chỉ mục idx_hometown khỏi bảng customers.
drop index idx_hometown
on users;
