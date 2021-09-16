CREATE PROCEDURE [BASELINE].[LOAD_HBPX_STATS]
/* 
Loader historiske kildedata fra [statistics].[hpbx_stats] til det persistente lag i BASELINE.HPBX_STATS (tabel)
Procedure [BASELINE].[HPBX_STATS_PROC] fylder daglige data ind i BASELINE.HPBX_STATS 
Dataindlæsningens sidste led er i fire procedurer i REPORTING-skemaet, som populerer tabellen REPORTING.FACT_KPI
*/
AS

TRUNCATE TABLE BASELINE.HPBX_STATS;

INSERT INTO BASELINE.HPBX_STATS (PARTNER_NAME, PBX, USERS, SIP, MOBIL, WHITELABEL, DATO, EXTERNAL_PARTNER_ID)
(
SELECT PARTNER_NAME, PBX, USERS, SIP, MOBIL, WHITELABEL, DATO, EXTERNAL_PARTNER_ID 
FROM  
--DUBLET RENS I HISTORISKE DATA
	(
	SELECT PARTNER_NAME, PBX, USERS, SIP, MOBIL, WHITELABEL, DATO, EXTERNAL_PARTNER_ID, 
	ROW_NUMBER() OVER (PARTITION BY EXTERNAL_PARTNER_ID, WHITELABEL, DATO ORDER BY DATO DESC) AS RN
	FROM [STATISTICS].HPBX_STATS 
	--DATA RENS I KILDEDATA, HVOR DER ER DUBLETTER AF UK EXTERNAL_PARTENER_ID+DATO
	WHERE 
	DATO IS NOT NULL
	AND EXTERNAL_PARTNER_ID IS NOT NULL
	AND WHITELABEL IS NOT NULL
	) A
WHERE A.RN=1
)
