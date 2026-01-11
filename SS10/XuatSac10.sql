create index idx_user_username on users(username);

create or replace view view_user_activity_2 as
select u.user_id, u.username,
ifnull(count(post_id), 0) as total_posts, 
ifnull(t.total_friends, 0) as total_friends
from users u
left join posts p on p.user_id = u.user_id
left join (
	select f.user_id, count(f.user_id) as total_friends from friends f
    where f.status = "accepted"
    group by f.user_id
) as t on t.user_id = u.user_id
group by u.user_id;

select vu2.username, vu2.total_posts, vu2.total_friends,
case
	when vu2.total_friends < 2 then "ít bạn bè"
    when vu2.total_friends < 5 then "vừa đủ bạn bè"
    else "nhiều bạn bè"
end as friend_description,
case
	when vu2.total_posts > 5 then vu2.total_posts * 0.9
    when vu2.total_posts < 10 then vu2.total_posts
    else vu2.total_posts * 1.1
end as post_activity_score
from view_user_activity_2 vu2
join view_user_activity vu on vu.user_id = vu2.user_id;

drop index idx_user_username on users;