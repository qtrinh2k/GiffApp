CREATE VIEW [dbo].[BookingView]
AS
SELECT
	[Id] as BookingId
	,CreatedBy
	,(select top 1 [GiffiId] from dbo.BookingReference where BookingId = [dbo].[Booking].[Id]) AS GiffiId
	,(Select top 1 CompanyName from dbo.Company where Id = BillToId) As BillTo
	,[ShipperRefNo]
	,(Select top 1 Code from dbo.Company where Id = CarrierId) AS CarrierCode
	,[CarrierRefNo]
	,[Discharge]
	,[Destination]
	,[CutOffDate]
	,[DOC]
	,[ModifiedTime]
    ,[Status] 
  FROM [dbo].[Booking]
