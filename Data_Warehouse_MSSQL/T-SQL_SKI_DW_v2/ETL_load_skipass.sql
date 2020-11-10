USE SkiBase
GO

If (object_id('vETLSkipassData') is not null) Drop View vETLSkipassData;
go
CREATE VIEW vETLSkipassData
AS
SELECT DISTINCT
	[client_id] as [ID_client],
	[range_of_skipass] as [range_of_skipass],
	[classification_number] as [Skipass_no],
	CASE
		WHEN [price] <= 60 THEN ' very cheap'
		WHEN [price] BETWEEN 61 AND 100 THEN 'cheap'
		WHEN [price] BETWEEN 101 AND 200 THEN 'medium'
		WHEN [price] BETWEEN 201 AND 300 THEN 'expensive'
		ELSE 'very expensive'
	END AS [Price_category]
FROM [SKI_CENTER].dbo.[SKIPASS]
JOIN [SKI_CENTER].dbo.[SKIPASS_TYPE] on [SKI_CENTER].dbo.[SKIPASS_TYPE].[skipass_type_id] = [SKI_CENTER].dbo.[SKIPASS].[skipass_type_id]
JOIN [SKI_CENTER].dbo.[PRICE_LIST] on [SKI_CENTER].dbo.[PRICE_LIST].[skipass_type_id] = [SKI_CENTER].dbo.[SKIPASS_TYPE].[skipass_type_id];
;
go

--SELECT TOP 100 * FROM vETLSkipassData;

MERGE INTO SKIPASS as TT
	USING vETLSkipassData as ST
		ON TT.Skipass_no = ST.Skipass_no
			WHEN Not Matched
				THEN
					INSERT
					Values (
					ST.ID_client,
					ST.range_of_skipass,
					ST.Skipass_no,
					ST.Price_category
					)
			WHEN Not Matched By Source
				Then
					DELETE
			;

GO
--Drop View vETLSkipassData;
--SELECT TOP 100 * FROM SKIPASS
--UPDATE SKIPASS SET ID_skipass = 1 WHERE ID_skipass = 59999

