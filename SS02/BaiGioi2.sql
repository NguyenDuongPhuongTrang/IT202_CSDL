-- Chọn CSDL
use ss02;

-- Tạo bảng
CREATE Table Teacher(
	teacherId char(10) primary key,
    fullNameTeacher varchar(100),
    email varchar(100)
);

ALTER Table Subject
ADD COLUMN teacherId char(10);

ALTER Table Subject
ADD constraint fk_03 foreign key(teacherId) references Teacher(teacherId);