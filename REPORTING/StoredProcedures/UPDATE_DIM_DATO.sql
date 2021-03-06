
CREATE PROCEDURE [REPORTING].[UPDATE_DIM_DATO]
AS
BEGIN
IF OBJECT_ID('REPORTING.DIM_DATO', 'U') IS NOT NULL 

TRUNCATE TABLE REPORTING.DIM_DATO;

INSERT INTO REPORTING.DIM_DATO 
(
	DATE,
	DAYOFMONTH,
	DAYNAME,
	DAYOFWEEKUK,
	MONTH,
	MONTHNAME,
	QUARTER,
	YEAR,
	LASTDAYOFMONTH,
	FIRSTDAYOFMONTH,
	ISHOLIDAYDK,
	FISCALYEAR,
	FISCALYEARTEXT,
	FISCALYEARSTART,
	FISCALYEAREND
) 
SELECT
	DATE,
	DAYOFMONTH,
	DAYNAME,
	DAYOFWEEKUK,
CAST(MONTH as tinyint) as MONTH,
	MONTHNAME,
	QUARTER,
	YEAR,
	LASTDAYOFMONTH,
	FIRSTDAYOFMONTH,
	ISHOLIDAYDK,
	FISCALYEAR,
	FISCALYEARTEXT,
	FISCALYEARSTART,
	FISCALYEAREND
FROM
    BASELINE.DIM_DATO
END;

GO

