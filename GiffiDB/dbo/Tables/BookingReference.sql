CREATE TABLE [dbo].[BookingReference] (
	[Id] INT NOT NULL IDENTITY(10000,1),
    [BookingId]    INT	 NOT NULL,
	[GiffiId] FLOAT NOT NULL,
    [ParentGiffiId] BIGINT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_BookingReference_Column] CHECK ((1)=(1)),
    CONSTRAINT [FK_BookingReference_ToTable] FOREIGN KEY ([BookingId]) REFERENCES [dbo].[Booking] ([Id])
);

