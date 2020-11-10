USE SkiBase
GO

--tabela pomocnicza do zaladowania ilosci kanap z excela
If (object_id('dbo.Temp') is not null) DROP TABLE dbo.Temp;
CREATE TABLE dbo.Temp(id_Lift int, numberOfCouches int);
go

BULK INSERT dbo.Temp
    FROM 'C:\Users\user\Desktop\T-SQL_SKI_DW_v2\Myfile2.txt'
    WITH
    (
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'   --Use to shift the control to next row
    )
	;

--tworzymy encjê Lift, na razie w formie VIEW
If (object_id('vETLLiftData') is not null) Drop View vETLLiftData;
go
CREATE VIEW vETLLiftData
AS
SELECT DISTINCT
	[lift_name] as [Lift_name],
	CASE
		WHEN [length_of_lift] <= 300 THEN 'between 0 and 300'
		WHEN [length_of_lift] BETWEEN 301 AND 500 THEN 'between 300 and 500'
		WHEN [length_of_lift] BETWEEN 501 AND 1000 THEN 'between 500 and 1000'
		ELSE 'more than 1000'
	END AS [Length_of_lift_category],
	CASE
		WHEN [time_of_going_up] < 1 THEN 'less than 1 min'
		WHEN [time_of_going_up] BETWEEN 1 AND 2 THEN 'between 1 and 2 min'
		WHEN [time_of_going_up] BETWEEN 3 AND 4 THEN 'between 3 and 4 min'
		ELSE 'more than 4 min'
	END AS [Time_going_up_category],
	[couch_description] as [Couch_size_category],
	CASE
		WHEN tmp1.[numberOfCouches] < 30 THEN 'less than 30'
		WHEN tmp1.[numberOfCouches] BETWEEN 30 AND 40 THEN 'between 30 and 40'
		WHEN tmp1.[numberOfCouches] BETWEEN 41 AND 50 THEN 'between 40 and 50'
		WHEN tmp1.[numberOfCouches] BETWEEN 51 AND 60 THEN 'between 50 and 60'
		ELSE 'more than 60'
	END AS [Size_category],
	[lift_type_description] as [Lift_type]
	
FROM [SKI_CENTER].dbo.[LIFT]
JOIN dbo.Temp as tmp1 on tmp1.id_Lift = [SKI_CENTER].dbo.[LIFT].lift_id
JOIN [SKI_CENTER].dbo.[LIFT_TYPE] on [SKI_CENTER].dbo.[LIFT_TYPE].[lift_type_id] = [SKI_CENTER].dbo.[LIFT].[lift_type_id]
;
go

--SELECT TOP 100 * FROM vETLLiftData;

--koncowa tabela LIFT
MERGE INTO LIFT as TT
	USING vETLLiftData as ST
		ON TT.Lift_name = ST.[Lift_name]
		AND TT.Length_of_lift_category = ST.Length_of_lift_category
		AND TT.Time_going_up_category = ST.Time_going_up_category
		AND TT.Couch_size_category = ST.Couch_size_category
		AND TT.Size_category = ST.Size_category
		AND TT.Lift_type = ST.Lift_type
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.[Lift_name],
					ST.Length_of_lift_category,
					ST.Time_going_up_category,
					ST.Couch_size_category,
					ST.Size_category,
					ST.Lift_type
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

GO
--SELECT TOP 100 * FROM LIFT;

--usuwamy tabelê pomocnicz¹
--Drop View vETLLiftData;
