USE SkiBase
GO
/*
If (object_id('dbo.LocationsTemp') is not null) DROP TABLE dbo.LocationsTemp;
CREATE TABLE dbo.LocationsTemp(zipcode varchar(6), street varchar(100), city varchar(100), voivodeship varchar(100), number varchar(100));
go

BULK INSERT dbo.LocationsTemp
    FROM 'C:\Users\alenaboz\Documents\ETL Bookstore\data_sources\locations.csv'
    WITH
    (
    FIRSTROW = 1,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )*/
/*
If (object_id('dbo.BookstoresTemp') is not null) DROP TABLE dbo.BookstoresTemp;
CREATE TABLE dbo.BookstoresTemp(bookstoreID varchar(100), bookstoreName varchar(100), BookstoreAddress varchar(100), zipcode varchar(6), city varchar(100));
go

BULK INSERT dbo.BookstoresTemp
    FROM 'C:\Users\alenaboz\Documents\ETL Bookstore\data_sources\CEO_sheet1.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )

--SELECT * FROM dbo.BookstoresTemp;


If (object_id('dbo.EmployeesTemp') is not null) DROP TABLE dbo.EmployeesTemp;
CREATE TABLE dbo.EmployeesTemp(bookstoreID varchar(255), PESEL varchar(255), empName varchar(255), 
								empSurname varchar(255), birthDate date, education varchar(255), position varchar(255),
								startWorkDate date, endWorkDate date);
go

BULK INSERT dbo.EmployeesTemp
    FROM 'C:\Users\alenaboz\Documents\ETL Bookstore\data_sources\CEO_sheet2.csv'
    WITH
    (
    FIRSTROW = 2,
	DATAFILETYPE = 'char',
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )
*/
If (object_id('vETLClientData') is not null) Drop View vETLClientData;
go

CREATE VIEW vETLClientData
AS
SELECT
	--t1.PIN,
	--client_id as [ID_client],
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
	FROM [SKI_CENTER].dbo.[CLIENT];
;

SELECT TOP 10 * FROM vETLClientData;

/*JOIN dbo.BookstoresTemp as t1 on t1.bookstoreID = t2.bookstoreID
JOIN dbo.EmployeesTemp as t2 on t1.bookstoreID = t2.bookstoreID
JOIN dbo.LocationsTemp as t3 on t1.zipcode = t3.zipcode
GROUP BY
	t1.bookstoreID,
	t1.bookstoreName,
	t3.voivodeship,
	t1.city;*/
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
					SET TT.Deactivation_date = GetDate();

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

SELECT *
	FROM vETLClientData
	WHERE PIN = 36062853021

SELECT *
	FROM CLIENT
	WHERE PIN = 36062853021
























/*
MERGE INTO CLIENT
	USING (SELECT vETLClientData.PIN AS join_key, vETLClientData.* 
	FROM vETLClientData
	
	UNION ALL

	SELECT NULL, ST.*
	FROM vETLClientData AS ST
	JOIN CLIENT ON ST.PIN = CLIENT.PIN 
	WHERE (((ST.Skier_skill <> CLIENT.Skier_skill) OR (ST.Grade <> CLIENT.Grade) OR (ST.Age_category <> CLIENT.Age_category)))) AS SUBTABLE

	ON SUBTABLE.join_key = CLIENT.PIN
	WHEN Matched -- when name, voivodeship and city match, but the size doesn't match
			AND SUBTABLE.Deactivation_date IS NULL
			AND ((SUBTABLE.Skier_skill <> CLIENT.Skier_skill) OR (SUBTABLE.Grade <> CLIENT.Grade) OR (SUBTABLE.Age_category <> CLIENT.Age_category))
		THEN
			UPDATE
			SET CLIENT.Deactivation_date = GetDate()

	WHEN Not Matched
			THEN
					INSERT Values (
					SUBTABLE.PIN,
					SUBTABLE.Sex,
					SUBTABLE.Name_and_surname,
					SUBTABLE.Nationality,
					SUBTABLE.Age_category,
					SUBTABLE.Skier_skill,
					SUBTABLE.Grade,
					SUBTABLE.Insertion_date,
					NULL
					);
			
*/
/*
JOIN vETLClientData as ST
		ON TT.PIN = ST.PIN
		and TT.Sex = ST.Sex
		and TT.Name_and_surname = ST.Name_and_surname
		and TT.Nationality = ST.Nationality
		and TT.Age_category = ST.Age_category
		and TT.Insertion_date = ST.Insertion_date*/

	/*OUTPUT $Action Action_Out, 
			ST.PIN,
			ST.Sex,
			ST.Name_and_surname,
			ST.Nationality,
			ST.Age_category,
			ST.Skier_skill,
			ST.Grade,
			ST.Insertion_date,
			convert(char(10), getdate()-1, 101) Eff_Date, 
			'12/31/2199' End_Date, 
			'y'Current_Flag
	AS MERGE_OUT
	WHERE MERGE_OUT.Action_Out = 'UPDATE'*/
;

--DROP TABLE dbo.LocationsTemp;
--DROP TABLE dbo.BookstoresTemp;
--DROP TABLE dbo.EmployeesTemp;
Drop View vETLClientData;