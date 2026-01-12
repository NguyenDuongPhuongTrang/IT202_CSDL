use social_network_pro;

delimiter //
create procedure CalculateUserActivityScore (p_user_id int, out activity_score int, out activity_level varchar(255))
begin
	declare totalPost int;
    declare totalComment int;
    declare totalLike int;
    declare postScore int;
    declare commentScore int;
    declare likeScore int;

	select count(*) into totalPost
    from posts p
    where p.user_id = p_user_id;
    
    select count(*) into totalComment
    from comments c
    where c.user_id = p_user_id;
    
    select count(*) into totalLike
    from posts p
    join likes l on l.post_id = p.post_id
    where p.user_id = p_user_id;
    
    set postScore = 10 * totalPost;
    set commentScore = 5 * totalComment;
    set likeScore = 3 * totalLike;
    set activity_score = postScore + commentScore + likeScore;
    
    if activity_score < 200 then
		set activity_level = 'Bình thường';
	elseif activity_score >= 200 and activity_score < 500 then
		set activity_level = 'Tích cực';
	else 
		set activity_level = 'Rất tích cực';
	end if;
end // 
delimiter ;
set @score = 0;
set @level = '';
call CalculateUserActivityScore(1, @score, @level);
select @score;
select @level;
drop procedure if exists CalculateUserActivityScore;
