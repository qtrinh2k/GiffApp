CREATE TABLE [dbo].[AccountingCode] (
    [Id]    INT           NOT NULL,
    [Name]  NVARCHAR (50) NOT NULL,
    [MapId] INT           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

