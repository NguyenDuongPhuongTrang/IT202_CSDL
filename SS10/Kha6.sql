use social_network_pro;

create or replace view view_users_summary
as
select u.user_id, u.username, count(p.post_id) total_posts 
from users u
join posts p on u.user_id = p.user_id
group by u.user_id;

select * from view_users_summary
where total_posts > 5;
