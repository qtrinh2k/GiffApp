CREATE TABLE [dbo].[Carrier] (
    [Id]          INT           NOT NULL,
    [CarrierCode] NVARCHAR (50) NOT NULL,
    [CompanyId]   INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC), 
    CONSTRAINT [FK_Carrier_ToCompany] FOREIGN KEY ([CompanyId]) REFERENCES [Company]([Id])
);

