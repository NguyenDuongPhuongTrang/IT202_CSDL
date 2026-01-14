use ss13;

create table post_history(
	history_id int primary key auto_increment,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime default current_timestamp,
    changed_by_user_id int,
    
    foreign key (post_id) references posts(post_id) on delete cascade
);

delimiter //
create trigger trigger_update_post
before update on posts
for each row
begin
    if old.content <> new.content then
		insert into post_history(post_id, old_content, new_content, changed_by_user_id)
        values (new.post_id, old.content, new.content, new.user_id);
	end if;
end //
delimiter ;

update posts
set content = 'Phuongtrang'
where post_id = 2;

select * from posts;
select * from post_history;