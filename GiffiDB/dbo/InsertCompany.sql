
CREATE PROCEDURE [dbo].[InsertCompany]
    @companyName nvarchar(200),
	@code nvarchar(25),
	@companyType nvarchar(15),
	@federalNumber nvarchar(25),
    @address1 nvarchar(200),
    @address2 nchar(50),  
    @city nvarchar(25),
    @state nchar(10),
    @zipCode nchar (10),    
    @zipCode2 nchar (5),
	@country NVARCHAR (25),
	@phone nchar (15),
	@email nvarchar (50)	
AS
BEGIN
	DECLARE @errorMsg as nvarchar(200)	
	IF EXISTS (SELECT Id FROM [dbo].[Company] WHERE CompanyName = @companyName)
	BEGIN
		set @errorMsg = 'Company Name already exist!!!'
	END
	ELSE
	BEGIN
		INSERT INTO Company (CompanyName, Code, CompanyType, FederalNumber, Address1, Address2, City, [State], ZipCode, ZipCode2, Country, Phone, Email)
		OUTPUT inserted.Id
		VALUES (@companyName, @code, @companyType, @federalNumber, @address1, @address2, @city, @state, @zipCode, @zipCode2, @country, @phone, @email)
	END
RETURN 0
END