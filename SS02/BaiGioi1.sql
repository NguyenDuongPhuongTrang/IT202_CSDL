-- Chọn CSDL
use ss02;

-- Tạo bảng
CREATE Table Enrollment(
	studentId char(10),
    subjectId char(10),

    primary key (studentId, subjectId),
    constraint fk_enrollment_student foreign key (studentId) references Student(studentId),
    constraint fk_enrollment_subject foreign key (subjectId) references Subject(subjectId)
);