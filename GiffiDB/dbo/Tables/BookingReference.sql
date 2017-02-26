CREATE TABLE [dbo].[BookingReference] (
	[Id] INT NOT NULL IDENTITY(10000,1),
    [GiffiId]      BIGINT NOT NULL,
    [BookingId]    INT        NOT NULL,
    [CloneGiffiId] TINYINT DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_BookingReference_Column] CHECK ((1)=(1)),
    CONSTRAINT [FK_BookingReference_ToTable] FOREIGN KEY ([BookingId]) REFERENCES [dbo].[Booking] ([Id])
);

