CREATE TABLE [dbo].[CertOfOrigin]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[BookingId] INT NOT NULL,
	[BOLRef] NVARCHAR(25) NOT NULL,
	[CertificateRef] NVARCHAR(25) NOT NULL,
	[ConsigneeAddress] NVARCHAR(200) NULL,
	[ConsigneeRef] nvarchar(25) NULL,
	[PlaceOfReceipt] nvarchar(25) NULL,
	[NotifyAddress] NVARCHAR(200) NULL,
	[PlaceOfDelivery] nvarchar(25) NULL,
	[SupplierAddress] NVARCHAR(200) NULL,
	[WarehouseAddress] NVARCHAR(200) NULL,
	[Notes] NVARCHAR(200) NULL,
	[PlaceOfIssue] NVARCHAR(25) NULL,
	[DateOfIssue] DateTime NULL,
	[CreatedDate] DateTime DEFAULT GETDATE(),
	[ModifiedDate] DateTime DEFAULT GETDATE(), 
    CONSTRAINT [FK_CertOfOrigin_ToBooking] FOREIGN KEY ([BookingId]) REFERENCES [Booking]([Id])
)
