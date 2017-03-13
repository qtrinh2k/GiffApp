CREATE TABLE [dbo].[Company] (
    [Id]          INT	IDENTITY(1,1),
	[Code] NVARCHAR(25) NOT NULL,
    [CompanyName] NVARCHAR (200)  NOT NULL,
	[CompanyType] NVARCHAR(15) NOT NULL, 
    [FederalNumber] NVARCHAR(25) NULL, 
    [Address]    NVARCHAR (200) NOT NULL,
    [City]        NVARCHAR (25)  NOT NULL,
    [State]       NCHAR (15)     NOT NULL,
    [Country]     NVARCHAR (25)  NOT NULL,
    [ZipCode]     NCHAR(10)   NULL,
    [Phone] NCHAR(15) NULL, 
    [Email] NVARCHAR(50) NULL, 
	[CreatedDate] DATETIME DEFAULT GETDATE(),
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

