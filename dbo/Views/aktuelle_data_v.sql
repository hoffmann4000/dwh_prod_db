--select cast (getdate() as date)
--viewet giver et overblik over de seneste kildedata og ikke det seneste overførselstidspunkt. 

create view dbo.aktuelle_data_v
as
(
	SELECT 
	DATAKILDE,
	"max_dato",
	case when cast (max_dato as date)>=cast (getdate()-1 as date) then 1 else 0 end as "opdateret"

	FROM 
		(
		--Rating. Bedste bud, da er VL tabeller.  
		select 'rating' as datakilde, max(dato) as "max_dato" from rating.sip_stat
		union

		--admin 
		select 'admin' as datakilde, max(dt) as "max_dato" from admin.historik h 
		union

		--radius
		select 'radius.mob_data_summarized' as datakilde, max(last_day_of_month_dt) as "max_dato" from radius.mob_data_summarized
		union
		select 'radius.mob_cdr_summarized' as datakilde, max(last_day_of_month_dt) as "max_dato" from radius.mob_cdr_summarized
		union

		--One Connect Serveren
		select 'oneconnect.statistics' as datakilde, max(dato) as "max_dato" from [statistics].hpbx_stats
		union
		select 'oneconnect.web_onenumberdk'as datakilde, max(saved) as "max_dato" from web_onenumberdk.number
		union
		select 'oneconnect.web_oneconnectdk'as datakilde, max(saved) as "max_dato" from web_onenumberdk.number
		union
		select 'oneconnect.web_cloudconnectiondk'as datakilde, max(saved) as "max_dato" from web_onenumberdk.number
		) i
)

GO

