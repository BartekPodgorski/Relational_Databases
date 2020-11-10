INSERT INTO [dbo].[STATUS] 
SELECT lift 
FROM 
	  (
		VALUES 
			  ('active')
			, ('inactive')
	  ) 
	AS [Status_description](lift);

GO