CREATE TABLE [Production].[Culture] (
    [CultureID]    NCHAR (6)    NOT NULL,
    [Name]         [dbo].[Name] NOT NULL,
    [ModifiedDate] DATETIME     CONSTRAINT [DF_Culture_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Culture_CultureID] PRIMARY KEY CLUSTERED ([CultureID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Culture_Name]
    ON [Production].[Culture]([Name] ASC);

