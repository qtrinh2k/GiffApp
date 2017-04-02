CREATE PROCEDURE [dbo].[GetBookingByUserName]
	@userName nvarchar(25)
AS
SELECT TOP 50
	[Id] as BookingId
	,(select top 1 [GiffiId] from dbo.BookingReference where BookingId = [dbo].[Booking].[Id]) AS GiffiId
	,(Select top 1 CompanyName from dbo.Company where Id = BillToId) As BillTo
	,(Select top 1Code from dbo.Company where Id = CarrierId) AS CarrierCode
	,[Discharge]
	,[Destination]
	,[CutOffDate]
	,[DOC]
	,[ModifiedTime]
    ,[Status]
  FROM [dbo].[Booking]
  WHERE CreatedBy = @userName
