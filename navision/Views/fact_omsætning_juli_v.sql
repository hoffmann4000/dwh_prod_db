CREATE view navision.fact_omsætning_juli_v as
(
select CAST (round (sum(beløb_ekskl_moms),0) AS BIGINT) AS beløb_fact, f.kunde_id
from reporting.FACT_OMSÆTNING f
where year(f.bogføringsdato)=2021
and month(f.bogføringsdato)=7
group by f.kunde_id
)

GO

