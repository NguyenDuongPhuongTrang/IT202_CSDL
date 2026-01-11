create or replace view view_user_activity_status as
select u.user_id, u.username, u.gender, u.created_at, 
case 
	when count(p.post_id) > 0 then "active"
    when count(m.message_id) > 0 then "active"
    else "inactive"
end as status
from users u
left join posts p on p.user_id = u.user_id
left join messages m on m.sender_id = u.user_id
group by u.user_id;

select vu.status, count(vu.user_id) as user_count
from view_user_activity_status vu
group by vu.status;