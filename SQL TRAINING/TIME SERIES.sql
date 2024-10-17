SELECT MAX(datetimekey) FROM [dbo].[rwind]
SELECT MAX(datetimekey) FROM [dbo].[twind]

DECLARE @RMAXDATE DATETIME
DECLARE @TMAXDATE DATETIME
SELECT @RMAXDATE = MAX(datetimekey) FROM [dbo].[rwind]
SELECT @TMAXDATE = MAX(datetimekey) FROM [dbo].[twind]

CREATE TABLE #TIME
	(TimeSeries DATETIME) 

WHILE @RMAXDATE > @TMAXDATE
BEGIN
    INSERT INTO #TIME 
    VALUES (@TMAXDATE)
    SET @TMAXDATE = DATEADD(MINUTE, 10, @TMAXDATE)
END

SELECT flidarid, TimeSeries FROM #TIME 
CROSS JOIN [dbo].[rwind] 

DROP TABLE #TIME





