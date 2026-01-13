CREATE DATABASE StudentDB;
USE StudentDB;
-- 1. Bảng Khoa
CREATE TABLE Department (
    DeptID CHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 2. Bảng SinhVien
CREATE TABLE Student (
    StudentID CHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID CHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Bảng MonHoc
CREATE TABLE Course (
    CourseID CHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- 4. Bảng DangKy
CREATE TABLE Enrollment (
    StudentID CHAR(6),
    CourseID CHAR(6),
    Score FLOAT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');

INSERT INTO Course VALUES
('C00001','Database Systems',3),
('C00002','C Programming',3),
('C00003','Microeconomics',2),
('C00004','Financial Accounting',3);

INSERT INTO Enrollment VALUES
('S00001','C00001',8.5),
('S00001','C00002',7.0),
('S00002','C00001',6.5),
('S00003','C00003',7.5),
('S00004','C00004',8.0),
('S00005','C00001',9.0),
('S00006','C00003',6.0),
('S00007','C00004',7.0),
('S00008','C00001',5.5),
('S00008','C00002',6.5);


-- PHẦN A – CƠ BẢN
-- Câu 1:  Tạo View View_StudentBasic hiển thị: StudentID, FullName , DeptName. 
-- Sau đó truy vấn toàn bộ View_StudentBasic
create or replace view View_StudentBasic 
as
select s.StudentID, s.FullName, d.DeptName
from Student s
join Department d on d.DeptID = s.DeptID;

select * from View_StudentBasic;

-- Câu 2: Tạo Regular Index cho cột FullName của bảng Student
create index idx_fullname on Student(FullName);

-- Câu 3: Viết Stored Procedure GetStudentsIT
delimiter //
create procedure GetStudentsIT()
begin
	select s.FullName, d.DeptName 
    from Student s
    join Department d on d.DeptID = s.DeptID
    where DeptName = 'Information Technology';
end //
delimiter 

call GetStudentsIT();

-- PHẦN B – KHÁ
-- Câu 4: 
-- a)Tạo View View_StudentCountByDept hiển thị: DeptName, TotalStudents (số sinh viên mỗi khoa).
create or replace view View_StudentCountByDept
as
select d.DeptName, count(s.StudentID) as TotalStudents
from Department d
join Student s on d.DeptID = s.DeptID
group by d.DeptName;

-- b)Từ View trên, viết truy vấn hiển thị khoa có nhiều sinh viên nhất.
select * from View_StudentCountByDept
order by TotalStudents DESC
limit 1;

-- Câu 5:Viết Stored Procedure GetTopScoreStudent	
delimiter // 
create procedure GetTopScoreStudent(p_CourseID char(6))
begin
	select s.FullName, c.CourseName, e.Score
    from Student s
    join Enrollment e on e.StudentID = s.StudentID
    join Course c on c.CourseID = e.CourseID
    where e.CourseID = p_CourseID
      and e.Score = (
          select max(Score)
          from Enrollment
          where CourseID = p_CourseID
	);
end //
delimiter 

call GetTopScoreStudent('C00001');

-- PHẦN C – GIỎI
-- Câu 6:
-- a. Tạo View View_IT_Enrollment_DB
create or replace view View_IT_Enrollment_DB
as
select s.StudentID, s.FullName, s.DeptID
from Student s
join Enrollment e on e.StudentID = s.StudentID
where s.DeptID = 'IT'
with check option;

select * from View_IT_Enrollment_DB;

delimiter //
create procedure UpdateScore_IT_DB(p_StudentID char(6), inout p_NewScore float)
begin
	if p_NewScore > 10 then 
		set p_NewScore = 10;
	end if;
    
    if exists (
        select 1
        from View_IT_Enrollment_DB
        where StudentID = p_StudentID) then
			update Enrollment
			set Score = p_NewScore
			where StudentID = p_StudentID
			  and CourseID = p_CourseID;
    end if;
end //
delimiter 

set @new = 0;
call UpdateScore_IT_DB('C00001', @new)