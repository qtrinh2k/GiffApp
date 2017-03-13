
CREATE PROCEDURE [dbo].[InsertCompany]
	@code nvarchar(25),
    @companyName nvarchar(200),
	@companyType nvarchar(15),
	@federalNumber nvarchar(25),
    @address nvarchar(200),  
    @city nvarchar(25),
    @state nchar(10),
    @zipCode nchar (10),    
	@country NVARCHAR (25),
	@phone nchar (15),
	@email nvarchar (50)	
AS
BEGIN
	DECLARE @errorMsg as nvarchar(200)	
	IF EXISTS (SELECT CompanyName FROM [dbo].[Company] WHERE CompanyName = @companyName)
	BEGIN
		set @errorMsg = 'Company Name already exist!!!'
	END
	ELSE
	BEGIN
		INSERT INTO Company (Code, CompanyName, CompanyType, FederalNumber, [Address], City, [State], ZipCode, Country, Phone, Email)
		OUTPUT inserted.Id
		VALUES (@code, @companyName, @companyType, @federalNumber, @address, @city, @state, @zipCode, @country, @phone, @email)
	END
RETURN 0
END