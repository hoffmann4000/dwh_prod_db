CREATE TABLE [REPORTING].[FACT_KPI] (
    [FACT_KPI_PK]   INT             IDENTITY (0, 1) NOT NULL,
    [KPI_ID]        INT             NOT NULL,
    [FORHANDLER_ID] INT             NULL,
    [DATE_ID]       DATE            NULL,
    [Realiseret]    DECIMAL (18, 2) NULL,
    [Mål]           DECIMAL (18, 1) NULL,
    [LOAD_DATO]     DATETIME2 (0)   NULL,
    CONSTRAINT [FACT_KPI_PK] PRIMARY KEY CLUSTERED ([FACT_KPI_PK] ASC),
    CONSTRAINT [FACT_KPI_ID_FK] FOREIGN KEY ([FACT_KPI_PK]) REFERENCES [REPORTING].[FACT_KPI] ([FACT_KPI_PK]),
    CONSTRAINT [FACT_KPI_UK] UNIQUE NONCLUSTERED ([KPI_ID] ASC, [DATE_ID] ASC, [FORHANDLER_ID] ASC)
);


GO


CREATE TRIGGER REPORTING.FACT_KPI_TRIGGER_LOAD_DATO
   ON  REPORTING.FACT_KPI
   AFTER INSERT, UPDATE
AS 
BEGIN
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	UPDATE REPORTING.FACT_KPI
	SET LOAD_DATO=	(SELECT CAST (GETDATE() AS datetime2(0)))
END

GO

