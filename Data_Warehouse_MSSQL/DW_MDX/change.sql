--DROP TABLE LIFT_STATUS_CHANGE
use SkiBase;
go


If (object_id('dbo.DFSC2Temp') is not null) DROP TABLE dbo.DFSC2Temp;
CREATE TABLE dbo.DFSC2Temp(idChange bigint, idLiftChange bigint, dateChange date, dateTo date ,statusLift varchar(50), applicationStatus varchar(50));
go

BULK INSERT dbo.DFSC2Temp
    FROM 'C:\Users\user\Desktop\T-SQL_SKI_DW_v2\DFSC4.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    )
	;
--SELECT * FROM DFSC2Temp

If (object_id('vETLLift_status_change') is not null) Drop View vETLLift_status_change;
go

CREATE VIEW vETLLift_status_change
AS
SELECT
	tmp1.idLiftChange as [ID_lift],
	SD.ID_date as ID_Date_from,
	DTT.ID_date as ID_Date_to,
	ST.ID_status as ID_status

	FROM dbo.DFSC2Temp as tmp1
	JOIN SkiBase.dbo.[STATUS] as ST ON tmp1.statusLift = ST.[Status_description]
	JOIN SkiBase.dbo.[DATE] as SD ON CONVERT(VARCHAR(10), SD.[Date],111) = CONVERT(VARCHAR(10), tmp1.[dateChange],111)
	JOIN SkiBase.dbo.[DATE] as DTT ON CONVERT(VARCHAR(10), DTT.[Date],111) = CONVERT(VARCHAR(10), tmp1.[dateTo],111)
	;
GO
--SELECT * FROM vETLLift_status_change
--ORDER BY ID_lift

--SELECT * FROM [DATE]

MERGE INTO [LIFT_STATUS_CHANGE] as TT
	USING vETLLift_status_change as ST
		ON	TT.ID_lift = ST.ID_lift
		AND TT.ID_Date_from = ST.ID_Date_from
		AND	TT.ID_Date_to = ST.ID_Date_to
		AND	TT.ID_status = ST.ID_status
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.ID_lift,
					ST.ID_Date_from,
					ST.ID_Date_to,
					ST.ID_status
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;
GO
--SELECT TOP 10 * FROM LIFT_STATUS_CHANGE

--Drop view vETLLift_status_change;


