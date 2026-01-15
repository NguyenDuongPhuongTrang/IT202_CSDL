create database social_network;
use social_network;

create table users(
	user_id int primary key auto_increment,
    username varchar(50) not null,
    post_count int default 0
);

create table posts(
	post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    
    foreign key(user_id) references users(user_id)
);

start transaction;
insert into posts(user_id, content)
values(1, 'Học lập trình C');

update users
set post_count = post_count + 1
where id = 1;

rollback;

start transaction;
insert into users(username)
values('ptrang');

insert into posts(user_id, content)
values(1, 'Học lập trình C');

update users
set post_count = post_count + 1
where user_id = 1;

commit;


