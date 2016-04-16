CREATE TABLE [SalesLT].[SalesOrderHeaderEnlarged] (
    [SalesOrderID]           INT                   IDENTITY (1, 1) NOT NULL,
    [RevisionNumber]         TINYINT               CONSTRAINT [DF_SalesOrderHeaderEnlarged_RevisionNumber] DEFAULT ((0)) NOT NULL,
    [OrderDate]              DATETIME              CONSTRAINT [DF_SalesOrderHeaderEnlarged_OrderDate] DEFAULT (getdate()) NOT NULL,
    [DueDate]                DATETIME              NOT NULL,
    [ShipDate]               DATETIME              NULL,
    [Status]                 TINYINT               CONSTRAINT [DF_SalesOrderHeaderEnlarged_Status] DEFAULT ((1)) NOT NULL,
    [OnlineOrderFlag]        [dbo].[Flag]          CONSTRAINT [DF_SalesOrderHeaderEnlarged_OnlineOrderFlag] DEFAULT ((1)) NOT NULL,
    [SalesOrderNumber]       AS                    (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID],(0)),N'*** ERROR ***')),
    [PurchaseOrderNumber]    [dbo].[OrderNumber]   NULL,
    [AccountNumber]          [dbo].[AccountNumber] NULL,
    [CustomerID]             INT                   NOT NULL,
    [ShipToAddressID]        INT                   NULL,
    [BillToAddressID]        INT                   NULL,
    [ShipMethod]             NVARCHAR (50)         NOT NULL,
    [CreditCardApprovalCode] VARCHAR (15)          NULL,
    [SubTotal]               MONEY                 CONSTRAINT [DF_SalesOrderHeaderEnlarged_SubTotal] DEFAULT ((0.00)) NOT NULL,
    [TaxAmt]                 MONEY                 CONSTRAINT [DF_SalesOrderHeaderEnlarged_TaxAmt] DEFAULT ((0.00)) NOT NULL,
    [Freight]                MONEY                 CONSTRAINT [DF_SalesOrderHeaderEnlarged_Freight] DEFAULT ((0.00)) NOT NULL,
    [TotalDue]               AS                    (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))),
    [Comment]                NVARCHAR (MAX)        NULL,
    [rowguid]                UNIQUEIDENTIFIER      CONSTRAINT [DF_SalesOrderHeaderEnlarged_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]           DATETIME              CONSTRAINT [DF_SalesOrderHeaderEnlarged_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    [TerritoryID]            INT                   NOT NULL,
    CONSTRAINT [PK_SalesOrderHeaderEnlarged_SalesOrderID] PRIMARY KEY CLUSTERED ([SalesOrderID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesOrderHeaderEnlarged_rowguid]
    ON [SalesLT].[SalesOrderHeaderEnlarged]([rowguid] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesOrderHeaderEnlarged_SalesOrderNumber]
    ON [SalesLT].[SalesOrderHeaderEnlarged]([SalesOrderNumber] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_SalesOrderHeaderEnlarged_CustomerID]
    ON [SalesLT].[SalesOrderHeaderEnlarged]([CustomerID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_SalesOrderHeaderEnlarged_TerritoryID]
    ON [SalesLT].[SalesOrderHeaderEnlarged]([TerritoryID] ASC);

