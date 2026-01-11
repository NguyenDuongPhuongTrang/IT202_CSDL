use social_network_pro;

-- Trước sau khi có chỉ mục
explain analyze
select u.user_id, u.username, u.full_name, u.hometown, f.friend_id, f.status from users u 
join friends f on f.user_id = u.user_id
where hometown = 'Ha Noi'
order by username DESC
limit 3;
-- '-> Limit: 3 row(s)  (cost=0.729 rows=0.222) (actual time=0.0692..0.0941 rows=3 loops=1)\n    -> Nested loop inner join  (cost=0.729 rows=0.222) (actual time=0.0682..0.0928 rows=3 loops=1)\n        -> Filter: (u.hometown = \'Ha Noi\')  (cost=0.207 rows=0.2) (actual time=0.0293..0.0671 rows=7 loops=1)\n            -> Index scan on u using username (reverse)  (cost=0.207 rows=2) (actual time=0.024..0.0593 rows=20 loops=1)\n        -> Index lookup on f using PRIMARY (user_id=u.user_id)  (cost=0.306 rows=1.11) (actual time=0.0029..0.00327 rows=0.429 loops=7)\n'

-- Sau khi có chỉ mục
create index idx_hometown 
on users(hometown);

explain analyze
select u.user_id, u.username, u.full_name, u.hometown, f.friend_id, f.status from users u 
join friends f on f.user_id = u.user_id
where hometown = 'Ha Noi'
order by username DESC
limit 3;
-- '-> Limit: 3 row(s)  (cost=3.73 rows=3) (actual time=0.0618..0.0661 rows=3 loops=1)\n    -> Nested loop inner join  (cost=3.73 rows=7.78) (actual time=0.0608..0.0649 rows=3 loops=1)\n        -> Sort: u.username DESC  (cost=1.2 rows=7) (actual time=0.0483..0.049 rows=7 loops=1)\n            -> Index lookup on u using idx_hometown (hometown=\'Ha Noi\')  (cost=1.2 rows=7) (actual time=0.0167..0.024 rows=7 loops=1)\n        -> Index lookup on f using PRIMARY (user_id=u.user_id)  (cost=0.266 rows=1.11) (actual time=0.00187..0.00204 rows=0.429 loops=7)\n'



