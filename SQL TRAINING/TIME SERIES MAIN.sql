-- DECLARING VARIABLES
DECLARE @ID VARCHAR(20) 
DECLARE @RowCount INT
DECLARE @Counter INT
DECLARE @MaxDateTwind DATETIME
DECLARE @MaxDateRwind DATETIME

-- Create a temporary table to store the flidarid's that are not updated
DECLARE @Temp TABLE(
    SNO INT IDENTITY(1,1),
    FLIDARID VARCHAR(20)
)

-- Insert distinct values from the column into the temporary table where transflag = 0
INSERT INTO @Temp(FLIDARID)
SELECT DISTINCT flidarid FROM rwind WHERE transflag = 0

-- Get the total number of rows in the #Temp table
SELECT @RowCount = COUNT(*) FROM @Temp

-- Initialize the counter
SET @Counter = 0

-- Create a table to store the final results
declare @Dates TABLE  (
    FLIDARID VARCHAR(20),
    DateInterval DATETIME
)

-- Start looping through the values
WHILE @Counter <= @RowCount 
BEGIN
-- Retrieve the value from the temporary table based on the counter
    SELECT @ID = FLIDARID FROM @Temp WHERE SNO = @Counter

-- Retrieve the maximum datetime from twind for the current flidarid
    SET @MaxDateTwind = (
            SELECT CASE 
            WHEN (SELECT MAX(datetimekey) FROM twind WHERE flidarid = @ID) IS NOT NULL
            THEN (SELECT MAX(datetimekey) FROM twind WHERE flidarid = @ID)
            ELSE (SELECT MIN(datetimekey) FROM rwind WHERE flidarid = @ID AND transflag = 0)
        END)

-- Retrieve the maximum datetime from rwind for the current flidarid
    SET @MaxDateRwind = (SELECT MAX(datetimekey) FROM rwind WHERE flidarid = @ID AND transflag = 0)

-- Calculate dates in 10-minute intervals
    WHILE @MaxDateRwind >= @MaxDateTwind 
    BEGIN
-- Insert the current date into the result table
        INSERT INTO @Dates (FLIDARID, DateInterval)
        VALUES (@ID, @MaxDateTwind)

-- Update the current date based on the condition
 SET @MaxDateTwind = DATEADD(MINUTE, 10, @MaxDateTwind)
    END

    -- Increment the counter
    SET @Counter = @Counter + 1
END
SELECT * FROM @Dates


