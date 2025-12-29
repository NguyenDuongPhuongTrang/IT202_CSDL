use ss03;

UPDATE Student
SET email = 'docong@gmail.com'
WHERE studentId = 3;

UPDATE Student
SET dateBirth = '2006-02-02'
WHERE studentId = 2;

DELETE FROM Student WHERE studentId = 1;

SELECT * FROM Student;