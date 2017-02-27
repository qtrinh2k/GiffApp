
CREATE PROCEDURE [dbo].[InsertCarrier]
	@code nvarchar(25),
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
	@email nvarchar (50),
	@federalNumber nvarchar(25) 
AS

RETURN 0
