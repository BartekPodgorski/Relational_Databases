select * from TEACHERS;
select * from STUDENTS;
select * from COURSES;
select * from TSC;


/*Show identifiers and names of courses held on the 1st year of study.Order them alphabetically according to the names of courses.*/

select CNO, CNAME 
	FROM COURSES
		WHERE STUDYEAR = 1
		ORDER BY CNAME;

/*How many students have their names starting from letter A?*/

SELECT COUNT(*)
	FROM STUDENTS
		WHERE SNAME LIKE 'A%';

/*For each city,give the numer of students that come from this city.*/

SELECT CITY, COUNT(*)
	FROM STUDENTS
	GROUP BY CITY;

/*For each teacher (id, title and name),give courses (ids, names) that he/she conducted.*/

select DISTINCT TEACHERS.TNO, TITLE, TNAME, COURSES.CNO, CNAME
from COURSES, TEACHERS, TSC
where TSC.CNO = COURSES.CNO
and TSC.TNO = TEACHERS.TNO;

/*Show ids of teachers that did not have classes on the 1st year of study.*/

select DISTINCT TNO
	FROM TSC
	WHERE TNO NOT IN (SELECT TNO
	FROM TSC,COURSES
	WHERE TSC.CNO=COURSES.CNO AND COURSES.STUDYEAR = 1);

/*On which year of study there weremost courses?*/

SELECT TOP 1 STUDYEAR
	FROM COURSES
	GROUP BY STUDYEAR
	ORDER BY COUNT(*) DESC;

/*On which year of study there was the greatest average grade?*/

SELECT top 1 STUDYEAR
	FROM COURSES,TSC
		WHERE TSC.CNO=COURSES.CNO
		group by STUDYEAR
		ORDER BY AVG(GRADE) DESC;

/*How many teachersdid not have any classes?*/

SELECT COUNT(*)
	FROM TEACHERS
	WHERE TNO IN
	(SELECT TEACHERS.TNO
		FROM TEACHERS,TSC
		WHERE TEACHERS.TNO=TSC.TNO);
		
/*For each year of study, show the sum of teaching hours. Order the result according to the years of study*/

SELECT STUDYEAR, SUM(CHOURS)
	FROM COURSES,TSC
	WHERE COURSES.CNO=TSC.CNO
	GROUP BY STUDYEAR
	ORDER BY STUDYEAR;

/*Which students(id, name) havethe greatest average grade?*/

SELECT TOP 1 STUDENTS.SNO,SNAME
	FROM STUDENTS,TSC
	WHERE STUDENTS.SNO=TSC.SNO
	GROUP BY STUDENTS.SNO,SNAME
	ORDER BY AVG(GRADE) DESC;

/*Show the list of all students (ids, names) ordered according to decreasing average grades.*/

SELECT STUDENTS.SNO, SNAME
	FROM STUDENTS,TSC
	WHERE TSC.SNO=STUDENTS.SNO
	GROUP BY STUDENTS.SNO, SNAME
	ORDER BY AVG(GRADE) DESC;

/*Which teachers(id, title, name) havethe most numer of subordinates?*/

SELECT TNO,TITLE,TNAME
	FROM TEACHERS
	WHERE TNO IN (SELECT TOP 1 SUPNO 
					FROM TEACHERS
					GROUP BY SUPNO
					ORDER BY COUNT(*) DESC
					);

/*Which teachers(id, title, name) haveno supervisor?*/

SELECT TNO,TITLE,TNAME
	FROM TEACHERS
		WHERE SUPNO IS NULL;

/*Which teachers (ids, names) conducted more than 3 courses and how many courses they conducted*/

SELECT TEACHERS.TNO,TNAME,COUNT(DISTINCT CNO)
	FROM TEACHERS,TSC
	WHERE TEACHERS.TNO=TSC.TNO
	GROUP BY TEACHERS.TNO,TNAME
	HAVING COUNT(DISTINCT CNO) > 3;

/*Show ids and names of those students who obtained at least one 5.0 from any subject.*/

SELECT DISTINCT STUDENTS.SNO,SNAME
	FROM STUDENTS,TSC
		WHERE STUDENTS.SNO=TSC.SNO AND GRADE=50;

/*Show ids and names of those students who obtained at least one grade that is maximal from all the grades obtained by anyone.
How many students satisfy this condition?*/

SELECT STUDENTS.SNO,SNAME INTO TMP
	FROM STUDENTS , TSC
	WHERE STUDENTS.SNO=TSC.SNO AND GRADE = (SELECT MAX(GRADE) FROM TSC);

SELECT COUNT(*)
	FROM TMP;
DROP TABLE TMP;
	
/*How many students had mathematics on the 2nd year of study?*/

SELECT COUNT(*)
	FROM STUDENTS,COURSES,TSC
	WHERE STUDENTS.SNO=TSC.SNO AND TSC.CNO=COURSES.CNO AND CNAME='Mathematics' AND STUDYEAR=2;

/*Create a view that contains all the data from TSC extended by names of students, titles and names of teachers and names of courses*/

CREATE VIEW TSCEXT
	AS SELECT TSC.*, SNAME, TITLE, TNAME, CNAME FROM TSC, STUDENTS, TEACHERS, COURSES
	WHERE TSC.TNO = TEACHERS.TNO AND TSC.SNO = STUDENTS.SNO AND TSC.CNO = COURSES.CNO

SELECT * FROM TSCEXT;
DROP VIEW TSCEXT;

/*For each city, give the total numer of students and teachers that come from this city.*/

SELECT city, COUNT(city)
FROM (SELECT city FROM teachers
      UNION ALL
      SELECT city FROM students) AS Temp1
GROUP BY city;

/*Which teacher (id, name) gave the students the worst grades (i.e. the average grade from all the grades given by this teacher is the lowest).*/

SELECT  TOP 1 TEACHERS.TNO, TNAME
	FROM TEACHERS ,TSC
		WHERE TEACHERS.TNO=TSC.TNO
			GROUP BY TEACHERS.TNO , TNAME
			ORDER BY AVG(GRADE) ;

/*For each course, show the average grade obtained by the students from this course. 
Next show these courses (ids, names) for which this average exceeds the average of all the averages.*/


SELECT  AVG(GRADE) AS MEAN INTO TMP
	FROM TSC
	GROUP BY CNO;

SELECT DISTINCT COURSES.CNO,CNAME
	FROM COURSES,TSC 
	WHERE COURSES.CNO=TSC.CNO 
	GROUP BY COURSES.CNO,CNAME 
	HAVING AVG(GRADE)> (SELECT AVG(MEAN) FROM TMP);

DROP TABLE TMP;

/*Show those teachers (ids, titles, names) who on the 1st year of study taught students that come from the same city as the teacher.*/

SELECT DISTINCT TEACHERS.TNO, TITLE,TNAME
	FROM TEACHERS , STUDENTS, COURSES
		WHERE  TEACHERS.CITY=STUDENTS.CITY AND STUDYEAR=1;

SELECT DISTINCT teachers.tno, title, tname 
FROM teachers
INNER JOIN students ON teachers.city = students.city
;


/*Show the course (id, name) that hadthe least numer of students (but was conducted on any yearof study)*/

SELECT  TOP 1 TSC.CNO, CNAME 
	FROM COURSES,TSC
	WHERE COURSES.CNO=TSC.CNO
	GROUP BY TSC.CNO, CNAME
	ORDER BY COUNT(SNO);

/*For each year of entry the studies, show the average grade of students that entered studies in this year. 
The result should be ordered according to decreasing averages.*/

SELECT syear , AVG(GRADE)
	FROM STUDENTS,TSC
		WHERE TSC.SNO=STUDENTS.SNO
		GROUP BY syear
		ORDER BY 2 DESC;

