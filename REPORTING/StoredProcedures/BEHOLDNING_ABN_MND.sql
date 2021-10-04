ALTER PROCEDURE [REPORTING].[TRUNC_INSERT_BEHOLDNING_ABN_MND]
AS

DROP TABLE REPORTING.BEHOLDNING_ABN_MND;

--CHR. 27.9.2021 USIKKERHEDEN I TALLENE BESTÅR I, AT DEN AKTUELLE ABONNOMENTSTYPE (FX DK-STOR) VISES
--DA KUNDERNE KAN SKIFTE ABONNOMENT OVER TID SES DER ALENE PÅ AKTULLE OG FORRIGE ÅR. 
SELECT 
V.ABN_NAVN AS ABONNOMENT, 
YEAR(V.DATE_ID) AS ÅR, 
MONTH(V.DATE_ID) AS MÅNED,
V.DATE_ID AS DATO,
COUNT(DISTINCT V.ABN_ID) AS ANTAL_ABONNOMENTER, 
COUNT(DISTINCT V.ABN_ID)-LAG (COUNT(DISTINCT V.ABN_ID)) OVER (PARTITION BY V.ABN_NAVN ORDER BY YEAR(DATE_ID), MONTH(V.DATE_ID) ASC) AS NETTO_VAEKST_ABSOLUT,
COUNT(DISTINCT V.ABN_ID)/LAG (COUNT(DISTINCT V.ABN_ID)) OVER (PARTITION BY V.ABN_NAVN ORDER BY YEAR(DATE_ID) * 100, MONTH(V.DATE_ID) ASC) AS NETTO_VAEKST_PCT
INTO REPORTING.BEHOLDNING_ABN_MND

--KILDEN ER ET VIEW SOM UDGØR EN UNION AF ADMIN.MOBIL_ABN OG ADMIN.MOBIL_ABN_OLD CROSS JOINET MED ALLE MÅNEDER I INDEVÆRENDE OG FORRIGE ÅR
FROM BASELINE.MOBIL_ABONNOMENTER_PR_MND_V V
WHERE YEAR(DATE_ID)>=YEAR(GETDATE())-1 
AND DATE_ID<=GETDATE()
GROUP BY V.ABN_NAVN, DATE_ID, YEAR(DATE_ID), MONTH(DATE_ID);
