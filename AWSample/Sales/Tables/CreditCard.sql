CREATE TABLE [Sales].[CreditCard] (
    [CreditCardID] INT           IDENTITY (1, 1) NOT NULL,
    [CardType]     NVARCHAR (50) NOT NULL,
    [CardNumber]   NVARCHAR (25) NOT NULL,
    [ExpMonth]     TINYINT       NOT NULL,
    [ExpYear]      SMALLINT      NOT NULL,
    [ModifiedDate] DATETIME      CONSTRAINT [DF_CreditCard_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_CreditCard_CreditCardID] PRIMARY KEY CLUSTERED ([CreditCardID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_CreditCard_CardNumber]
    ON [Sales].[CreditCard]([CardNumber] ASC);

