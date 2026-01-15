create table delete_logs(
	log_id int primary key auto_increment,
	post_id int,
    deleted_at datetime,
    deleted_by int
);

delimiter $$
create procedure sp_delete_post(
	post_id_in int,
    user_id_in int
)
begin
	declare user_id_of_post int;
    declare p_count int;
    start transaction;
    -- Kiểm tra bài viết tồn tại
    select count(*) into p_count from posts
    where post_id = post_id_in;
    if p_count < 1 then
		rollback;
        signal sqlstate "45000" set message_text = "Đã xảy ra lỗi vui lòng thử lại";
	end if;
    -- Kiểm tra xem bài viết có thuộc về user_id_in không
    select user_id into user_id_of_post from posts
    where post_id = post_id_in;
	if user_id_in <> user_id_of_post then
		rollback;
        signal sqlstate "45000" set message_text = "Đã xảy ra lỗi vui lòng thử lại";
	end if;
    -- Delete từ bảng likes
    delete from likes
    where post_id = post_id_in;
    -- Delete từ bảng comments
    delete from comments
    where post_id = post_id_in;
    -- Delete từ bảng posts
    delete from posts
    where post_id = post_id_in;
    -- Update posts_count cho chủ bài viết
    update users
    set posts_count = posts_count - 1
    where user_id = user_id_in;
    -- Ghi logs
    insert into delete_logs(post_id, deleted_at, deleted_by)
    values(post_id_in, now(), user_id_in);
    commit;
end $$
delimiter ;

drop procedure sp_delete_post;

insert into posts(user_id, content) values(2, "tự học lập trình 3"); 

call sp_delete_post(1, 1);

select * from posts;
select * from delete_logs;
select * from users;
select * from posts;