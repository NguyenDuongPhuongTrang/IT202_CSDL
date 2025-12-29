CREATE database ss03;
use ss03;

CREATE Table Student(
	studentId int primary key,
    fullName varchar(100) NOT NULL,
    dateBirth DATE,
    email varchar(100) unique
);

INSERT INTO Student(studentId, fullName, dateBirth, email)
VALUES (1, 'Nguyễn Dương Phương Trang', '2006-10-06', 'trang@gmail.com'),
(2, 'Bùi Thái Sơn', '2006-03-06', 'son@gmail.com'),
(3, 'Đỗ Trí Công', '2006-10-03', 'cong@gmail.com');

SELECT * FROM Student;

SELECT studentId, fullName FROM Student;