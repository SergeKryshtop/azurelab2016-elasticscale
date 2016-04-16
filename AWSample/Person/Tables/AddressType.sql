CREATE TABLE [Person].[AddressType] (
    [AddressTypeID] INT              IDENTITY (1, 1) NOT NULL,
    [Name]          [dbo].[Name]     NOT NULL,
    [rowguid]       UNIQUEIDENTIFIER CONSTRAINT [DF_AddressType_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]  DATETIME         CONSTRAINT [DF_AddressType_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_AddressType_AddressTypeID] PRIMARY KEY CLUSTERED ([AddressTypeID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_AddressType_Name]
    ON [Person].[AddressType]([Name] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_AddressType_rowguid]
    ON [Person].[AddressType]([rowguid] ASC);

