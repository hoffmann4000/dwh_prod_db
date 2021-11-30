ALTER PROCEDURE [REPORTING].[INSERT_CHURN_SNAPSHOT]
--THE PROCEDURE CALCULATES CHURN USING THE METHODE DEVELOPED BY MR. ISAKSEN. SEE BEHOV
--THE RESULT IS STORED AS SNAPSHOT IN REPORTING.CHURN_SNAPSHOT AS THE DATA IN ADMIN.CUST AND ADMIN.CUST WILL CHANGE OVER TIME
AS
DECLARE 
@RUN_DATE DATETIME2(0),
@LAST_DAY_LAST_MONTH DATE,
@FISCAL_YEAR_START_DT DATE,
@NUMBER_OF_MONTHS_PASSED INT,
@NUMBER_OF_ACTIVE_CUSTOMERS INT,
@NUMBER_OF_OFFERS INT,
@NUMBER_OF_CHURNED_CUSTOMERS INT,
@CHURN_FIRST_DEVISION DECIMAL (20,10),
@CHURN DECIMAL (20,10)

BEGIN
--DATEPARAMETERS
SET @RUN_DATE = (SELECT GETDATE());
PRINT CONCAT('@RUN_DATE:', @RUN_DATE);

SET @LAST_DAY_LAST_MONTH=(SELECT EOMONTH(DATEADD(month, -1, Current_timestamp)));
PRINT CONCAT('@LAST_DAY_LAST_MONTH:', @LAST_DAY_LAST_MONTH);

SET @FISCAL_YEAR_START_DT=(SELECT FiscalYearStart FROM REPORTING.DIM_DATO WHERE DATE=@LAST_DAY_LAST_MONTH);
PRINT CONCAT('@FISCAL_YEAR_START_DT:', @FISCAL_YEAR_START_DT);

--CALCULATIONS
SET @NUMBER_OF_MONTHS_PASSED=
(SELECT COUNT(DISTINCT LastDayOfMonth) FROM REPORTING.DIM_DATO WHERE [Date] between @FISCAL_YEAR_START_DT and @LAST_DAY_LAST_MONTH);
PRINT CONCAT('@NUMBER_OF_MONTHS_PASSED:', @NUMBER_OF_MONTHS_PASSED);

SET @NUMBER_OF_ACTIVE_CUSTOMERS=(SELECT SUM(CUSTNUMBER) FROM ADMIN.CUSTSTATS WHERE RDATE=@LAST_DAY_LAST_MONTH);
PRINT CONCAT('@NUMBER_OF_ACTIVE_CUSTOMERS:',  @NUMBER_OF_ACTIVE_CUSTOMERS);

SET @NUMBER_OF_OFFERS=
	(
	SELECT COUNT (DISTINCT CH.CUST)
	FROM ADMIN.CHURN  CH
	LEFT JOIN ADMIN.CUST C ON C.CUSTID=CH.CUST
	WHERE CH.DT BETWEEN @FISCAL_YEAR_START_DT AND @LAST_DAY_LAST_MONTH
	AND CH.CUST NOT IN (SELECT CUSTID FROM ADMIN.TURNOVER WHERE AMOUNT>0) 
	AND C.ACTIVE=0 
	AND C.FORHANDLERID NOT IN (12,43,0)  --UNITEL, CONNECTION.DK, UNICOM.DK
	AND C.CREATED>'2015-01-01'
	AND C.CUSTID NOT IN (SELECT CUSTID FROM ADMIN.CUSTSETTINGS WHERE SETTING='BILL_TO_CUST')
	);

PRINT CONCAT(' @NUMBER_OF_OFFERS:',  @NUMBER_OF_OFFERS);

SET @NUMBER_OF_CHURNED_CUSTOMERS=
	(
	SELECT COUNT (DISTINCT CH.CUST) 
	FROM ADMIN.CHURN CH 
	LEFT JOIN ADMIN.CUST C ON C.CUSTID=CH.CUST 
	WHERE CH.DT BETWEEN @FISCAL_YEAR_START_DT AND @LAST_DAY_LAST_MONTH
	AND C.ACTIVE=0 
	AND C.FORHANDLERID<>12 --CONNECTION A/S IS REMOVED. THE PARTNER RE-DREW FROM UNI-TEL ALONG WITH ITS CUSTOMERS. SO THE RESIGNATIONS ARE FILTERED AWAY
	--NEW FILTERS BASED ON THE "KISS AND GOODBYE"  LIST NOV 11 2021 
	AND C.RYKKERKODE <> 'KONKURS' --NAV-DATA
	AND C.RYKKERKODE <> 'INKASSO' --NAV-DATA
	AND C.RYKKERKODE <> 'DUBIØS'  --NAV-DATA. BAILIFF'S COURT AMONG OTHER REASONS
	);
PRINT CONCAT('@NUMBER_OF_CHURNED_CUSTOMERS:', @NUMBER_OF_CHURNED_CUSTOMERS);

--FIRST DEVISION= (NUMBER OF CHURNED CUSTOMERS-NUMBER OF OFFCERS)  / NUMBER OF ACTIVE CUSTOMERS
SET @CHURN_FIRST_DEVISION=
(CAST (@NUMBER_OF_CHURNED_CUSTOMERS AS DECIMAL(20,10)) -CAST (@NUMBER_OF_OFFERS AS DECIMAL(20,10)))
/CAST (@NUMBER_OF_ACTIVE_CUSTOMERS AS DECIMAL (20,10));

PRINT CONCAT('@CHURN_FIRST_DEVISION:',@CHURN_FIRST_DEVISION);

--CHURN IS CALCULATED BY DIVIDING THE FIRST DEVISION BY NUMBER OF MONTHS TO GET ONE MONTH AND SIMULATE THE REST OF THE YEAR BY MULIBY WITH 12 MONTHS SHOW IN PERCENTAGE
SET @CHURN=@CHURN_FIRST_DEVISION/CAST(@NUMBER_OF_MONTHS_PASSED AS DECIMAL(20,10))*12*100
PRINT CONCAT('@CHURN:',@CHURN);

--INSERT INTO CALCULATION TABLE 
INSERT INTO REPORTING.CHURN_SNAPSHOT
(RUN_DATE,
ACTIVE_CUSTOMERS_DT, 
FISCAL_YEAR_START_DT, 
NUMBER_OF_MONTHS_PASSED, 
NUMBER_OF_ACTIVE_CUSTOMERS, 
NUMBER_OF_OFFERS,
NUMBER_OF_CHURNED_CUSTOMERS, 
CHURN
)
VALUES 
(@RUN_DATE, 
@LAST_DAY_LAST_MONTH,
@FISCAL_YEAR_START_DT,
@NUMBER_OF_MONTHS_PASSED,
@NUMBER_OF_ACTIVE_CUSTOMERS,
@NUMBER_OF_OFFERS,
@NUMBER_OF_CHURNED_CUSTOMERS,
@CHURN
);

/*
#chrun beregning for finansår 2020-2021 dvs. 1.7.2020 til og med 30.6.2021

#1. Tal fra http://admin4.uni-tel.dk/admin/forhandlere/stat_1.php
select sum(custnumber) 
from admin.custstats c2 
where rdate='2021-06-30'

#2.#-- tilbud – husk at sætte det rigtige dato interval ind
SELECT count (distinct ch.cust)
FROM admin.churn  ch
LEFT JOIN admin.cust c ON c.`custid`=ch.`cust`
WHERE ch.dt BETWEEN '2020-07-01' AND '2021-06-30'  
AND ch.cust NOT IN (SELECT custid FROM admin.turnover WHERE amount>0) 
AND c.active=0 
AND c.forhandlerid NOT IN (12,43,0)  #Unitel selv, connection.dk, unicom.dk
AND c.created>'2015-01-01'
AND c.custid NOT IN (SELECT custid FROM admin.custsettings WHERE setting='bill_to_cust');

#3.-- churnede kunder – husk at sætte det rigtige dato interval ind
SELECT count (distinct ch.cust) 
FROM admin.churn ch 
LEFT JOIN admin.cust c ON c.custid=ch.cust 
WHERE ch.dt BETWEEN '2019-07-01' AND '2020-06-30'  
AND c.active=0 
AND c.forhandlerid<>12 #Connection A/S sorteres fra. Niebe oplyser, at forhandleren "træk" sig fra Uni-Tel med sine kunder. Derfor skal opsigelserne ikke medregnes

#resultater og beregning
1) 7079 aktive kunder 30.6.2021
2) 62 tilbud --turnover ikke opdateret
3) 702

select (702-62)/7079 * 100 
#9,04 procent

brøk
Fra: Morten Isaksen <misak@uni-tel.dk> 
Sendt: 17. februar 2020 14:16
Til: Iben Sønderskov <iben@uni-tel.dk>
Emne: SV: Churn
 
(1)	Kunder pr 1/2-2020: 6235
(2)	Tilbud: 40
(3)	Churnede kunder: 394
 
(394-40)/6235/7*12 = 9,73%

*/

END

