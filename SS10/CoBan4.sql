use social_network_pro;

-- 2) Tạo chỉ mục phức hợp (Composite Index)
-- Tạo một truy vấn để tìm tất cả các bài viết (posts) trong năm 2026 của người dùng có user_id là 1. 
-- Trả về các cột post_id, content, và created_at.
explain analyze
select post_id, content, created_at from posts
where user_id = 1;

-- Tạo chỉ mục phức hợp với tên idx_created_at_user_id trên bảng posts sử dụng các cột created_at và user_id.
create index idx_created_at_user_id
on posts(created_at, user_id);
-- Sử dụng EXPLAIN ANALYZE để kiểm tra kế hoạch thực thi của truy vấn trên trước và sau khi tạo chỉ mục idx_created_at_user_id. 
-- So sánh kết quả thực thi giữa hai lần này.
explain analyze
select post_id, content, created_at from posts
where user_id = 1;

-- 3) Tạo chỉ mục duy nhất (Unique Index)
-- Tạo một truy vấn để tìm tất cả các người dùng (users) có email là 'an@gmail.com'. Trả về các cột user_id, username, và email.
explain analyze
select user_id, username, email from users
where email = 'an@gmail.com';
-- -> Rows fetched before execution  (cost=0..0 rows=1) (actual time=0.0011..0.0012 rows=1 loops=1)\n'

-- Tạo chỉ mục duy nhất với tên idx_email trên cột email trong bảng users.
create index idx_email 
on users(email);
-- Sử dụng EXPLAIN ANALYZE để kiểm tra kế hoạch thực thi của truy vấn trên trước và sau khi tạo chỉ mục idx_email. 
explain analyze
select user_id, username, email from users
where email = 'an@gmail.com';
-- '-> Index lookup on users using idx_email (email=\'an@gmail.com\')  (cost=0.35 rows=1) (actual time=0.0827..0.0907 rows=1 loops=1)\n'

-- So sánh kết quả thực thi giữa hai lần này.
-- Trước khi tạo index: CSDL phải quét bảng để tìm email 'an@gmail.com' (dù dữ liệu ít nên thời gian rất nhỏ).
-- Sau khi tạo index idx_email: CSDL dùng Index Lookup, truy xuất trực tiếp bản ghi theo email, giảm chi phí và tối ưu truy vấn.

-- 4) Xóa chỉ mục
-- Xóa chỉ mục idx_created_at_user_id khỏi bảng posts.
drop index idx_created_at_user_id
on posts;
-- Xóa chỉ mục idx_email khỏi bảng users.
drop index idx_email
on users;