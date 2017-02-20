CREATE TABLE [dbo].[BookingReference] (
    [GiffiId]      FLOAT (53) NOT NULL,
    [BookingId]    INT        NOT NULL,
    [CloneGiffiId] FLOAT (53) DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([GiffiId] ASC),
    CONSTRAINT [CK_BookingReference_Column] CHECK ((1)=(1)),
    CONSTRAINT [FK_BookingReference_ToTable] FOREIGN KEY ([BookingId]) REFERENCES [dbo].[Booking] ([Id])
);

