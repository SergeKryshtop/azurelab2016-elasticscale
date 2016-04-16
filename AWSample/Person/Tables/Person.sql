CREATE TABLE [Person].[Person] (
    [BusinessEntityID]      INT               NOT NULL,
    [PersonType]            NCHAR (2)         NOT NULL,
    [NameStyle]             [dbo].[NameStyle] CONSTRAINT [DF_Person_NameStyle] DEFAULT ((0)) NOT NULL,
    [Title]                 NVARCHAR (8)      NULL,
    [FirstName]             [dbo].[Name]      NOT NULL,
    [MiddleName]            [dbo].[Name]      NULL,
    [LastName]              [dbo].[Name]      NOT NULL,
    [Suffix]                NVARCHAR (10)     NULL,
    [EmailPromotion]        INT               CONSTRAINT [DF_Person_EmailPromotion] DEFAULT ((0)) NOT NULL,
    [AdditionalContactInfo] XML               NULL,
    [Demographics]          XML               NULL,
    [rowguid]               UNIQUEIDENTIFIER  CONSTRAINT [DF_Person_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]          DATETIME          CONSTRAINT [DF_Person_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Person_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [CK_Person_EmailPromotion] CHECK ([EmailPromotion]>=(0) AND [EmailPromotion]<=(2)),
    CONSTRAINT [CK_Person_PersonType] CHECK ([PersonType] IS NULL OR (upper([PersonType])='GC' OR upper([PersonType])='SP' OR upper([PersonType])='EM' OR upper([PersonType])='IN' OR upper([PersonType])='VC' OR upper([PersonType])='SC')),
    CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Person_rowguid]
    ON [Person].[Person]([rowguid] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Person_LastName_FirstName_MiddleName]
    ON [Person].[Person]([LastName] ASC, [FirstName] ASC, [MiddleName] ASC);


GO

CREATE TRIGGER [Person].[iuPerson] ON [Person].[Person] 
AFTER INSERT, UPDATE  AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    IF UPDATE([BusinessEntityID]) OR UPDATE([Demographics]) 
    BEGIN
        UPDATE [Person].[Person] 
        SET [Person].[Person].[Demographics] = N'<IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"> 
            <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
            </IndividualSurvey>' 
        FROM inserted 
        WHERE [Person].[Person].[BusinessEntityID] = inserted.[BusinessEntityID] 
            AND inserted.[Demographics] IS NULL;
        
        UPDATE [Person].[Person] 
        SET [Demographics].modify(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
            insert <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
            as first 
            into (/IndividualSurvey)[1]') 
        FROM inserted 
        WHERE [Person].[Person].[BusinessEntityID] = inserted.[BusinessEntityID] 
            AND inserted.[Demographics] IS NOT NULL 
            AND inserted.[Demographics].exist(N'declare default element namespace 
                "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
                /IndividualSurvey/TotalPurchaseYTD') <> 1;
    END;
END;