CREATE TABLE [HumanResources].[Shift] (
    [ShiftID]      TINYINT      IDENTITY (1, 1) NOT NULL,
    [Name]         [dbo].[Name] NOT NULL,
    [StartTime]    TIME (7)     NOT NULL,
    [EndTime]      TIME (7)     NOT NULL,
    [ModifiedDate] DATETIME     CONSTRAINT [DF_Shift_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Shift_ShiftID] PRIMARY KEY CLUSTERED ([ShiftID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Shift_Name]
    ON [HumanResources].[Shift]([Name] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_Shift_StartTime_EndTime]
    ON [HumanResources].[Shift]([StartTime] ASC, [EndTime] ASC);

