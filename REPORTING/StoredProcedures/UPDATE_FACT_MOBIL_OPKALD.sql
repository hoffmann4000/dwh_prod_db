CREATE PROCEDURE [REPORTING].[UPDATE_FACT_MOBIL_OPKALD]
AS

DECLARE
@ERRORMESSAGE VARCHAR(MAX),
@ERRORSEVERITY VARCHAR(MAX),
@ERRORSTATE VARCHAR(MAX);

BEGIN

BEGIN TRY

	IF OBJECT_ID('REPORTING.FACT_MOBIL_OPKALD', 'U') IS NOT NULL 

	PRINT ('MERGE KØRES REPORTING.FACT_MOBIL_OPKALD');

	MERGE REPORTING.FACT_MOBIL_OPKALD AS T

	USING 
		(
		SELECT
		DATE_ID, 
		ABONNEMENT_ID, 
		INVOICEGROUP_ID,
		KUNDE_ID, 
		PRODUCT_ID,
		ANTAL_UDGAAENDE_OPKALD,
		VARIGHED_TIMER,
		PRIS,
		OMKOSTNING,
		LOAD_DATE
		FROM BASELINE.FACT_MOBIL_OPKALD_V 
		) 
	AS S	

	ON (T.ABONNEMENT_ID=S.ABONNEMENT_ID AND T.DATE_ID=S.DATE_ID AND T.INVOICEGROUP_ID=S.INVOICEGROUP_ID)

	WHEN MATCHED THEN UPDATE 
	SET 
	T.KUNDE_ID=S.KUNDE_ID,
	T.PRODUCT_ID=S.PRODUCT_ID,	
	T.ANTAL_UDGAAENDE_OPKALD=S.ANTAL_UDGAAENDE_OPKALD,
	T.VARIGHED_TIMER=S.VARIGHED_TIMER,	
	T.PRIS=S.PRIS,	
	T.OMKOSTNING=S.OMKOSTNING,
	T.LOAD_DATE=S.LOAD_DATE

	WHEN NOT MATCHED THEN INSERT
	(
	DATE_ID, 
	ABONNEMENT_ID, 
	INVOICEGROUP_ID,
	KUNDE_ID, 
	PRODUCT_ID,
	ANTAL_UDGAAENDE_OPKALD,
	VARIGHED_TIMER,
	PRIS,
	OMKOSTNING,
	LOAD_DATE
	)
	VALUES
	(
	S.DATE_ID, 
	S.ABONNEMENT_ID, 
	S.INVOICEGROUP_ID,
	S.KUNDE_ID, 
	S.PRODUCT_ID,
	S.ANTAL_UDGAAENDE_OPKALD,
	S.VARIGHED_TIMER,
	S.PRIS,
	S.OMKOSTNING,
	S.LOAD_DATE);

END TRY

BEGIN CATCH 
	SET @ERRORMESSAGE  = ERROR_MESSAGE()
    SET @ERRORSEVERITY = ERROR_SEVERITY()
    SET @ERRORSTATE    = ERROR_STATE()
    RAISERROR(@ERRORMESSAGE, @ERRORSEVERITY, @ERRORSTATE)
    

END CATCH

END

GO

