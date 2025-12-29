use ss03;

INSERT INTO Student
VALUES (1, 'Nguyễn Dương Phương Trang', '2006-10-06', 'trang@gmail.com');

INSERT INTO Enrollment
VALUES (1, 1, '2025-12-24'),
(1, 2, '2025-12-24');

INSERT INTO Score
VALUES (1, 1, 8, 7),
(1, 2, 7, 10);

UPDATE Score
SET finalScore = 10
WHERE studentId = 1 and subjectId = 1;

SELECT * FROM Score;

SELECT 
s.fullName,
sub.subjectName,
sc.midScore,
sc.finalScore
FROM Student s JOIN Enrollment e ON s.studentId = e.studentId
JOIN Subject sub ON e.subjectId = sub.subjectId
JOIN Score sc ON sc.studentId = e.studentId AND sc.subjectId = e.subjectId
WHERE s.studentId = 1;