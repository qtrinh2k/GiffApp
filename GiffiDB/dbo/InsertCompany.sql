CREATE PROCEDURE [dbo].[InsertCompany]
    @companyName nvarchar(200),
    @attention nvarchar(100),
    @address1 nvarchar(200),
    @address2 nchar(50),  
    @city nvarchar(25),
    @state nchar(200),
    @zipCode nchar (10),    
    @zipCode2 NUMERIC (5),
	@country NVARCHAR (25),
	@phone nchar (15),
	@email nvarchar (50)
AS
	INSERT INTO Company (CompanyName, Attention, Address1, Address2, City, [State], ZipCode, ZipCode2, Country, Phone, Email)
	VALUES (@companyName, @attention, @address1, @address2, @city, @state, @zipCode, @zipCode2, @country, @phone, @email)
RETURN 0
