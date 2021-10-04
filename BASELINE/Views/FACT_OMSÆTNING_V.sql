ALTER VIEW [BASELINE].[FACT_OMSÆTNING_V]
AS
(
SELECT 
N.[Line No_] AS LINJE_NR,
CAST (N.[Posting Date] AS DATE) AS BOGFØRINGSDATO, 
DATEADD (D, 14, CAST (N.[Posting Date] AS DATE)) AS BETALINGSFRIST,
N.[Document No_] AS FAKTURA_NR,
N.DESCRIPTION AS BESKRIVELE,
-- [Sell-to Customer No_] er nvchar i kilden
case
		when ISNUMERIC([Sell-to Customer No_])=1 then cast ([Sell-to Customer No_] as int) 
		when lower([Sell-to Customer No_]) = 'FIRSTCOM' then 18
		else null 
		end as KUNDE_ID,
N.[NO_ ] AS RESSOURCEGROUP_ID,
CAST (N.Quantity AS DECIMAL (38,20)) AS ANTAL_ENHEDER, 
CAST (N.[Unit Price] AS DECIMAL (38,20)) AS ENHEDSPRIS,
CAST (N.Quantity AS DECIMAL (38,20)) * CAST (N.[Unit Price] AS DECIMAL (38,20)) AS BELØB_EKSKL_MOMS,
N.[Line Discount _] as LINJE_RABAT,
N.[Line Discount Amount] as LINJE_RABAT_BELØB,
N.[load_dato]
FROM navision.[Uni-tel_AS_Sales_Invoice_Line] N
)
GO


