CREATE PROCEDURE [dbo].[InsertFreightCharge]
	@ABV NCHAR(25)
AS
	INSERT INTO [dbo].[FreightCharge] (ABV) VALUES (@ABV)

