CREATE TABLE [dbo].[Company] (
    [Id]          INT            NOT NULL,
    [BookingId]   INT            NOT NULL,
    [CompanyName] NVARCHAR (50)  NOT NULL,
    [Attention]   NVARCHAR (50)  NULL,
    [Address1]    NVARCHAR (100) NOT NULL,
    [Address2]    NCHAR (50)     NULL,
    [City]        NVARCHAR (25)  NOT NULL,
    [State]       NCHAR (10)     NOT NULL,
    [Country]     NVARCHAR (25)  DEFAULT ('USA') NOT NULL,
    [ZipCode]     NUMERIC (18)   NOT NULL,
    [ZipCode2]    NUMERIC (18)   NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC), 
    CONSTRAINT [FK_Company_Booking] FOREIGN KEY ([Id]) REFERENCES [Booking]([Id])
);

