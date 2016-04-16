CREATE TABLE [HumanResources].[Department] (
    [DepartmentID] SMALLINT     IDENTITY (1, 1) NOT NULL,
    [Name]         [dbo].[Name] NOT NULL,
    [GroupName]    [dbo].[Name] NOT NULL,
    [ModifiedDate] DATETIME     CONSTRAINT [DF_Department_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Department_DepartmentID] PRIMARY KEY CLUSTERED ([DepartmentID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Department_Name]
    ON [HumanResources].[Department]([Name] ASC);

