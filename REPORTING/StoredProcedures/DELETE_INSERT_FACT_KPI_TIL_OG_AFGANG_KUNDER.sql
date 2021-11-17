ALTER  PROCEDURE [REPORTING].[DELETE_INSERT_FACT_KPI_TIL_OG_AFGANG_KUNDER]
AS 
BEGIN
IF OBJECT_ID('REPORTING.FACT_KPI', 'U') IS NOT NULL 

PRINT 'Rows are deleted in REPORTING.FACT_KPI for two KPIs - Tilgang og afgang af kunder - number of added and departing customers';

	DELETE FROM REPORTING.FACT_KPI WHERE KPI_ID in (73, 72);
		
PRINT 'the KPI for number of added customers "Tilgang af kunder" is inserted into REPORTING.FACT_KPI';
	
	INSERT INTO REPORTING.FACT_KPI (REALISERET, FORHANDLER_ID, DATE_ID, KPI_ID)
	SELECT 
	TILGANG_KUNDER AS REALISERET,
	A.FORHANDLER_ID,
	T.LASTDAYOFMONTH as DATE_ID, 
	72 AS KPI_ID
	FROM BASELINE.LASTDAYOFMONTH_ONE_YEAR_BACK T  
	INNER JOIN   
		(
		SELECT COUNT(DISTINCT K.KUNDE_ID) AS TILGANG_KUNDER, EOMONTH(K.KUNDESTARTDATO) AS LAST_DAY_OF_MONTH_DT,  K.FORHANDLER_ID
		FROM REPORTING.DIM_KUNDE K
		GROUP BY EOMONTH(KUNDESTARTDATO), K.FORHANDLER_ID
		) A 
	ON T.LASTDAYOFMONTH=A.LAST_DAY_OF_MONTH_DT;

PRINT 'the KPI for number of departing customers "Afgang af kunder" is inserted into REPORTING.FACT_KPI';
	INSERT INTO REPORTING.FACT_KPI (REALISERET, FORHANDLER_ID, DATE_ID, KPI_ID)
	
		SELECT 
		AFGANG_KUNDER AS REALISERET,
		A.FORHANDLER_ID,
		T.LASTDAYOFMONTH as DATE_ID, 
		73 AS KPI_ID
		FROM BASELINE.LASTDAYOFMONTH_ONE_YEAR_BACK T  
			INNER JOIN   
				(
				SELECT COUNT (DISTINCT K.KUNDE_ID) AS AFGANG_KUNDER, EOMONTH(KUNDESLUTDATO) AS LAST_DAY_OF_MONTH_DT, K.FORHANDLER_ID
				FROM REPORTING.DIM_KUNDE K
				WHERE UPPER(KUNDENAVN) NOT LIKE '%KONKURS%'
				GROUP BY EOMONTH(KUNDESLUTDATO), k.FORHANDLER_ID
				) A 
		ON T.LASTDAYOFMONTH=A.LAST_DAY_OF_MONTH_DT;
/*
Christian 2021-01-17
Incoming customers is a simple count of distinct customers per. dealer per. month based on the field ADMIN.CUST.CREATED is displayed in REPORTING.DIM_KUNDE
Departure of customers is calculated by looking down in REPORTING.DIM_KUNDE, where basic data is made up of the table ADMIN.CHURN, which supplements admin.cust with a customer end date after 1.1.2016 */
END;


