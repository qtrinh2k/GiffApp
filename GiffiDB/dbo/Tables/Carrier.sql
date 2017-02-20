CREATE TABLE [dbo].[Carrier] (
    [Id]          INT           NOT NULL,
    [CarrierName] NVARCHAR (50) NOT NULL,
    [Number]      NVARCHAR (25) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

