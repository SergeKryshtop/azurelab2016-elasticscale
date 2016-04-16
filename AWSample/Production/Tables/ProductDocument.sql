CREATE TABLE [Production].[ProductDocument] (
    [ProductID]    INT                 NOT NULL,
    [DocumentNode] [sys].[hierarchyid] NOT NULL,
    [ModifiedDate] DATETIME            CONSTRAINT [DF_ProductDocument_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductDocument_ProductID_DocumentNode] PRIMARY KEY CLUSTERED ([ProductID] ASC, [DocumentNode] ASC),
    CONSTRAINT [FK_ProductDocument_Document_DocumentNode] FOREIGN KEY ([DocumentNode]) REFERENCES [Production].[Document] ([DocumentNode]),
    CONSTRAINT [FK_ProductDocument_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
);

