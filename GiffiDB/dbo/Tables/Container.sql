CREATE TABLE [dbo].[Container] (
    [Id]              INT           NOT NULL PRIMARY KEY IDENTITY(1,1),
    [BookingId]       INT           NOT NULL,
	[ContainerNo] NVARCHAR (15) NOT NULL,
    [SealNo]      BIGINT  NOT NULL,
    [PkgsWeight]  FLOAT (53)    NOT NULL,
    [NetWeight]       FLOAT (53)    NOT NULL,
    [GRS]             FLOAT (10)    NOT NULL,
    [Truck]           NCHAR (10)    NOT NULL,
    [Invoice]         BIGINT    NOT NULL,
    [CreatedDate]     DATETIME      DEFAULT (getdate()) NULL, 
    CONSTRAINT [FK_Container_ToBooking] FOREIGN KEY ([BookingId]) REFERENCES [Booking]([Id])
);

