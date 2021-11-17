CREATE PROCEDURE [REPORTING].[UPDATE_FACT_KPI_HPBX_SIP_BRUGERE]
AS 
BEGIN
IF OBJECT_ID('REPORTING.FACT_KPI', 'U') IS NOT NULL 

PRINT 'Updates the KPI "One-Connect SIP-enablede brugere" in the table REPORTING.FACT_KPI';

MERGE REPORTING.FACT_KPI T
	USING 
	(
	SELECT 
	SUM(SIP) AS REALISERET,
	EXTERNAL_PARTNER_ID AS FORHANDLER_ID,
	DATO AS DATE_ID,
	76 AS KPI_ID	
	
	FROM BASELINE.HPBX_STATS 
	
	WHERE DATO IN (SELECT LASTDAYOFMONTH FROM BASELINE.LASTDAYOFMONTH_ONE_YEAR_BACK)
	
	GROUP BY EXTERNAL_PARTNER_ID, DATO

	) S
	
	ON (S.FORHANDLER_ID=T.FORHANDLER_ID AND S.DATE_ID=T.DATE_ID AND S.KPI_ID=T.KPI_ID)

WHEN MATCHED 
	THEN UPDATE SET 
		T.REALISERET = S.REALISERET 

WHEN NOT MATCHED 
	THEN INSERT (REALISERET, FORHANDLER_ID, DATE_ID, KPI_ID)
	VALUES (S.REALISERET, S.FORHANDLER_ID, S.DATE_ID, S.KPI_ID);
	
END;

GO

