ALTER VIEW [BASELINE].[FACT_OMSÆTNING_V]
AS
(
SELECT 
--DIM REFERENCES 
-- [Sell-to Customer No_] er nvchar i kilden
CASE
		WHEN ISNUMERIC([Sell-to Customer No_])=1 THEN CAST ([Sell-to Customer No_] as int) 
		WHEN LOWER([Sell-to Customer No_]) = 'FIRSTCOM' THEN 18
		ELSE null 
		END AS KUNDE_ID,
CAST (N.[No_] AS INT) AS RESSOURCEGROUP_ID,
EOMONTH(N.[Posting Date]) AS DATE_ID,

--ATTRIBUTS
N.[Line No_] AS LINJE_NR,
--Posting Date is used here as apposed to shipment date (used by isaksen)
N.[Posting Date] AS BOGFØRINGSDATO, 
N.[Document No_] AS FAKTURA_NR,
N.[Description] AS BESKRIVELSE,
N.[Line Discount _] AS LINJE_RABAT,
N.[Line Discount Amount] AS LINJE_RABAT_BELØB,
N.[load_dato] AS LOAD_DATO,

--MEASURES 
N.Quantity AS ANTAL_ENHEDER, 
N.[Unit Price] AS ENHEDSPRIS,
N.[Amount] AS BELØB_EKSKL_MOMS
FROM navision.[Uni-tel_AS_Sales_Invoice_Line] N
)
GO
