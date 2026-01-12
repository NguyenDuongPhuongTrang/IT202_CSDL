use social_network_pro;

delimiter //
create procedure CalculatePostLikes (in p_post_id int,
									 out total_likes int)
begin 
	select count(*) into total_likes
    from likes l
    where l.post_id = p_post_id;
end //
delimiter 

call CalculatePostLikes(102, @total);

select @total;

drop procedure if exists CalculatePostLikes;