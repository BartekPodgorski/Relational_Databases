--- SCHOOL2 – EXEMPLARY QUERIES ---

-- 1

SELECT cno, cname FROM courses WHERE studyear = 1 ORDER BY cname;

-- 2
SELECT COUNT(sname) AS 'Starts with H' FROM students WHERE sname LIKE 'H%'; -- No A% in example so H% to show it works

-- 3
SELECT city, COUNT(sname) AS 'No of stud' FROM students GROUP BY city;

-- 4
SELECT *FROM teachers
SELECT *FROM courses

SELECT DISTINCT T.tno, T.title, T.tname, C.cno, C.cname FROM teachers T, courses C, tsc WHERE T.tno = tsc.tno AND C.cno = tsc.cno ORDER BY T.tname; 

-- 5
SELECT DISTINCT T.tno FROM tsc T, courses C WHERE C.cno = T.cno AND C.studyear != 1;

-- 6 
SELECT studyear, COUNT(cno) AS noc INTO synoc FROM courses GROUP BY studyear;

SELECT studyear FROM synoc WHERE noc = (SELECT MAX(noc) FROM synoc);

SELECT *FROM synoc

DROP TABLE synoc;

-- 7
SELECT C.studyear, AVG(T.grade) AS ag INTO sag FROM courses C, tsc T WHERE C.cno = T.cno GROUP BY studyear;
SELECT *FROM sag
SELECT studyear FROM sag WHERE ag = (SELECT MAX(ag) FROM sag);

DROP TABLE sag;
-- 8
SELECT COUNT(tno) FROM teachers WHERE tno NOT IN (SELECT DISTINCT tno FROM tsc);

-- 9
SELECT C.studyear, SUM(T.hrs) AS 'Sum of hrs' FROM courses C, tsc T WHERE C.cno = T.cno GROUP BY C.studyear ORDER BY 1; 

-- 10
SELECT sno, AVG(grade) AS ag INTO sag FROM tsc GROUP BY sno;

SELECT sno, sname FROM students WHERE sno IN
	(SELECT sno FROM sag WHERE ag = (SELECT MAX(ag) FROM sag));

DROP TABLE sag;

-- 11
SELECT s.sno, s.sname, AVG(t.grade) AS 'Avg grade' FROM tsc t, students s 
	WHERE s.sno = t.sno GROUP BY s.sno, s.sname ORDER BY 3 DESC;

-- 12
SELECT o.tno, COUNT(u.tno) AS nos INTO tnos FROM teachers o, teachers u WHERE u.supno = o.tno GROUP BY o.tno; 

SELECT tno, title, tname FROM teachers WHERE tno IN
	(SELECT tno FROM tnos WHERE nos = (SELECT MAX(nos) FROM tnos));

DROP TABLE tnos;
-- 13
SELECT tno, tname, title FROM teachers WHERE supno IS NULL;

-- 14 
SELECT T.tno, T.tname, COUNT(DISTINCT C.cname) AS 'No of courses' FROM teachers T, courses C, tsc 
	WHERE T.tno = tsc.tno AND C.cno = tsc.cno GROUP BY T.tno, T.tname HAVING COUNT(DISTINCT C.cname) > 1; 
	-- Nothing grater equal 3 in example so > 1 to show it works

-- 15
SELECT DISTINCT S.sno, S.sname FROM students S, tsc WHERE S.sno = tsc.sno AND tsc.grade >= 5.0; 

-- 16
SELECT DISTINCT S.sno, S.sname INTO #temp FROM students S, tsc WHERE S.sno = tsc.sno AND tsc.grade = (SELECT MAX(grade) FROM tsc); 

SELECT sno, sname FROM #temp;							-- Students ids and names
SELECT COUNT(sno) AS 'No of best students' FROM #temp;	-- No of students

DROP TABLE #temp;

-- 17
SELECT COUNT(sno) AS 'No of students' FROM students WHERE sno IN 
	(SELECT sno FROM tsc WHERE cno = 
		(SELECT cno FROM courses WHERE cname = 'Mathematics' AND studyear = 2));

-- 18
CREATE VIEW BigTSC 
AS SELECT tsc.tno, T.tname, T.title, tsc.sno, S.sname, tsc.cno, C.cname, tsc.hrs, tsc.grade 
	FROM tsc, students S, teachers T, courses C WHERE tsc.sno = S.sno AND tsc.tno = T.tno AND tsc.cno = C.cno;
-- Code above must be RUN in seperate query
SELECT * FROM BigTSC;

-- 19 
SELECT city, COUNT(id) AS 'no of people' FROM 
(SELECT tno AS id, city FROM teachers UNION SELECT sno AS id, city FROM students) AS temp GROUP BY city ORDER BY 2 DESC;

-- 20
SELECT tno, AVG(grade) AS ag INTO tag FROM tsc GROUP BY tno;

SELECT tno, tname FROM teachers WHERE tno IN
	(SELECT tno FROM tag WHERE ag = (SELECT MIN(ag) FROM tag));

DROP TABLE tag;

-- 21
SELECT tsc.tno, T.tname, T.title, tsc.sno, S.sname, tsc.cno, C.cname, tsc.grade INTO tsc1
	FROM tsc, students S, teachers T, courses C WHERE tsc.sno = S.sno AND tsc.tno = T.tno AND tsc.cno = C.cno;

SELECT * FROM tsc1;

DROP TABLE tsc1; -- should be tsc but for this example tsc1

-- 22
SELECT C.cno, C.cname, AVG(tsc.grade) AS ag INTO cavg FROM tsc, courses C 
	WHERE C.cno = tsc.cno GROUP BY C.cno, C.cname;

SELECT * FROM cavg ORDER BY ag DESC;		-- Avg of courses

SELECT cno, cname FROM courses WHERE cno IN
	(SELECT cno FROM cavg WHERE ag > 
		(SELECT AVG(ag) FROM cavg));		-- Courses above average

DROP TABLE cavg;

-- 23
SELECT tno, title, tname FROM teachers WHERE tno IN
	(SELECT tsc.tno FROM tsc, teachers T, students S 
		WHERE T.tno = tsc.tno AND S.sno = tsc.sno AND T.city = S.city AND cno IN
		(SELECT cno FROM courses WHERE studyear = 1)); 

-- 24
SELECT cno, COUNT(DISTINCT sno) AS nos INTO cnos FROM tsc GROUP BY cno;

SELECT cno, cname FROM courses WHERE cno IN 
	(SELECT cno FROM cnos WHERE nos = 
		(SELECT MIN(nos) FROM cnos));

DROP TABLE cnos;

-- 25
SELECT sno, AVG(grade) AS ag INTO sag FROM tsc GROUP BY sno;

SELECT S.syear, AVG(sag.ag) AS yavg FROM students S, sag WHERE S.sno = sag.sno GROUP BY S.syear ORDER BY yavg DESC;

DROP TABLE sag;
 -- exam 10

 SELECT *FROM teachers WHERE SUPNO IS NOT NULL

 --exam 8
 SELECT tno,tname
	FROM teachers	
	WHERE tno IN
		(SELECT supno
		FROM teachers	
		GROUP BY supno	
		HAVING COUNT(supno)>1);

 --1
 SELECT CNO, CNAME FROM Courses WHERE studyear = 1 ORDER BY CNAME

 --2 
 SELECT COUNT(SNAME) AS "Starts with J" FROM STUDENTS WHERE SNAME LIKE 'J%'

--3
SELECT CITY ,COUNT (SNAME) AS "This many" FROM STUDENTS GROUP BY CITY

--4 
SELECT DISTINCT t.TNO, t.TITLE, t.TNAME, c.CNO, c.CNAME FROM TEACHERS t, COURSES c, TSC WHERE t.tno=tsc.tno AND c.CNO=tsc.CNO

--5
SELECT DISTINCT tsc.TNO FROM TSC, COURSES c WHERE c.cno = tsc.cno AND c.studyear != 1

--6
SELECT COUNT(CNO), STUDYEAR FROM COURSES GROUP BY STUDYEAR

--7
SELECT c.studyear,AVG(t.grade) AS AVGG INTO AVGTAB FROM courses c, TSC t WHERE c.cno=t.cno GROUP BY c.studyear
SELECT *FROM AVGTAB
SELECT  MAX(AVGG) FROM AVGTAB
DROP TABLE AVGTAB

--8
SELECT COUNT(tno) FROM TEACHERS WHERE tno NOT IN (SELECT DISTINCT TNO FROM TSC)

--9
SELECT c.studyear,sum(t.hrs) AS "Sum of hrs" FROM Courses c, TSC t WHERE c.cno=t.cno GROUP BY c.studyear ORDER BY 1 

--10
SELECT sno, AVG(Grade) AS "avggrade" INTO SAVG FROM TSC GROUP BY sno 
SELECT *FROM SAVG
SELECT sno, sname FROM students WHERE sno IN(
SELECT sno FROM SAVG WHERE avggrade = (SELECT MAX(avggrade) FROM SAVG))
DROP TABLE SAVG

--11
SELECT s.sno,s.sname,AVG(t.grade) AS "avggrade" FROM students s, tsc t WHERE
s.sno=t.sno GROUP BY s.sno ,s.sname ORDER BY avggrade DESC

--12
SELECT o.tno, count(u.tno) AS nos INTO nostab FROM TEACHERS o, TEACHERS u WHERE u.supno=o.tno GROUP BY o.tno
SELECT *FROM nostab
SELECT t.tno,t.title,t.tname FROM TEACHERS t WHERE tno IN (Select tno FROM nostab WHERE nos = (SELECT MAX(nos) FROM nostab))
DROP TABLE nostab

--17 
SELECT count(sno) as "NO of Stud" FROM students WHERE sno IN(
SELECT sno FROM tsc where cno = 'C2')

--19
SELECT city, count(id) AS "Amount of people" FROM (
SELECT tno AS id, city FROM TEACHERS UNION SELECT sno AS id, city FROM Students) as TEMP GROUP BY CITY ORDER BY 2