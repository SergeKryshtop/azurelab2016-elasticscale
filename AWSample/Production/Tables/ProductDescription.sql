CREATE TABLE [Production].[ProductDescription] (
    [ProductDescriptionID] INT              IDENTITY (1, 1) NOT NULL,
    [Description]          NVARCHAR (400)   NOT NULL,
    [rowguid]              UNIQUEIDENTIFIER CONSTRAINT [DF_ProductDescription_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]         DATETIME         CONSTRAINT [DF_ProductDescription_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductDescription_ProductDescriptionID] PRIMARY KEY CLUSTERED ([ProductDescriptionID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_ProductDescription_rowguid]
    ON [Production].[ProductDescription]([rowguid] ASC);

