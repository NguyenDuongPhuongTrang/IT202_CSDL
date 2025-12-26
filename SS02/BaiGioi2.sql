-- Tạo CSDL
CREATE database ss02Gioi1;

-- Chọn CSDL
use ss02Gioi1;

-- Tạo bảng
CREATE Table Student(
	studentId char(10) primary key,
    fullName varchar(100) NOT NULL
);

CREATE Table Subject(
	subjectId char(10) primary key,
    subjectName varchar(100) NOT NULL,
    credit int NOT NULL,
    
    constraint chk_01 check(credit > 0)
);

CREATE Table Enrollment(
	studentId char(10),
    subjectId char(10),

    primary key (studentId, subjectId),
    constraint fk_01 foreign key (studentId) references Student(studentId),
    constraint fk_02 foreign key (subjectId) references Subject(subjectId)
);

CREATE Table Teacher(
	teacherId char(10) primary key,
    fullNameTeacher varchar(100),
    email varchar(100)
);

ALTER Table Subject
ADD COLUMN teacherId char(10);

ALTER Table Subject
ADD constraint fk_03 foreign key(teacherId) references Teacher(teacherId);