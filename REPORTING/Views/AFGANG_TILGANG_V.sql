ALTER VIEW [REPORTING].[AFGANG_TILGANG_V]
AS
/*
CHRISTIAN 09.11.2021
THE DATA IN THE WEB IS TO BE USED IN THE KPI_WEBSITE FOR THE PARTNERS "NØGLETAL"
THE INPUT PARAMETER HERE IS FORHANDLER_ID
THE TIMEFRAME IS SET TO THIS YEAR AND PREVIOUS YEAR BY AGGREMENT WITH PRODUCT MANAGER
*/
SELECT AFGANG, TILGANG, KUNDE_ID, KUNDENAVN, KUNDESTARTDATO, KUNDESLUTDATO, FORHANDLER_ID, FORHANDLERNAVN 
FROM 
(
SELECT KUNDE_ID, KUNDENAVN, KUNDESTARTDATO, KUNDESLUTDATO, FORHANDLER_ID, FORHANDLERNAVN, 

CASE 
	WHEN K.KUNDESLUTDATO BETWEEN
	(
	SELECT DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) - 1, 0)
	)
	AND 
	GETDATE() THEN 1
	ELSE 0 

	END AS AFGANG,

CASE 
	WHEN K.KUNDESTARTDATO BETWEEN 
	(
	SELECT DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) - 1, 0)
	)
	AND 
	GETDATE() THEN 1
	ELSE 0

END AS TILGANG

FROM REPORTING.DIM_KUNDE K
WHERE UPPER(KUNDENAVN) NOT LIKE '%KONKURS%'
) I

WHERE I.AFGANG=1 OR I.TILGANG=1



