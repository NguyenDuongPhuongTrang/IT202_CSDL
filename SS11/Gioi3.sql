use social_network_pro;

delimiter //
create procedure CalculateBonusPoints(p_user_id  int, inout p_bonus_points int)
begin
	declare totalPost int;
    
	select count(p.post_id)
    into totalPost
    from posts p
    where p.user_id = p_user_id;
    
    if totalPost >= 20 then
		set p_bonus_points = p_bonus_points + 100;
	elseif totalPost >= 10 then
		set p_bonus_points = p_bonus_points + 50;
	end if;
end //
delimiter 

set @total = 0;
call CalculateBonusPoints(1, @total);
select @total;

drop procedure if exists CalculateBonusPoints;