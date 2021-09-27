CREATE TABLE [navision].[Uni-tel_AS_Sales_Invoice_Line](
	[timestamp] [datetime2](0) NULL,
	[Document No_] [nvarchar](20) NULL,
	[Line No_] [int] NULL,
	[Sell-to Customer No_] [nvarchar](20) NULL,
	[Type] [int] NULL,
	[No_] [nvarchar](20) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Posting Group] [nvarchar](10) NULL,
	[Shipment Date] [datetime2](0) NULL,
	[Description] [nvarchar](50) NULL,
	[Description 2] [nvarchar](50) NULL,
	[Unit of Measure] [nvarchar](10) NULL,
	[Quantity] [nvarchar](40) NULL,
	[Unit Price] [nvarchar](40) NULL,
	[Unit Cost (LCY)] [nvarchar](40) NULL,
	[VAT _] [nvarchar](40) NULL,
	[Line Discount _] [nvarchar](40) NULL,
	[Line Discount Amount] [nvarchar](40) NULL,
	[Amount] [nvarchar](40) NULL,
	[Amount Including VAT] [nvarchar](40) NULL,
	[Allow Invoice Disc_] [smallint] NULL,
	[Gross Weight] [nvarchar](40) NULL,
	[Net Weight] [nvarchar](40) NULL,
	[Units per Parcel] [nvarchar](40) NULL,
	[Unit Volume] [nvarchar](40) NULL,
	[Appl_-to Item Entry] [int] NULL,
	[Shortcut Dimension 1 Code] [nvarchar](20) NULL,
	[Shortcut Dimension 2 Code] [nvarchar](20) NULL,
	[Customer Price Group] [nvarchar](10) NULL,
	[Job No_] [nvarchar](20) NULL,
	[Work Type Code] [nvarchar](10) NULL,
	[Shipment No_] [nvarchar](20) NULL,
	[Shipment Line No_] [int] NULL,
	[Bill-to Customer No_] [nvarchar](20) NULL,
	[Inv_ Discount Amount] [nvarchar](40) NULL,
	[Drop Shipment] [smallint] NULL,
	[Gen_ Bus_ Posting Group] [nvarchar](10) NULL,
	[Gen_ Prod_ Posting Group] [nvarchar](10) NULL,
	[VAT Calculation Type] [int] NULL,
	[Transaction Type] [nvarchar](10) NULL,
	[Transport Method] [nvarchar](10) NULL,
	[Attached to Line No_] [int] NULL,
	[Exit Point] [nvarchar](10) NULL,
	[Area] [nvarchar](10) NULL,
	[Transaction Specification] [nvarchar](10) NULL,
	[Tax Area Code] [nvarchar](20) NULL,
	[Tax Liable] [smallint] NULL,
	[Tax Group Code] [nvarchar](10) NULL,
	[VAT Clause Code] [nvarchar](10) NULL,
	[VAT Bus_ Posting Group] [nvarchar](10) NULL,
	[VAT Prod_ Posting Group] [nvarchar](10) NULL,
	[Blanket Order No_] [nvarchar](20) NULL,
	[Blanket Order Line No_] [int] NULL,
	[VAT Base Amount] [nvarchar](40) NULL,
	[Unit Cost] [nvarchar](40) NULL,
	[System-Created Entry] [smallint] NULL,
	[Line Amount] [nvarchar](40) NULL,
	[VAT Difference] [nvarchar](40) NULL,
	[VAT Identifier] [nvarchar](10) NULL,
	[IC Partner Ref_ Type] [int] NULL,
	[IC Partner Reference] [nvarchar](20) NULL,
	[Prepayment Line] [smallint] NULL,
	[IC Partner Code] [nvarchar](20) NULL,
	[Posting Date] [datetime2](0) NULL,
	[Dimension Set ID] [int] NULL,
	[Job Task No_] [nvarchar](20) NULL,
	[Job Contract Entry No_] [int] NULL,
	[Variant Code] [nvarchar](10) NULL,
	[Bin Code] [nvarchar](20) NULL,
	[Qty_ per Unit of Measure] [nvarchar](40) NULL,
	[Unit of Measure Code] [nvarchar](10) NULL,
	[Quantity (Base)] [nvarchar](40) NULL,
	[FA Posting Date] [datetime2](0) NULL,
	[Depreciation Book Code] [nvarchar](10) NULL,
	[Depr_ until FA Posting Date] [smallint] NULL,
	[Duplicate in Depreciation Book] [nvarchar](10) NULL,
	[Use Duplication List] [smallint] NULL,
	[Responsibility Center] [nvarchar](10) NULL,
	[Cross-Reference No_] [nvarchar](20) NULL,
	[Unit of Measure (Cross Ref_)] [nvarchar](10) NULL,
	[Cross-Reference Type] [int] NULL,
	[Cross-Reference Type No_] [nvarchar](30) NULL,
	[Item Category Code] [nvarchar](10) NULL,
	[Nonstock] [smallint] NULL,
	[Purchasing Code] [nvarchar](10) NULL,
	[Product Group Code] [nvarchar](10) NULL,
	[Appl_-from Item Entry] [int] NULL,
	[Return Reason Code] [nvarchar](10) NULL,
	[Allow Line Disc_] [smallint] NULL,
	[Customer Disc_ Group] [nvarchar](20) NULL,
	[Account Code] [nvarchar](30) NULL,
	[Internal Accounting No_] [nvarchar](35) NULL,
	[Delivery Party Code] [int] NULL,
	[Delivery Party Text] [nvarchar](20) NULL,
	[load_dato] [nvarchar](max) NULL
) 


