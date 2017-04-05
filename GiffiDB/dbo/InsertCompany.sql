
CREATE PROCEDURE [dbo].[InsertCompany]
	@id int,
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
	IF EXISTS (SELECT CompanyName FROM [dbo].[Company] WHERE Id = @id)
	BEGIN
		UPDATE Company 
		SET Code = @code, 
			CompanyName = @companyName,
			CompanyType = @companyType, 
			[Address] = @address, 
			City = @city,
			[State] = @state,
			ZipCode = @zipCode,
			Country = @country,
			Phone = @phone,
			Email = @email
		WHERE Id = @id
	END
	ELSE
	BEGIN
		INSERT INTO Company (Code, CompanyName, CompanyType, FederalNumber, [Address], City, [State], ZipCode, Country, Phone, Email)
		OUTPUT inserted.Id
		VALUES (@code, @companyName, @companyType, @federalNumber, @address, @city, @state, @zipCode, @country, @phone, @email)
	END
RETURN 0
END