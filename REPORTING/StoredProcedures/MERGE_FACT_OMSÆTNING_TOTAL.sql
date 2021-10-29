CREATE PROCEDURE MERGE_FACT_OMSÆTNING_TOTAL
AS
BEGIN
IF OBJECT_ID('REPORTING.FACT_OMSÆTNING_TOTAL', 'U') IS NOT NULL 

PRINT ('MERGE_FACT_OMSÆTNING_TOTAL');

MERGE [REPORTING].[FACT_OMSÆTNING_TOTAL] T
--THE PURPOST IS TO GENERATE A TABLE WITH TOTAL REVENUE (REALIZED VALUE) AND THE BUDGET (TARGET)
USING
(
SELECT NULL AS BUDGET, CAST (ROUND (SUM(BELØB_EKSKL_MOMS),0) AS BIGINT) AS OMSÆTNING, DATE_ID 
FROM REPORTING.FACT_OMSÆTNING
GROUP BY DATE_ID
) S
ON S.DATE_ID=T.DATE_ID
WHEN MATCHED THEN UPDATE SET 
T.BUDGET=S.BUDGET,
T.OMSÆTNING=S.OMSÆTNING

WHEN NOT MATCHED 
THEN INSERT
(BUDGET, OMSÆTNING, DATE_ID)
VALUES 
(BUDGET, OMSÆTNING, DATE_ID)
;
