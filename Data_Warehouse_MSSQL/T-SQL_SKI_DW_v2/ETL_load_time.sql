use SkiBase
go

-- Fill TIME Lookup Table
-- Step a: Declare variables use in processing
Declare @StartTime time; 
Declare @EndTime time;

-- Step b:  Fill the variable with values for the range of years needed
SELECT @StartTime = '00:00:00', @EndTime = '23:59:59';

-- Step c:  Use a while loop to add times to the table
Declare @TimeInProcess time = @StartTime; --zamiast datetime dalismy time

While @TimeInProcess <= @EndTime
	Begin
	--Add a row into the date dimension table for this date
		Insert Into [dbo].[TIME] 
		( [Hour]
		, [Minute]
		, [Second]
		, [Time_of_day]
		)
		Values ( 		
		    Cast( DATEPART(hour, @TimeInProcess) as varchar(2)) -- [Hour]
		  , Cast( DATEPART(minute, @TimeInProcess) as varchar(2)) -- [Minute]
		  , Cast( DATEPART(second, @TimeInProcess) as varchar(2)) -- [Second]
		  , CASE
				WHEN DATEPART(hour,@TimeInProcess) < 8 THEN 'between 0 and 8'
				WHEN DATEPART(hour,@TimeInProcess) >= 8 AND DATEPART(hour,@TimeInProcess) < 12 THEN 'between 8 and 12'
				WHEN DATEPART(hour,@TimeInProcess) >= 12 AND DATEPART(hour,@TimeInProcess) < 15 THEN 'between 12 and 15'
				WHEN DATEPART(hour,@TimeInProcess) >= 15 AND DATEPART(hour,@TimeInProcess) < 20 THEN 'between 15 and 20'
				ELSE 'between 20 and 23'
			END
		  -- Cast( DATEPART(hour,@TimeInProcess) as varchar(2)) -- [Time_of_day]; funkcja DATEPART zwraca okre�lon� cz�� daty jako int, u nas b�dzie to godzina. u�yjemy tego do okre�lenia przedzia�u, np. godzina druga to between 0 and 8 
		);  
		-- Add a second and loop again
		Set @TimeInProcess = DateAdd(second, 1, @TimeInProcess); --w kazdym obiegu p�tli podnosimy o 1 sekund�
		IF DATEPART(hour,@TimeInProcess) = 23 AND DATEPART(minute,@TimeInProcess) = 59 AND DATEPART(second,@TimeInProcess) = 59  BREAK; --chyba potrzebne, bo p�tla nie zatrzymuje si� przy endtime
	End
go

--SELECT TOP 100 * FROM [TIME];

--SELECT TOP 30 * FROM [TIME] WHERE [Hour]=23 AND [Minute] = 59 AND [Second]=59;

--SELECT COUNT(*) FROM [TIME];

--DELETE FROM [TIME] WHERE ID_time > 86400;
insert into TIME values(23,59,59,'between 20 and 23')