create view navision.turnover_omsætning_juli_v as
(
select sum(amount) AS beløb_turnover, custid as kunde_id
from admin.turnover
where month='2021-07-01 00:00:00'
group by custid
)

GO

