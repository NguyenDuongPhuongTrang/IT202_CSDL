-- Tạo CSDL
CREATE database ss02XuatSac2;

-- Chọn CSDL
use ss02XuatSac2;

-- Tạo bảng
CREATE Table Class(
	classId char(5) primary key,
    className varchar(100) NOT NULL unique
);

CREATE Table Student(
	studentId char(10) primary key,
    fullName varchar(100) NOT NULL,
    classId char(5),
    
    constraint fk_student_class foreign key (classId) references Class(classId)
);

CREATE Table Teacher(
	teacherId char(10) primary key,
    fullNameTeacher varchar(100),
    email varchar(100)
);

CREATE Table Subject(
	subjectId char(10) primary key,
    subjectName varchar(100) NOT NULL,
    credit int NOT NULL,
    teacherId char(10),
    
    constraint chk_subject_credit check(credit > 0),
    constraint fk_subject_teacher foreign key(teacherId) references Teacher(teacherId)
);

CREATE Table Enrollment(
	studentId char(10),
    subjectId char(10),

    primary key (studentId, subjectId),
    constraint fk_enrollment_student foreign key (studentId) references Student(studentId),
    constraint fk_enrollment_subject foreign key (subjectId) references Subject(subjectId)
);

CREATE Table Score (
    studentId char(10),
    subjectId CHAR(10),
    processScore decimal(4,2) NOT NULL,
    finalScore decimal(4,2) NOT NULL,

    primary key (studentId, subjectId),
    constraint chk_processScore check (processScore between 0 and 10),
    constraint chk_finalScore check (finalScore between 0 and 10),
    constraint fk_score_student foreign key (studentId) references Student(studentId),
    constraint fk_score_subject foreign key (subjectId) references Subject(subjectId)
);