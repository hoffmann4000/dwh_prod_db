ALTER PROCEDURE [REPORTING].[MERGE_DIM_PARTNER]
AS
BEGIN
	IF OBJECT_ID('REPORTING.DIM_PARTER', 'U') IS NOT NULL 

	PRINT ('Merge REPORTING.DIM_PARTNER')

	MERGE REPORTING.DIM_PARTNER T
		USING
		(
		SELECT -1 AS PARTNER_ID, 'Ukendt/Blank' AS PARTNER_NAME, null as PARTNER_CVR, null as PARTNER_ACTIVE, null as PARTNER_HPBX, null as PARTNER_CLASS 
		
		UNION 
		
		SELECT 999 AS PARTNER_ID, 'Uni-Tel A/S i alt' AS PARTNER_NAME, null as PARTNER_CVR, null as PARTNER_ACTIVE, null as PARTNER_HPBX, null as PARTNER_CLASS 

		UNION 

		SELECT 
		PARTNER_ID, 
		PARTNER_NAME,
		PARTNER_CVR, 
		PARTNER_ACTIVE, 
		PARTNER_HPBX, 
		PARTNER_CLASS 
		FROM BASELINE.DIM_PARTNER_V
		) S

		ON T.PARTNER_ID=S.PARTNER_ID

	WHEN MATCHED THEN 
	   UPDATE SET 
		T.PARTNER_NAME=S.PARTNER_NAME,
		T.PARTNER_CVR=S.PARTNER_CVR,
		T.PARTNER_ACTIVE=S.PARTNER_ACTIVE, 
		T.PARTNER_HPBX=S.PARTNER_HPBX, 
		T.PARTNER_CLASS=S.PARTNER_CLASS
		  
	WHEN NOT MATCHED THEN 
	   INSERT VALUES
	   (
		S.PARTNER_ID,
		S.PARTNER_NAME,
		S.PARTNER_CVR,
		S.PARTNER_ACTIVE, 
		S.PARTNER_HPBX, 
		S.PARTNER_CLASS
		)
	; 
	
END;