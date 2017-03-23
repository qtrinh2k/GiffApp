CREATE TABLE [dbo].[BillingItems]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[BookingId] INT NOT NULL,
	[CodeId] INT NOT NULL,
	[Quantity] INT NOT NULL DEFAULT 1,
	[Description] NVARCHAR(50) NOT NULL,
	[BillingAmount] MONEY NOT NULL,
	[PayoutAmount] MONEY NOT NULL,
	[CreatedDate] DATETIME DEFAULT GETDATE(),
	[ModifiedDate] DATETIME DEFAULT GETDATE()
    CONSTRAINT [FK_BillingItems_ToAccountingCode] FOREIGN KEY ([CodeId]) REFERENCES [AccountingCode]([Id]),
	CONSTRAINT [FK_BillingItems_ToBooking] FOREIGN KEY ([BookingId]) REFERENCES [Booking]([Id])
)
