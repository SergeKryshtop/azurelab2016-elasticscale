CREATE TABLE [Production].[Document] (
    [DocumentNode]    [sys].[hierarchyid] NOT NULL,
    [DocumentLevel]   AS                  ([DocumentNode].[GetLevel]()),
    [Title]           NVARCHAR (50)       NOT NULL,
    [Owner]           INT                 NOT NULL,
    [FolderFlag]      BIT                 CONSTRAINT [DF_Document_FolderFlag] DEFAULT ((0)) NOT NULL,
    [FileName]        NVARCHAR (400)      NOT NULL,
    [FileExtension]   NVARCHAR (8)        NOT NULL,
    [Revision]        NCHAR (5)           NOT NULL,
    [ChangeNumber]    INT                 CONSTRAINT [DF_Document_ChangeNumber] DEFAULT ((0)) NOT NULL,
    [Status]          TINYINT             NOT NULL,
    [DocumentSummary] NVARCHAR (MAX)      NULL,
    [Document]        VARBINARY (MAX)     NULL,
    [rowguid]         UNIQUEIDENTIFIER    CONSTRAINT [DF_Document_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]    DATETIME            CONSTRAINT [DF_Document_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Document_DocumentNode] PRIMARY KEY CLUSTERED ([DocumentNode] ASC),
    CONSTRAINT [CK_Document_Status] CHECK ([Status]>=(1) AND [Status]<=(3)),
    CONSTRAINT [FK_Document_Employee_Owner] FOREIGN KEY ([Owner]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID]),
    UNIQUE NONCLUSTERED ([rowguid] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Document_DocumentLevel_DocumentNode]
    ON [Production].[Document]([DocumentLevel] ASC, [DocumentNode] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Document_rowguid]
    ON [Production].[Document]([rowguid] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Document_FileName_Revision]
    ON [Production].[Document]([FileName] ASC, [Revision] ASC);

