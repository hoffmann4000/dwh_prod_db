CREATE VIEW [BASELINE].[DIM_KUNDE_V]
AS
(
SELECT 
--KUNDE DATA
--BÅDE AKTIVE OG INAKTIVE KUNDER ER MEDTAGET
CAST(C.CUSTID AS integer) AS KUNDE_ID, C.ACTIVE AS KUNDEAKTIV, C.CVR AS KUNDECVR, 
C.NAVN AS KUNDENAVN, C.POSTNR AS KUNDEPOSTNR, C.BYNAVN AS KUNDEBYNAVN,
CASE WHEN C.POSTAL_COUNTRY_ID=1 THEN 1 ELSE NULL END AS DANMARK,
CASE WHEN RYKKERKODE IN ('KONKURS', 'INKASSO', 'DUBIØS') THEN 1 ELSE 0 END AS KONKURS_INKASSO_DUBIØS,
C.CREATED AS KUNDESTARTDATO,
--KUNDE CHURN DATA
S.CHURN_DATE AS KUNDESLUTDATO, 
--FORHANDLER DATA
F_ID AS FORHANDLERID,
F.NAVN AS FORHANDLERNAVN,
F.CVR AS FORHANDLERCVR,
F.AKTIV AS FORHANDLERAKTIV, 
FS.VAL AS FORHANDLERKLASSE,
--FORHANDLER HOVEDKVARTER DATA
H.POSTNR AS FORHANDLERPOSTNR,
cast (H.LAT as nvarchar(32)) AS FORHANDLERLATTITUDE,
cast (H.LNG as nvarchar(32)) AS FORHANDLERLONGITUDE,
H.FORHANDLER_HQ_KOMKODE AS FORHANDLERKOMMUNE
--#FORHANDLERBYNAVN		
FROM ADMIN.CUST C
LEFT JOIN ADMIN.FORHANDLERE F ON C.FORHANDLERID=F.F_ID
LEFT JOIN BASELINE.FORHANDLER_HOVEDKONTOR_V H ON C.FORHANDLERID=H.FORHANDLER_ID
LEFT JOIN (SELECT DISTINCT (FORHANDLERID), SETTING, VAL FROM ADMIN.FORHANDLERSETTINGS WHERE SETTING='partner_class')  FS ON C.FORHANDLERID=FS.FORHANDLERID
LEFT JOIN BASELINE.CHURN_V S ON C.CUSTID=S.CUST_ID 
);
GO


