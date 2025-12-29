use ss03;

CREATE Table Score(
	studentId int,
    subjectId int,
    midScore int,
    finalScore int,
    
    primary key (studentId, subjectId),
    constraint chk_mid check(0 <= midScore and midScore <= 10),
    constraint chk_final check(0 <= finalScore and finalScore <= 10)
);

INSERT INTO Score
VALUES (2, 1, 9, 7),
(2, 2, 8, 6),
(3, 1, 8, 9);

UPDATE Score
SET finalScore = 8
WHERE studentId = 2 and subjectId = 2;

SELECT * FROM Score;
SELECT * FROM Score WHERE finalScore >= 8;