CREATE PROCEDURE [BASELINE].[HISTORISK_LOAD_HBPX_STATS_MERGE_SLOW]
/* 
Loader historiske og aktuelle data fra [statistics].[hpbx_stats] til det persistente lag i BASELINE.HPBX_STATS (tabel)
Procedure [BASELINE].[HPBX_STATS_PROC] fylder daglige data ind i BASELINE.HPBX_STATS 
Dataindlæsningens sidste led er i fire procedurer i REPORTING-skemaet, som populerer tabellen REPORTING.FACT_KPI
*/
AS

MERGE BASELINE.HPBX_STATS T --target table 
USING 
	--source table
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
		
	) I
	WHERE I.RN=1

	) AS S

--MERGE CONDITION
ON 
S.WHITELABEL=T.WHITELABEL 
AND S.DATO=T.DATO 
AND T.EXTERNAL_PARTNER_ID=T.EXTERNAL_PARTNER_ID

WHEN MATCHED 
	THEN UPDATE SET 
	T.PARTNER_NAME=S.PARTNER_NAME,
	T.PBX=S.PBX,
	T.USERS=S.USERS,
	T.SIP=S.SIP,
	T.MOBIL=S.MOBIL,
	T.WHITELABEL=S.WHITELABEL, 
	T.DATO=S.DATO, 
	T.EXTERNAL_PARTNER_ID=S.EXTERNAL_PARTNER_ID

WHEN NOT MATCHED BY TARGET
	THEN INSERT (PARTNER_NAME, PBX, USERS, SIP, MOBIL, WHITELABEL, DATO, EXTERNAL_PARTNER_ID)
	VALUES (S.PARTNER_NAME, S.PBX, S.USERS, S.SIP, S.MOBIL, S.WHITELABEL, S.DATO, S.EXTERNAL_PARTNER_ID)
	;

GO

