create index idx_user_gender on users(gender);

create or replace view view_user_activity as
select u.user_id, count(p.post_id) as total_posts, 
count(m.message_id) as total_comments from users u
join posts p on p.user_id = u.user_id
join messages m on m.sender_id = u.user_id
group by u.user_id;

select * from view_user_activity
where total_posts > 5 and total_comments > 5
order by total_comments desc;

drop index idx_user_gender on users;