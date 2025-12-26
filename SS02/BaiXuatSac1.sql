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
