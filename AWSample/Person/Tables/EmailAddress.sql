CREATE TABLE [Person].[EmailAddress] (
    [BusinessEntityID] INT              NOT NULL,
    [EmailAddressID]   INT              IDENTITY (1, 1) NOT NULL,
    [EmailAddress]     NVARCHAR (50)    NULL,
    [rowguid]          UNIQUEIDENTIFIER CONSTRAINT [DF_EmailAddress_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]     DATETIME         CONSTRAINT [DF_EmailAddress_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_EmailAddress_BusinessEntityID_EmailAddressID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC, [EmailAddressID] ASC),
    CONSTRAINT [FK_EmailAddress_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID])
);


GO
CREATE NONCLUSTERED INDEX [IX_EmailAddress_EmailAddress]
    ON [Person].[EmailAddress]([EmailAddress] ASC);

