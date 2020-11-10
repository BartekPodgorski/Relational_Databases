create table teachers (
	tno varchar(10) primary key,
	tname varchar(10),
	title varchar(10),
	city varchar(10),
	supno varchar(10) references teachers
);

create table students (
	sno varchar(10) primary key,
	sname varchar(10),
	syear varchar(10),
	city varchar(10)
);

create table courses (
	cno varchar(10) primary key,
	cname varchar(20),
	studyear varchar(1)
);

create table tsc (
	tno varchar(10) references teachers,
	sno varchar(10) references students,
	cno varchar(10) references courses,
	hrs int,
	grade float,
	primary key (tno, sno, cno)
);

insert into teachers (tno, tname, title, city, supno)
values ('T1','Blake','Prof.','London',null), ('T2','Smith','PhD','Glasgow','T1'), ('T3','Jones','Prof.','London','T1'),
       ('T4','Clark','PhD','Liverpool','T3'), ('T5','Adams','MSc','Bristol','T4')

insert into students (sno, sname, syear, city)
values ('S1','Henry','1975','London'), ('S2','Jones','1980','Davos'), ('S3','Johnson','1983','Dublin'),
       ('S4','Higgins','1984','London'), ('S5','Ford','1990','Bristol'), ('S6','Hopkins','1990','Adelaide')

insert into courses (cno, cname, studyear)
values ('C1' , 'Mathematics' , 1), ('C2' , 'Mathematics' , 2),('C3' , 'Physics' , 2),('C4' , 'English' , 1),('C5' , 'Chemistry' , 2)

insert into tsc(tno, sno,cno, hrs,grade)
values ('T1','S1','C1',40,5.0), ('T1','S1','C2',24,2.0), ('T1','S2','C1',64,3.5), ('T2','S2','C3',100,3.3), ('T2','S3','C2',100,4.5), ('T2','S3','C3',20,4.0), ('T2','S4','C2',90,2.0),
       ('T2','S4','C3',30,3.0), ('T3','S1','C4',32,3.0), ('T3','S2','C4',36,2.0), ('T3','S3','C4',60,5.0), ('T3','S5','C4',72,4.5), ('T4','S1','C1',60,3.5),
	   ('T4','S1','C3',36,3.5), ('T4','S3','C1',60,3.0), ('T4','S3','C3',36,3.0), ('T4','S5','C1',96,4.0), ('T5','S6','C5',32,4.0)


--drop table  tsc;
--drop table  students;
--drop table  teachers;
--drop table  courses;~