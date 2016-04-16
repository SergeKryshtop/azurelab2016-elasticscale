CREATE TABLE [Sales].[SpecialOfferProduct] (
    [SpecialOfferID] INT              NOT NULL,
    [ProductID]      INT              NOT NULL,
    [rowguid]        UNIQUEIDENTIFIER CONSTRAINT [DF_SpecialOfferProduct_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]   DATETIME         CONSTRAINT [DF_SpecialOfferProduct_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SpecialOfferProduct_SpecialOfferID_ProductID] PRIMARY KEY CLUSTERED ([SpecialOfferID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_SpecialOfferProduct_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID]),
    CONSTRAINT [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID] FOREIGN KEY ([SpecialOfferID]) REFERENCES [Sales].[SpecialOffer] ([SpecialOfferID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_SpecialOfferProduct_rowguid]
    ON [Sales].[SpecialOfferProduct]([rowguid] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_SpecialOfferProduct_ProductID]
    ON [Sales].[SpecialOfferProduct]([ProductID] ASC);

