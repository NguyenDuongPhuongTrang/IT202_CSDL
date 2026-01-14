create table friendships(
	follower_id int,
    followee_id int,
    status enum("pending", "accepted"),
    
    primary key(follower_id, followee_id),
    foreign key(follower_id) references users(user_id),
    foreign key(followee_id) references users(user_id)
);

-- Trigger sau khi insert  friendships
delimiter $$
create trigger triggerAfterInsertFriendships
after insert on friendships
for each row
begin
	declare follow_number int default 0;
	-- Đếm số lượng follow 
    select count(*) into follow_number from friendships
    where followee_id = new.followee_id;
    -- Cập nhật lại
	update users
    set follower_count = follow_number
    where user_id = new.followee_id;
end $$
delimiter ;

-- Trigger sau khi xóa theo dõi
delimiter $$
create trigger triggerAfterDeleteFriendships
after delete on friendships
for each row
begin
	update users
    set follower_count = follower_count - 1
    where user_id = old.followee_id;
end $$
delimiter ; 

drop trigger triggerAfterInsertFriendships;
drop trigger triggerAfterDeleteFriendships;

insert friendships(follower_id, followee_id, status) values
("1", "2", "accepted"),
("3", "1", "accepted");

delete from friendships
where follower_id = 3 and followee_id = 1;

select * from users;
