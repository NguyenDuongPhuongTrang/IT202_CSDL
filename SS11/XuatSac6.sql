delimiter $$
create procedure NotifyFriendsOnNewPost(user_id_in int, content text)
begin
	declare v_friend_id int;
    declare done int default 0;
	declare notification_content varchar(255);

    -- Lấy danh sách bạn bè 
    declare friend_cursor cursor for 
		select 
			case 
				when f.user_id = user_id_in then f.friend_id
                else f.user_id
			end as friend_id
		from friends f
        where status = "accepted"
        and (f.user_id = user_id_in or f.friend_id = user_id_in);

	-- Fetch đến khi hết dữ liệu
	declare continue handler for not found set done = 1;

    -- Tạo nội dung thông báo 
    select full_name into notification_content from users
    where user_id = user_id_in;
    set notification_content = concat(notification_content, " đã thêm bài viết mới");

    -- Mở danh sách  
    open friend_cursor;
    -- Duyệt qua từng người 
    read_loop: loop
		-- Lấy id của từng người trong ds 
        fetch friend_cursor into v_friend_id;
        -- Kiểm tra nếu duyệt hết thì kết thúc 
		if done = 1 then leave read_loop;
		end if;

        -- Kiểm tra để không tự gửi cho chính mình 
        if v_friend_id <> user_id_in then
        -- Gửi thông báo 
			insert into notifications(user_id, type, content)
			values (v_friend_id, 'new_post', notification_content);
    end if;
    end loop;
    close friend_cursor;
end $$
delimiter ;