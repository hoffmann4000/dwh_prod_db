CREATE TABLE [baseline].[mobil_abn_history](
	[id] [int] NULL,
	[cust] [int] NULL,
	[country_id] [int] NULL,
	[did] [bigint] NULL,
	[navn] [nvarchar](50) NULL,
	[extra] [nvarchar](50) NULL,
	[abn] [int] NULL,
	[startdate] [datetime2](0) NULL,
	[enddate] [datetime2](0) NULL,
	[invoicedto] [datetime2](0) NULL,
	[status] [tinyint] NULL,
	[icc] [nvarchar](25) NULL,
	[localno] [nvarchar](5) NULL,
	[email] [nvarchar](100) NULL,
	[password] [nvarchar](255) NULL,
	[suspended] [tinyint] NULL,
	[created] [datetime2](0) NULL,
	[load_dato] [datetime2](0) NULL
) 
GO


