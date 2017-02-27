CREATE TABLE [dbo].[Container] (
    [Id]             INT          NOT NULL,
    [CarrierCode]    NCHAR (4)    NOT NULL,
    [BookingId]      INT          NOT NULL,
    [SealNumber]     NUMERIC (18) NOT NULL,
	[ContainerNumber] nvarchar(15) NOT NULL,
    [PackagesWeight] FLOAT (53)   NOT NULL,
    [NetWeight]      FLOAT (53)   NOT NULL,
    [GRS]            NCHAR (10)   NOT NULL,
    [Truck]          NCHAR (10)   NOT NULL,
    [Invoice]        NCHAR (10)   NOT NULL,
	[CreatedDate] DATETIME DEFAULT GETDATE(),
    PRIMARY KEY CLUSTERED ([CarrierCode] ASC, [Id] ASC)
);

