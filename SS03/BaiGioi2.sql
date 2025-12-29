use ss03;

CREATE Table Enrollment(
	studentId int,
    subjectId int,
    enrollDate date,
    
    primary key (studentId, subjectId),
    
    constraint fk_enroll_student foreign key(studentId) references Student(studentId),
	constraint fk_enroll_subject foreign key(subjectId) references Subject(subjectId)
);

INSERT INTO Enrollment
VALUES (3, 1, '2025-12-24'),
(3, 2, '2025-12-24'),
(2, 1, '2025-12-24'),
(2, 3, '2025-12-24');

SELECT * FROM Enrollment;

SELECT * FROM Enrollment WHERE studentId = 2;