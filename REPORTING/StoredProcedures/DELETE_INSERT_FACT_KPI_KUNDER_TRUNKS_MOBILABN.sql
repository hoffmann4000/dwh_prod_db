ALTER PROCEDURE [REPORTING].[DELETE_INSERT_FACT_KPI_KUNDER_TRUNKS_MOBILABN]
AS 
BEGIN

IF OBJECT_ID('REPORTING.FACT_KPI', 'U') IS NOT NULL 

PRINT('Existing data is deleted from REPORTING.FACT_KPI for the three KPIs: Antal fastnetnure, antal kunder og antal mobilabonnementer');
	DELETE FROM REPORTING.FACT_KPI WHERE KPI_ID in (1,70,71) 
	
PRINT('The KPI "Antal fastnetnumre" is inserted into REPORTING.FACT_KPI');
	INSERT INTO REPORTING.FACT_KPI (REALISERET, FORHANDLER_ID, DATE_ID, KPI_ID)
	
	SELECT 
	TRUNKNUMBER AS REALISERET, F_ID AS FORHANDLER_ID, RDATE AS DATE_ID, 1 AS KPI_ID 
	FROM ADMIN.CUSTSTATS CS
	INNER JOIN BASELINE.LASTDAYOFMONTH_ONE_YEAR_BACK D ON CS.RDATE=D.LASTDAYOFMONTH;

PRINT('The KPI "Antal kunder" is inserted into REPORTING.FACT_KPI');
	INSERT INTO REPORTING.FACT_KPI (REALISERET, FORHANDLER_ID, DATE_ID, KPI_ID)
	SELECT 
	CUSTNUMBER AS REALISERET, F_ID AS FORHANDLER_ID, RDATE AS DATE_ID, 70 AS KPI_ID
	FROM ADMIN.CUSTSTATS CS
	INNER JOIN BASELINE.LASTDAYOFMONTH_ONE_YEAR_BACK D ON CS.RDATE=D.LASTDAYOFMONTH;
	
PRINT('The KPI "Antal mobilabonnementer" is inserted into REPORTING.FACT_KPI');

	INSERT INTO REPORTING.FACT_KPI (REALISERET, FORHANDLER_ID, DATE_ID, KPI_ID)
	SELECT 
	MOBILNUMBER AS REALISERET, F_ID AS FORHANDLER_ID, RDATE AS DATE_ID, 71 AS KPI_ID
	FROM ADMIN.CUSTSTATS CS
	INNER JOIN BASELINE.LASTDAYOFMONTH_ONE_YEAR_BACK D ON CS.RDATE=D.LASTDAYOFMONTH;
/*
The datasource is admin.custstats that is populated every day using the SQL below. 
The datasource is selecd as it has 10 years of snapshot-history that can not be recreated

REPLACE INTO custstats (f_id,rdate,custnumber,trunknumber, mobilnumber) (
            SELECT 
                f.f_id,
                CURRENT_DATE() as rdate,
                COUNT(DISTINCT c.custid) AS custnumber, 
                COUNT(DISTINCT t.username) AS trunknumber, 
                COUNT(DISTINCT m.did) AS mobilenumber
            FROM forhandlere f
            INNER JOIN cust c ON c.forhandlerid = f.f_id
            LEFT JOIN trunk t ON t.cust = c.custid
            LEFT JOIN mobil_abn m ON m.cust = c.custid AND m.status = 3
            WHERE c.active = 1
            GROUP BY f.f_id
            )
*/
END;

