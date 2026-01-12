use social_network_pro;

delimiter //
create procedure postList(p_user_id int)
begin 
	select p.post_id, p.content, p.created_at 
    from posts p
    where p.user_id = p_user_id;
end //
delimiter ;

call postList(1);

drop procedure if exists postList;