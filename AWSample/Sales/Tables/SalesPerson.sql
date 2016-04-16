CREATE TABLE [Sales].[SalesPerson] (
    [BusinessEntityID] INT              NOT NULL,
    [TerritoryID]      INT              NULL,
    [SalesQuota]       MONEY            NULL,
    [Bonus]            MONEY            CONSTRAINT [DF_SalesPerson_Bonus] DEFAULT ((0.00)) NOT NULL,
    [CommissionPct]    SMALLMONEY       CONSTRAINT [DF_SalesPerson_CommissionPct] DEFAULT ((0.00)) NOT NULL,
    [SalesYTD]         MONEY            CONSTRAINT [DF_SalesPerson_SalesYTD] DEFAULT ((0.00)) NOT NULL,
    [SalesLastYear]    MONEY            CONSTRAINT [DF_SalesPerson_SalesLastYear] DEFAULT ((0.00)) NOT NULL,
    [rowguid]          UNIQUEIDENTIFIER CONSTRAINT [DF_SalesPerson_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]     DATETIME         CONSTRAINT [DF_SalesPerson_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SalesPerson_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [CK_SalesPerson_Bonus] CHECK ([Bonus]>=(0.00)),
    CONSTRAINT [CK_SalesPerson_CommissionPct] CHECK ([CommissionPct]>=(0.00)),
    CONSTRAINT [CK_SalesPerson_SalesLastYear] CHECK ([SalesLastYear]>=(0.00)),
    CONSTRAINT [CK_SalesPerson_SalesQuota] CHECK ([SalesQuota]>(0.00)),
    CONSTRAINT [CK_SalesPerson_SalesYTD] CHECK ([SalesYTD]>=(0.00)),
    CONSTRAINT [FK_SalesPerson_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID]),
    CONSTRAINT [FK_SalesPerson_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesPerson_rowguid]
    ON [Sales].[SalesPerson]([rowguid] ASC);

