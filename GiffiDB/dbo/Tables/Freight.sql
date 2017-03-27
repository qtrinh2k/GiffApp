CREATE TABLE [dbo].[Freight] (
    [Id]         INT        NOT NULL IDENTITY(1,1),
	[BookingId]	 INT		NOT NULL,
    [Code]       NCHAR(25)	NULL,
    [BS]         NCHAR (10) NOT NULL,
    [PC]         NCHAR (1)  NOT NULL,
    [Units]      INT        NOT NULL,
    [Rate]       MONEY NOT NULL,
    [AmtPPD] MONEY NOT NULL,
    [AmtCOL] MONEY NOT NULL,
    [BrkRate]    MONEY NOT NULL,
    [BrkAmt]  MONEY NOT NULL,
	[CreatedDate] DATETIME DEFAULT GETDATE(),
    [ModifiedDate] DATETIME NULL DEFAULT GETDATE(), 
    [CreatedBy] NCHAR(25) NULL, 
    PRIMARY KEY CLUSTERED ([Id] ASC), 
    CONSTRAINT [FK_Freight_ToBooking] FOREIGN KEY ([BookingId]) REFERENCES [Booking]([Id])
);

