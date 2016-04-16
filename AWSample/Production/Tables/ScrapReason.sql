CREATE TABLE [Production].[ScrapReason] (
    [ScrapReasonID] SMALLINT     IDENTITY (1, 1) NOT NULL,
    [Name]          [dbo].[Name] NOT NULL,
    [ModifiedDate]  DATETIME     CONSTRAINT [DF_ScrapReason_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ScrapReason_ScrapReasonID] PRIMARY KEY CLUSTERED ([ScrapReasonID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_ScrapReason_Name]
    ON [Production].[ScrapReason]([Name] ASC);

