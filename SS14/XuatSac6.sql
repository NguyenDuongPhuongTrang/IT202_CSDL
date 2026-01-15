create table friend_requests(
	request_id int primary key auto_increment,
    from_user_id int,
    to_user_id int,
    status enum("pending", "accepted", "rejected") default "pending",
	
    foreign key(from_user_id) references users(user_id),
    foreign key(to_user_id) references users(user_id)
);

create table friends(
	user_id int,
    friend_id int,
    
    primary key(user_id, friend_id),
    foreign key(user_id) references users(user_id),
    foreign key(friend_id) references users(user_id)
);

alter table users
add column friends_count int default 0;

delimiter $$
create procedure sp_accept_friend_request(
	request_id_in int,
    to_user_id_in int
)
begin
	declare count_check int;
    declare stauts_temp varchar(20);
    declare to_user_id_temp int;
    declare from_user_id_temp int;
    
	start transaction;
    -- Kiểm tra request tồn tại
    select count(*) into count_check from friend_requests
    where request_id = request_id_in;
    
    if count_check < 1 then
		rollback;
		signal sqlstate "45000" set message_text = "Request không tồn tại";
    end if;
    
    -- Kiểm tra xem accept đúng người chưa
    select to_user_id into to_user_id_temp from friend_requests
	where request_id = request_id_in;
    
    if to_user_id_in <> to_user_id_temp then
		rollback;
		signal sqlstate "45000" set message_text = "Đã xảy ra lỗi";
	end if;
    
    /* Kiểm tra xem đã là bạn bè trước đó chưa
    nếu là bạn bè trước đó thì rollback*/
    select from_user_id into from_user_id_temp from friend_requests
    where request_id = request_id_in;
    
    select count(*) into count_check from friends
    where (user_id = from_user_id_temp and friend_id = to_user_id_in)
    or (user_id = to_user_id_in and friend_id = from_user_id_temp);
    
    if count_check > 0 then 
		rollback;
        signal sqlstate "45000" set message_text = "Đã là bạn bè trước đó";
	end if;
    
    -- Kiểm tra status của request phải là pending
    select status into stauts_temp from friend_requests
	where request_id = request_id_in;
    
    if stauts_temp <> "pending" then
		rollback;
        signal sqlstate "45000" set message_text = "Đã xảy ra lỗi";
	end if;
    
    -- Inser vào friend
    insert into friends(user_id, friend_id) values(from_user_id_temp, to_user_id_in);
    insert into friends(user_id, friend_id) values(to_user_id_in, from_user_id_temp);
    
    -- Update friend count cho cả 2 user
    update users
    set friends_count = friends_count + 1
    where user_id = from_user_id_temp;
    
    update users
    set friends_count = friends_count + 1
    where user_id = to_user_id_in;
    
    -- Update friend request
    update friend_requests
    set status = "accepted"
    where request_id = request_id_in;
    commit;
end $$
delimiter ;

drop procedure sp_accept_friend_request;

select * from users;
select * from friend_requests;
select * from friends;

insert into friend_requests(from_user_id, to_user_id) values(1, 2);

call sp_accept_friend_request(1, 2);

