CREATE TABLE [dbo].[Company] (
    [Id]          INT	IDENTITY(1,1),
    [CompanyName] NVARCHAR (200)  NOT NULL,
    [Attention]   NVARCHAR (100)  NULL,
    [Address1]    NVARCHAR (200) NOT NULL,
    [Address2]    NCHAR (50)     NULL,
    [City]        NVARCHAR (25)  NOT NULL,
    [State]       NCHAR (10)     NOT NULL,
    [Country]     NVARCHAR (25)  DEFAULT ('USA') NOT NULL,
    [ZipCode]     NCHAR(10)   NULL,
    [ZipCode2]    NCHAR(5)   NULL,
    [Phone] NCHAR(15) NULL, 
    [Email] NVARCHAR(50) NULL, 
	[CreatedDate] DATETIME DEFAULT GETDATE(),
    PRIMARY KEY CLUSTERED ([Id] ASC), 
);

