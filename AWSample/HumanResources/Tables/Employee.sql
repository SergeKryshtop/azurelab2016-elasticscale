CREATE TABLE [HumanResources].[Employee] (
    [BusinessEntityID]  INT                 NOT NULL,
    [NationalIDNumber]  NVARCHAR (15)       NOT NULL,
    [LoginID]           NVARCHAR (256)      NOT NULL,
    [OrganizationNode]  [sys].[hierarchyid] NULL,
    [OrganizationLevel] AS                  ([OrganizationNode].[GetLevel]()),
    [JobTitle]          NVARCHAR (50)       NOT NULL,
    [BirthDate]         DATE                NOT NULL,
    [MaritalStatus]     NCHAR (1)           NOT NULL,
    [Gender]            NCHAR (1)           NOT NULL,
    [HireDate]          DATE                NOT NULL,
    [SalariedFlag]      [dbo].[Flag]        CONSTRAINT [DF_Employee_SalariedFlag] DEFAULT ((1)) NOT NULL,
    [VacationHours]     SMALLINT            CONSTRAINT [DF_Employee_VacationHours] DEFAULT ((0)) NOT NULL,
    [SickLeaveHours]    SMALLINT            CONSTRAINT [DF_Employee_SickLeaveHours] DEFAULT ((0)) NOT NULL,
    [CurrentFlag]       [dbo].[Flag]        CONSTRAINT [DF_Employee_CurrentFlag] DEFAULT ((1)) NOT NULL,
    [rowguid]           UNIQUEIDENTIFIER    CONSTRAINT [DF_Employee_rowguid] DEFAULT (newid()) NOT NULL,
    [ModifiedDate]      DATETIME            CONSTRAINT [DF_Employee_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Employee_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC),
    CONSTRAINT [CK_Employee_BirthDate] CHECK ([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate())),
    CONSTRAINT [CK_Employee_Gender] CHECK (upper([Gender])='F' OR upper([Gender])='M'),
    CONSTRAINT [CK_Employee_HireDate] CHECK ([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate())),
    CONSTRAINT [CK_Employee_MaritalStatus] CHECK (upper([MaritalStatus])='S' OR upper([MaritalStatus])='M'),
    CONSTRAINT [CK_Employee_SickLeaveHours] CHECK ([SickLeaveHours]>=(0) AND [SickLeaveHours]<=(120)),
    CONSTRAINT [CK_Employee_VacationHours] CHECK ([VacationHours]>=(-40) AND [VacationHours]<=(240)),
    CONSTRAINT [FK_Employee_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person].[Person] ([BusinessEntityID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_LoginID]
    ON [HumanResources].[Employee]([LoginID] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_NationalIDNumber]
    ON [HumanResources].[Employee]([NationalIDNumber] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Employee_rowguid]
    ON [HumanResources].[Employee]([rowguid] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Employee_OrganizationLevel_OrganizationNode]
    ON [HumanResources].[Employee]([OrganizationLevel] ASC, [OrganizationNode] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Employee_OrganizationNode]
    ON [HumanResources].[Employee]([OrganizationNode] ASC);


GO

CREATE TRIGGER [HumanResources].[dEmployee] ON [HumanResources].[Employee] 
INSTEAD OF DELETE  AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN
        RAISERROR
            (N'Employees cannot be deleted. They can only be marked as not current.', -- Message
            10, -- Severity.
            1); -- State.

        -- Rollback any active or uncommittable transactions
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
    END;
END;