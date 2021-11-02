CREATE PROCEDURE [navision].[CREATE_TABLE_TURNOVER_BUDGET]
AS
--THE PURPOSE OF THIS PROCEDURE IS TO CREATE A TABLE FOR BUDGET-TARGETS TO
--BE USED IN THE REPORTING LAYER OF DATA DATAWAREHOUSE
--BY HAVING THIS TABLE AND THIS PROCEDURE YOU CAN UPDATE THE BUDGGET-TARGETS IN CODE
--SIMPEL DROP INSERT MODEL 
BEGIN
--IF TBL NOT EXISTS
IF OBJECT_ID('navision.turnover_budget', 'U') IS NULL 

CREATE TABLE navision.turnover_budget
(
	[DATE_ID] [date] NOT NULL,
	[BUDGET] [bigint] NULL,
	[BUDGET_RUNNING_SUM] [bigint] NULL,

 CONSTRAINT [PK_TURNOVER_BUDGET] PRIMARY KEY CLUSTERED 
(
	[DATE_ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY];

IF OBJECT_ID('navision.turnover_budget', 'U') IS NOT NULL 

TRUNCATE TABLE navision.turnover_budget


INSERT INTO  navision.turnover_budget (DATE_ID, BUDGET, BUDGET_RUNNING_SUM)
VALUES
('2021-07-31', 8700000, 8700000 ),
('2021-08-31', 8600000, 17300000),
('2021-09-30', 8700000, 26000000),
('2021-10-31', 9100000, 35100000),
('2021-11-30', 9400000, 44500000),
('2021-12-31', 9100000, 53600000),
('2022-01-31', 9500000, 63100000),
('2022-02-28', 9640000, 72740000),
('2022-03-31', 9700000, 82440000),
('2022-04-30', 10000000, 92440000),
('2022-05-31', 11000000, 102540000),
('2022-06-30', 12000000, 112740000)
;

--IF TBL EXISTS
/*IF OBJECT_ID('navision.turnover_budget', 'U') IS NOT NULL 

UPDATE navision.turnover_budget SET BUDGET=8700000 WHERE DATE_ID='2021-07-31'
UPDATE navision.turnover_budget SET BUDGET=8600000 WHERE DATE_ID='2021-08-31'
UPDATE navision.turnover_budget SET BUDGET=8700000 WHERE DATE_ID='2021-09-30'
UPDATE navision.turnover_budget SET BUDGET=9100000 WHERE DATE_ID='2021-10-31'
UPDATE navision.turnover_budget SET BUDGET=9400000 WHERE DATE_ID='2021-11-30'
UPDATE navision.turnover_budget SET BUDGET=9100000 WHERE DATE_ID='2021-12-31'
UPDATE navision.turnover_budget SET BUDGET=9500000 WHERE DATE_ID='2022-01-31'
UPDATE navision.turnover_budget SET BUDGET=9640000 WHERE DATE_ID='2022-02-28'
UPDATE navision.turnover_budget SET BUDGET=9700000 WHERE DATE_ID='2022-03-31'
UPDATE navision.turnover_budget SET BUDGET=10000000 WHERE DATE_ID='2022-04-30'
UPDATE navision.turnover_budget SET BUDGET=10100000  WHERE DATE_ID='2022-05-31'
UPDATE navision.turnover_budget SET BUDGET=10200000  WHERE DATE_ID='2022-06-30'
*/
;

END;
GO

