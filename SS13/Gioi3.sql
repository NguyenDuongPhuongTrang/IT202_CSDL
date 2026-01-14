use ss13;

delimiter //
create trigger trigger_check_user_before_insert
before insert on likes
for each row
begin
	declare post_user_id int;
    
    select user_id into post_user_id from posts where post_id = new.post_id;
    
	if post_user_id = new.user_id then
		signal sqlstate '45000' set message_text = 'Không thể thích bài viết của chính mình';
	end if;
end //
delimiter ;

delimiter //
create trigger trigger_update_post_id
after update on likes
for each row
begin
	update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
    
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end //
delimiter ;

insert into likes(user_id, post_id, liked_at) values (1, 1, NOW());
insert into likes(user_id, post_id, liked_at) values (2, 2, NOW());

update likes
set post_id = 1
where like_id = 6;

delete from likes where like_id = 6;

select * from user_statistics;
select * from posts;
