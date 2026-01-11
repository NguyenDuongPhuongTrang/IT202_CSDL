use social_network_pro;

-- 2) Tạo một view tên view_user_post hiển thị danh sách các User với các cột: user_id(mã người dùng) và total_user_post (Tổng số bài viết mà từng người dùng đã đăng).
CREATE OR REPLACE VIEW view_user_post 
AS
SELECT user_id, count(post_id) as total_user_post
FROM posts
GROUP BY user_id;

-- 3) Hiển thị lại view_user_post để kiểm chứng
SELECT * FROM view_user_post ;

-- 4) Kết hợp view view_user_post với bảng users để hiển thị các cột: full_name(họ tên) và  total_user_post (Tổng số bài viết mà từng người dùng đã đăng).
SELECT u.full_name, v.total_user_post
FROM users u
JOIN view_user_post v ON v.user_id = u.user_id;

