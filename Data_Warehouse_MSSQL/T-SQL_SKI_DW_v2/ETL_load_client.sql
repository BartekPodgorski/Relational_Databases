USE SkiBase
GO

If (object_id('vETLClientData') is not null) Drop View vETLClientData;
go

CREATE VIEW vETLClientData
AS
SELECT
	[PESEL] as PIN,
	[sex] as Sex,
	[surname_name] as Name_and_surname,
	[nationality] as Nationality,
	CASE
        WHEN DATEDIFF(year, [date_of_birth], CURRENT_TIMESTAMP) < 16 THEN 'less than 16'
        WHEN DATEDIFF(year, [date_of_birth], CURRENT_TIMESTAMP) BETWEEN 16 AND 20 THEN 'between 16 and 20'
        WHEN DATEDIFF(year, [date_of_birth], CURRENT_TIMESTAMP) BETWEEN 21 AND 27 THEN 'between 21 and 27'
        WHEN DATEDIFF(year, [date_of_birth], CURRENT_TIMESTAMP) BETWEEN 28 AND 35 THEN 'between 28 and 35'
        WHEN DATEDIFF(year, [date_of_birth], CURRENT_TIMESTAMP) BETWEEN 36 AND 49 THEN 'between 36 and 49'
		WHEN DATEDIFF(year, [date_of_birth], CURRENT_TIMESTAMP) BETWEEN 50 AND 65 THEN 'between 50 and 65'
		WHEN DATEDIFF(year, [date_of_birth], CURRENT_TIMESTAMP) BETWEEN 66 AND 75 THEN 'between 66 and 75'
		WHEN DATEDIFF(year, [date_of_birth], CURRENT_TIMESTAMP) > 75 THEN 'more than 75'
	END AS [Age_category],
	[skills_level] as Skier_skill,
	[quality_rating] as Grade,
	[registration_date] as Insertion_date,
	[disactivation_date] as Deactivation_date
	FROM [SKI_CENTER].dbo.[CLIENT]
;

go

MERGE INTO CLIENT as TT
	USING vETLClientData as ST
		ON TT.PIN = ST.PIN
			WHEN Not Matched
				THEN
					INSERT Values (
					ST.PIN,
					ST.Sex,
					ST.Name_and_surname,
					ST.Nationality,
					ST.Age_category,
					ST.Skier_skill,
					ST.Grade,
					ST.Insertion_date,
					NULL
					)

			WHEN Matched AND ST.Deactivation_date IS NULL
			AND ((ST.Skier_skill <> TT.Skier_skill) OR (ST.Grade <> TT.Grade) OR (ST.Age_category <> TT.Age_category))
			THEN 
				UPDATE 
				SET TT.Deactivation_date = GetDate()
			WHEN Not Matched By Source
				Then
					UPDATE
					SET TT.Deactivation_date = GetDate()
					;

INSERT INTO CLIENT(
	PIN,
	Sex,
	Name_and_surname,
	Nationality,
	Age_category,
	Skier_skill,
	Grade,
	Insertion_date,
	Deactivation_date
	)
SELECT PIN, Sex, Name_and_surname, Nationality, Age_category, Skier_skill, Grade, Insertion_date, Deactivation_date
	FROM vETLClientData
EXCEPT
	SELECT PIN, Sex, Name_and_surname, Nationality, Age_category, Skier_skill, Grade, Insertion_date, Deactivation_date
	FROM CLIENT

Drop View vETLClientData;
/*
SELECT * FROM CLIENT WHERE PIN = 28021854895 or PIN = 12233082388 OR PIN = 79030519174

SELECT COUNT (*) FROM CLIENT
--SELECT * FROM CLIENT
--SELECT * FROM CLIENT WHERE PIN = 36062853021 or PIN = 24052064759 OR PIN = 55010508042

--DROP TABLE TICKET_SCAN
--DROP TABLE SKIPASS
--DROP TABLE CLIENT
SELECT COUNT (*) FROM CLIENT
	WHERE Deactivation_date IS NULL

SELECT * FROM CLIENT
	WHERE Deactivation_date IS NOT NULL 
	ORDER BY PIN


select TOP 10 * from CLIENT

update CLIENT
set skills_level = 'mid'
where PESEL = 21090527842;

update CLIENT
set skills_level = 'junior'
where PESEL = 36062853021;

update CLIENT
set quality_rating = 'bad'
where PESEL = 20100402735;
*/