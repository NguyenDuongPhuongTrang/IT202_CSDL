create index idx_user_gender on users(gender);

create or replace view view_popular_posts as
select p.post_id, u.username, p.content, 
count(p.post_id) as total_likes, count(m.message_id)  as total_comments
from users u
join posts p on p.user_id = u.user_id
join messages m on m.sender_id = u.user_id
join likes li on li.user_id = u.user_id
group by p.post_id;

select vp.*, sum(vp.total_likes + vp.total_comments)as total_interactions from view_popular_posts vp
group by vp.post_id
having total_interactions > 10
order by total_interactions desc;

drop index idx_user_gender on users;