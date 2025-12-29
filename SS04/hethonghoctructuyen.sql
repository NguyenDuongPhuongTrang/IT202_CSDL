create database ss04;
use ss04;

create table students (
	studentId int primary key auto_increment,
    fullName varchar(100) not null,
	birthday date not null,
    email varchar(50) unique not null
);

create table teachers(
	teacherId int primary key auto_increment,
    fullName varchar(100) not null,
    email varchar(50) unique not null
);

create table courses(
	courseId int primary key auto_increment,
    courseName varchar(50) not null,
    description text not null,
    lesson int not null,
	teacherId int,

    foreign key (teacherId) references teachers(teacherId),
    check(lesson > 0)
);

create table enrollment(
	studentId int,
    courseId int,
    enrollDate timestamp,

    primary key (studentId, courseId),
	foreign key (studentId) references students(studentId),
    foreign key (courseId) references courses(courseId)
);

create table score(
	studentId int,
    courseId int,

    midScore decimal(4,2),
    finalScore decimal(4,2),

    primary key (studentId, courseId),
    foreign key (studentId) references students(studentId),
    foreign key (courseId) references courses(courseId),
    check(midScore >= 0 and midScore <= 10),
    check(finalScore >= 0 and midScore <= 10)
);