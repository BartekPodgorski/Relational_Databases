--DROP TABLE TICKET_SCAN

use SkiBase;
go

If (object_id('dbo.CouchTemp') is not null) DROP TABLE dbo.CouchTemp;
CREATE TABLE dbo.CouchTemp(idGatepassing bigint, CouchNo int);
go

BULK INSERT dbo.CouchTemp
    FROM 'C:\Users\user\Desktop\T-SQL_SKI_DW_v2\CouchNo.txt'
    WITH
    (
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'  --Use to shift the control to next row
    )
	;

--SELECT TOP 100 * FROM dbo.CouchTemp
--ORDER BY idGatepassing DESC
--SELECT COUNT(*) FROM dbo.CouchTemp

If (object_id('dbo.ScanNo') is not null) DROP TABLE dbo.ScanNo;
CREATE TABLE dbo.ScanNo(idGatepassing bigint, ScanNo int);
go

BULK INSERT dbo.ScanNo
    FROM 'C:\Users\user\Desktop\T-SQL_SKI_DW_v2\ScanNo.txt'
    WITH
    (
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n'  --Use to shift the control to next row
    )
	;

--SELECT TOP 10 * FROM ScanNo


If (object_id('vETLtest') is not null) Drop View vETLtest;
go

CREATE VIEW vETLtest
AS
SELECT
	CO.idGatepassing,
	CouchNo,
	date_of_passing,
	CASE
		WHEN [date_of_passing]<='2020-01-01' THEN 'inactive'
		ELSE 'active'
	END AS [App],
	ScanNo as ScanNo

	FROM dbo.CouchTemp  AS CO
	JOIN SKI_CENTER.dbo.[GATEPASSING] AS GP ON GP.gatepassing_id = CO.idGatepassing
	JOIN dbo.ScanNo AS SN ON SN.idGatepassing = CO.idGatepassing
;
GO
--SELECT TOP 100 * FROM vETLtest
--SELECT COUNT(*) FROM vETLtest

If (object_id('vETLClientData') is not null) Drop View vETLClientData;
go

CREATE VIEW vETLClientData
AS
SELECT
	[client_id] as ID_client,
	[Age] = DATEDIFF(year, [date_of_birth], CURRENT_TIMESTAMP)

	FROM [SKI_CENTER].dbo.[CLIENT]
	;
GO
--SELECT TOP 10 * FROM vETLClientData

If (object_id('dbo.DFSCTemp') is not null) DROP TABLE dbo.DFSCTemp;
CREATE TABLE dbo.DFSCTemp(idChange bigint, idLiftChange bigint, dateChange date, dateTo date ,statusLift varchar(50), applicationStatus varchar(50));
go

BULK INSERT dbo.DFSCTemp
    FROM 'C:\Users\user\Desktop\T-SQL_SKI_DW_v2\DFSC4.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )
	;

If (object_id('vETLLiftData') is not null) Drop View vETLLiftData;
go

CREATE VIEW vETLLiftData
AS
SELECT DISTINCT
	[lift_name] as [Lift_name]
	,[Length_of_lift] = [length_of_lift]
	
FROM [SKI_CENTER].dbo.[LIFT]
JOIN dbo.DFSCTemp as tmp1 on tmp1.idLiftChange = [SKI_CENTER].dbo.[LIFT].lift_id
JOIN [SKI_CENTER].dbo.[LIFT_TYPE] on [SKI_CENTER].dbo.[LIFT_TYPE].[lift_type_id] = [SKI_CENTER].dbo.[LIFT].[lift_type_id]
;
GO
--SELECT TOP 10 * FROM vETLLiftData


If (object_id('vETLFTicket_scan') is not null) Drop view vETLFTicket_scan;
go

CREATE VIEW vETLFTicket_scan
AS
SELECT DISTINCT --bez DISTINCT
	ID_date = ST2.ID_date,
	ID_time = ST6.ID_time,
	ID_skipass = ST1.skipass_id,
	ID_lift = ST3.ID_lift,
	ID_junk = JK.ID_junk,
	Scan_no = CT.ScanNo,
	Skier_age = ST7.Age,
	Lift_length = ST8.Length_of_lift
FROM  SKI_CENTER.dbo.[GATEPASSING] as ST1
	JOIN SkiBase.dbo.[DATE] as ST2 ON CONVERT(VARCHAR(10), ST2.[date], 111) = CONVERT(VARCHAR(10), ST1.[date_of_passing], 111)
	JOIN SkiBase.dbo.LIFT as ST3 ON ST1.lift_id = ST3.ID_lift
	JOIN SkiBase.dbo.SKIPASS as ST5 ON ST1.skipass_id = ST5.ID_skipass
	JOIN SkiBase.dbo.[TIME] as ST6 ON ST6.Hour = DATEPART(HOUR, ST1.time_of_passing) AND ST6.Minute = DATEPART(Minute, ST1.time_of_passing) AND ST6.Second = DATEPART(SECOND, ST1.time_of_passing)
	JOIN vETLClientData as ST7 ON ST5.ID_client = ST7.ID_client
	JOIN vETLLiftData as ST8 ON ST3.Lift_name = ST8.Lift_name
	JOIN vETLtest as CT ON ST1.gatepassing_id = CT.idGatepassing 
	JOIN  SkiBase.dbo.[JUNK] as JK ON JK.Couch_no = CT.CouchNo AND JK.[Application] = CT.App
	;
GO
--SELECT TOP 100 * FROM  vETLFTicket_scan
--SELECT DISTINCT TOP 10 ID_date FROM vETLFTicket_scan


MERGE INTO TICKET_SCAN as TT
	USING vETLFTicket_scan as ST
		ON 	TT.ID_date = ST.ID_date
		AND	TT.ID_time = ST.ID_time
		AND	TT.ID_skipass = ST.ID_skipass
		AND	TT.ID_lift = ST.ID_lift
		AND TT.ID_junk = ST.ID_junk
		AND	TT.Scan_no = ST.Scan_no 
		AND	TT.Skier_age = ST.Skier_age
		AND	TT.Lift_length = ST.Lift_length
			WHEN Not Matched
				THEN
					INSERT
					Values (
						ST.ID_date,
						ST.ID_time,
						ST.ID_skipass,
						ST.ID_lift,
						ST.ID_junk,
						ST.Scan_no,
						ST.Skier_age,
						ST.Lift_length				
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

GO
--Drop view vETLFTicket_scan;
--DELETE FROM TICKET_SCAN

--SELECT TOP 100 * FROM TICKET_SCAN
--SELECT TOP 10 * FROM SKIPASS





