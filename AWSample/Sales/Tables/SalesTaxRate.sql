CREATE TABLE [Sales].[SalesTaxRate] (
    [SalesTaxRateID]  INT              IDENTITY (1, 1) NOT NULL,
    [StateProvinceID] INT              NOT NULL,
    [TaxType]         TINYINT          NOT NULL,
    [TaxRate]         SMALLMONEY       CONSTRAINT [DF_SalesTaxRate_TaxRate] DEFAULT ((0.00)) NOT NULL,
    [Name]            [dbo].[Name]     NOT NULL,
    [rowguid]         UNIQUEIDENTIFIER CONSTRAINT [DF_SalesTaxRate_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]    DATETIME         CONSTRAINT [DF_SalesTaxRate_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SalesTaxRate_SalesTaxRateID] PRIMARY KEY CLUSTERED ([SalesTaxRateID] ASC),
    CONSTRAINT [CK_SalesTaxRate_TaxType] CHECK ([TaxType]>=(1) AND [TaxType]<=(3)),
    CONSTRAINT [FK_SalesTaxRate_StateProvince_StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [Person].[StateProvince] ([StateProvinceID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesTaxRate_rowguid]
    ON [Sales].[SalesTaxRate]([rowguid] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_SalesTaxRate_StateProvinceID_TaxType]
    ON [Sales].[SalesTaxRate]([StateProvinceID] ASC, [TaxType] ASC);

