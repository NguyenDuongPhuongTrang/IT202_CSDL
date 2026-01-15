use social_network;

create table follows(
	follower_id int,
    followed_id int,
    
    primary key (follower_id, followed_id)
);

alter table users
add column following_count int default 0;

alter table users
add column followers_count int default 0;

create table follow_log (
    log_id int primary key auto_increment,
    follower_id int,
    followed_id int,
    error_message varchar(255),
    created_at timestamp default current_timestamp
);

delimiter //
create procedure sp_follow_user(p_follower_id int, p_followed_id int) proc:
begin
	-- kiểm tra có tự follow mình không
    if p_follower_id = p_followed_id then
		insert into follow_log(follower_id, followed_id, error_message)
        values(p_follower_id, p_followed_id, 'Không thể tự follow');
        leave proc;
	end if;
    
    -- kiểm tra tài khoản tồn tại không
    if not exists (select 1 from users where user_id = p_follower_id) then
		insert into follow_log(follower_id, followed_id, error_message)
        values(p_follower_id, p_followed_id, 'Tài khoản của Follower không tồn tại');
        leave proc;
	end if;
    
    if not exists (select 1 from users where user_id = p_followed_id) then
		insert into follow_log(follower_id, followed_id, error_message)
        values(p_follower_id, p_followed_id, 'Tài khoản của Followed không tồn tại');
        leave proc;
	end if;
    
    -- kiểm tra đã follow chưa
    if exists (select 1 from follows where follower_id = p_follower_id and followed_id = p_followed_id) then
		insert into follow_log(follower_id, followed_id, error_message)
        values(p_follower_id, p_followed_id, 'Đã follow');
        leave proc;
	end if;
    
    start transaction;
    
    -- kiểm tra hoàn tất
    -- thêm follow
    insert into follows
    values(p_follower_id, p_followed_id);
    
    update users
    set following_count = following_count + 1
    where user_id = p_follower_id;
    
    update users
    set followers_count = followers_count + 1
    where user_id = p_followed_id;
    
    commit;
end //
delimiter ;

insert into users(username)
values('sonbui'), ('kienvu'), ('tricong');

call sp_follow_user(2,1);
call sp_follow_user(3,5);
call sp_follow_user(5,3);
call sp_follow_user(3,3);
call sp_follow_user(2,1);

drop procedure sp_follow_user;

select * from users;
select * from posts;
select * from likes;
select * from follows;
select * from follow_log;
