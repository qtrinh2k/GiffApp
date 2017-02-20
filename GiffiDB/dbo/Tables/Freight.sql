CREATE TABLE [dbo].[Freight] (
    [Id]         INT        NOT NULL,
    [Code]       NCHAR (10) NOT NULL,
    [BS]         NCHAR (10) NOT NULL,
    [PC]         NCHAR (1)  NOT NULL,
    [Units]      INT        NOT NULL,
    [Rate]       FLOAT (53) NOT NULL,
    [Amount PPD] FLOAT (53) NOT NULL,
    [Amount COL] FLOAT (53) NOT NULL,
    [BrkRate]    FLOAT (53) NOT NULL,
    [BrkAmount]  FLOAT (53) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

