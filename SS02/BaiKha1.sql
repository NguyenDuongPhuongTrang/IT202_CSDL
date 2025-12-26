-- Tạo CSDL
CREATE database ss02;

-- Chọn CSDL
use ss02;

-- Tạo bảng
CREATE Table class(
	classId char(5) primary key,
    className varchar(100) NOT NULL unique,
    schoolYear date NOT NULL
);

CREATE Table student(
	studentId char(10) primary key,
    fullName varchar(100) NOT NULL,
    dateBirth date NOT NULL,
    classId char(5),
    foreign key(classId) references class(classId)
);