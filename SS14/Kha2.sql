use social_network;

create table likes (
	like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    
    unique key unique_like (post_id, user_id),
    foreign key(post_id) references posts(post_id),
    foreign key(user_id) references users(user_id)
);

alter table posts
add column likes_count int default 0;

start transaction;
insert into likes(post_id, user_id)
values(2,1);

update posts
set likes_count = likes_count + 1
where post_id = 2;

commit;

start transaction;
insert into likes(post_id, user_id)
values(2,1);

rollback;

