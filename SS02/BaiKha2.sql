-- Chọn CSDL
use ss02;

-- Tạo bảng
CREATE Table Subject(
	subjectId char(10) primary key,
    subjectName varchar(100) NOT NULL,
    credit int NOT NULL,
    
    constraint chk_01 check(credit > 0)
);