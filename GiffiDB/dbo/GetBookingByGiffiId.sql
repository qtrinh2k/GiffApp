CREATE PROCEDURE [dbo].[GetBookingByGiffiId]
	@GiffiId int = 0
AS
	SELECT b.Id, 
		bf.GiffiId, 
		b.CreatedBy, 
		b.ModifiedTime, 
		(SELECT TOP 1 CompanyName FROM [dbo].[Address] WHERE b.BillToId = Id) AS [BILLTO],
		(SELECT TOP 1 CompanyName FROM [dbo].[Address] WHERE b.ShipperId = Id) AS [SHIPPER],
		(SELECT TOP 1 CompanyName FROM [dbo].[Address] WHERE b.CarrierId = Id) AS [CARRIER],
		b.Vessel, 
		b.VSL, 
		(SELECT TOP 1 City FROM [dbo].[Location] WHERE b.OriginId = Id) AS [ORIGIN], 
		(SELECT TOP 1 City FROM [dbo].[Location] WHERE b.LoadId = Id) AS [LOAD],
		(SELECT TOP 1 City FROM [dbo].[Location] WHERE b.DischargeId = Id) AS [DISCHG], 
		(SELECT TOP 1 City FROM [dbo].[Location] WHERE b.DestinationId = Id) AS [DEST],
		b.Commodity, 
		b.Equiment, 
		b.Temp, 
		b.Vents, 
		b.Notes
	FROM [dbo].[Booking] b
		JOIN [dbo].BookingReference bf ON b.Id = bf.BookingId
	WHERE bf.GiffiId = @GiffiId
RETURN 0
