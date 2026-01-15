use social_network;

create table comments(
	comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp
);

alter table posts 
add column comments_count int default 0;

delimiter //
create procedure sp_post_comment(p_post_id int, p_user_id int, p_content text)
begin
	start transaction;
    insert into comments(post_id, user_id, content)
    values(p_post_id, p_user_id, p_content);
    savepoint after_insert;
    update posts
    set comments_count = comments_count + 1
    where post_id = p_post_id;
    if row_count() = 0 then -- row_count để đếm số dòng trả về sau câu lệnh sql ngày phía trước
		rollback to after_insert;
	end if;
    commit;
end //
delimiter ;

call sp_post_comment(2, 2, 'Bài học bổ ích');
call sp_post_comment(2, 1, 'Bài học hay');
call sp_post_comment(1, 2, 'Bài học bổ ích');

