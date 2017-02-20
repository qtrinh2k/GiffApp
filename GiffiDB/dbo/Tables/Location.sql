CREATE TABLE [dbo].[Location] (
    [Id]      INT           NOT NULL,
    [City]    NVARCHAR (50) NOT NULL,
    [State]   NCHAR (10)    NOT NULL,
    [Country] NVARCHAR (25) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

