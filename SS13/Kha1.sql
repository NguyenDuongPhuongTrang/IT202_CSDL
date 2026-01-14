create database ss13;
use ss13;

create table users (
	user_id int primary key auto_increment,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

create table posts (
	post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at date,
    like_count int default 0,
    
    foreign key (user_id) references users(user_id) on delete cascade
);

insert into users (username, email, created_at) 
values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

delimiter //
create trigger trigger_after_insert
after insert on posts
for each row
begin
	update users
    set post_count = post_count + 1
    where user_id = New.user_id;
end //
delimiter ;

delimiter //
create trigger trigger_after_delete
after delete on users
for each row
begin
	update users 
    set post_count = post_count - 1
    where user_id = Old.user_id;
end //
delimiter ;

insert into posts (user_id, content, created_at) 
values
(1, 'Hello world from Alice!', '2025-01-10'),
(1, 'Second post by Alice', '2025-01-10'),
(2, 'Bob first post', '2025-01-11'),
(3, 'Charlie sharing thoughts', '2025-01-12');

select * from users;
select * from posts;