CREATE TABLE [SalesLT].[SalesTerritory] (
    [TerritoryID]       INT              NOT NULL,
    [Name]              [dbo].[Name]     NOT NULL,
    [CountryRegionCode] NVARCHAR (3)     NOT NULL,
    [Group]             NVARCHAR (50)    NOT NULL,
    [SalesYTD]          MONEY            CONSTRAINT [DF_SalesTerritory_SalesYTD] DEFAULT ((0.00)) NOT NULL,
    [SalesLastYear]     MONEY            CONSTRAINT [DF_SalesTerritory_SalesLastYear] DEFAULT ((0.00)) NOT NULL,
    [CostYTD]           MONEY            CONSTRAINT [DF_SalesTerritory_CostYTD] DEFAULT ((0.00)) NOT NULL,
    [CostLastYear]      MONEY            CONSTRAINT [DF_SalesTerritory_CostLastYear] DEFAULT ((0.00)) NOT NULL,
    [rowguid]           UNIQUEIDENTIFIER CONSTRAINT [DF_SalesTerritory_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]      DATETIME         CONSTRAINT [DF_SalesTerritory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY CLUSTERED ([TerritoryID] ASC),
    CONSTRAINT [CK_SalesTerritory_CostLastYear] CHECK ([CostLastYear]>=(0.00)),
    CONSTRAINT [CK_SalesTerritory_CostYTD] CHECK ([CostYTD]>=(0.00)),
    CONSTRAINT [CK_SalesTerritory_SalesLastYear] CHECK ([SalesLastYear]>=(0.00)),
    CONSTRAINT [CK_SalesTerritory_SalesYTD] CHECK ([SalesYTD]>=(0.00))
);

