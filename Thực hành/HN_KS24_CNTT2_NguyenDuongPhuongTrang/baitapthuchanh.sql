CREATE database baitap;
use baitap;

CREATE Table Student(
	studentId int primary key,
    fullName varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(10) not null unique
);

CREATE Table Course(
	courseId int primary key,
    courseName varchar(100) not null,
    credit int,
    
    check (credit > 0)
);

CREATE Table Enrollment(
	studentId int,
    courseId int,
    gradle decimal(4,2) not null default '0',
    
    primary key (studentId, courseId),
    foreign key (studentId) references Student(studentId),
    foreign key (courseId) references Course(courseId),
    check (gradle >= 0 and gradle <= 10)
);

INSERT INTO Student
VALUES (1, 'Nguyen Thuy Dung', 'd@gmail.com', '0987123456'),
(2, 'Nguyen Duy Hieu', 'dh@gmail.com', '0987223456'),
(3, 'Le Viet Dung', 'dv@gmail.com', '0980123456'),
(4, 'Tran Ha Chi', 'hc@gmail.com', '0989123456'),
(5, 'Phung Kien Quoc', 'pkq@gmail.com', '0887123456');

INSERT INTO Course
VALUES (1, 'Lập trình C', 5),
(2, 'Lập trình C++', 3),
(3, 'OOP', 6),
(4, 'Cấu trúc dữ liệu và giải thuật', 7),
(5, 'ReactJS', 5);

INSERT INTO Enrollment
VALUES (1, 1, 10),
(1, 2, 9),
(2, 1, 7),
(2, 3, 8),
(3, 4, 9);

UPDATE Enrollment
SET gradle = 9
WHERE studentId = 2 and courseId = 3;

SELECT fullName, email, phone FROM Student;

DELETE FROM Course WHERE courseId = 1;
-- Không thể xóa khóa học có mã là 1 vì bản ghi này đang được tham chiếu bởi bảng Enrollment thông qua khóa ngoại