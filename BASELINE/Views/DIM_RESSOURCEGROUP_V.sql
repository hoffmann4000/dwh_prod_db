ALTER VIEW [BASELINE].[DIM_RESSOURCEGROUP_V]
--THE PURPOSE OF THIS VIEW IS TO CREATE THE SOURCE FOR THE MERGE PROCEDURE REPORTING.UPDATE_DIM_RESSOURCEGROUP
	AS
	
	SELECT 
	[NO_] AS RESSOURCEGROUP_ID,
	[NAME] AS RESSOUCEGROUP_NAVN,
	[TYPE] AS RESSOURCEGROUP_TYPE,
	[BASE UNIT OF MEASURE] AS BASISENHED,
	[UNIT PRICE] AS ENHEDSPRIS,
	[GEN_ PROD_ POSTING GROUP] AS PRODUKTBOGFØRINGSGRUPPE
	FROM [NAVISION].[UNI-TEL_AS_RESOURCE];

GO


