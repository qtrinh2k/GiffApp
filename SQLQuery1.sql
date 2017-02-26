USE [Giffi]
GO

DECLARE	@return_value Int

EXEC	@return_value = [dbo].[InsertCompany]
		@companyName = N'abc',
		@attention = N'',
		@address1 = N'123 a',
		@address2 = N'',
		@city = N'a',
		@state = N'wa',
		@country = N'us',
		@zipCode = 12345,
		@zipCode2 = NULL

SELECT	@return_value as 'Return Value'

GO
