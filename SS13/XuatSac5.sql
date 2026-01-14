-- Thủ tục thêm người dùng 
delimiter $$
create procedure addUser(
	username_in varchar(50),
    email_in varchar(100),
    created_at_in date
)
begin
    insert into users(username, email, created_at) 
    values (username_in, email_in, created_at_in);
end $$
delimiter ;

-- Trigger kiểm tra dữ liệu
delimiter $$
create trigger triggerBeforeInsertUser
before insert on users
for each row
begin
	-- Kiểm tra username 
	if new.username not regexp "^[A-Za-z0-9_]+$" then
		signal sqlstate "45000" set message_text = "Username không hợp lệ";
    end if;
    -- Kiểm tra email
    if new.email not regexp "^[^@]+@[^@]+\\.[^@]+$" then
		signal sqlstate "45000" set message_text = "Email không hợp lệ";
    end if;
end $$
delimiter ;

drop trigger triggerBeforeInsertUser;
drop procedure addUser;

call addUser("thai son", "thaison", current_date());
call addUser("thaison", "thaison@gmail.com", current_date());

select * from users;