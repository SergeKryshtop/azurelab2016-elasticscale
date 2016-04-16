CREATE TABLE [Production].[TransactionHistoryArchive] (
    [TransactionID]        INT       NOT NULL,
    [ProductID]            INT       NOT NULL,
    [ReferenceOrderID]     INT       NOT NULL,
    [ReferenceOrderLineID] INT       CONSTRAINT [DF_TransactionHistoryArchive_ReferenceOrderLineID] DEFAULT ((0)) NOT NULL,
    [TransactionDate]      DATETIME  CONSTRAINT [DF_TransactionHistoryArchive_TransactionDate] DEFAULT (getdate()) NOT NULL,
    [TransactionType]      NCHAR (1) NOT NULL,
    [Quantity]             INT       NOT NULL,
    [ActualCost]           MONEY     NOT NULL,
    [ModifiedDate]         DATETIME  CONSTRAINT [DF_TransactionHistoryArchive_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_TransactionHistoryArchive_TransactionID] PRIMARY KEY CLUSTERED ([TransactionID] ASC),
    CONSTRAINT [CK_TransactionHistoryArchive_TransactionType] CHECK (upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W')
);


GO
CREATE NONCLUSTERED INDEX [IX_TransactionHistoryArchive_ProductID]
    ON [Production].[TransactionHistoryArchive]([ProductID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID]
    ON [Production].[TransactionHistoryArchive]([ReferenceOrderID] ASC, [ReferenceOrderLineID] ASC);

