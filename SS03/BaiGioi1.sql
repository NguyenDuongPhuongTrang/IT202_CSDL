use ss03;

CREATE Table Subject(
	subjectId int primary key,
    subjectName varchar(100) NOT NULL,
    credit int,
    
    constraint chk_credit check(credit > 0)
);

INSERT INTO Subject
VALUES (1, 'Toán cao cấp', 7),
(2, 'Lịch sử Đảng', 5),
(3, 'Pháp luật đại cương', 4);

UPDATE Subject
SET credit = 10, subjectName = 'Toán đại cương'
WHERE subjectId = 2;

