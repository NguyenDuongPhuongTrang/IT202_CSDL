-- Tạo CSDL
CREATE database ss02Kha2;

-- Chọn CSDL
use ss02Kha2;

-- Tạo bảng
CREATE Table student(
	studentId char(10) primary key,
    fullName varchar(100) NOT NULL
);

CREATE Table subject(
	subjectId char(10) primary key,
    subjectName varchar(100) NOT NULL,
    credit int NOT NULL,
    
    constraint chk_01 check(credit > 0)
);