CREATE PROCEDURE [dbo].[GetBookingByGiffiId]
	@GiffiId int = 0
AS
	SELECT b.Id, 
		bf.GiffiId, 
		b.CreatedBy, 
		b.ModifiedTime, 
		(SELECT TOP 1 CompanyName FROM [dbo].[Company] WHERE b.BillToId = Id) AS [BILLTO],
		(SELECT TOP 1 CompanyName FROM [dbo].[Company] WHERE b.ShipperId = Id) AS [SHIPPER],
		(SELECT TOP 1 CarrierCode FROM [dbo].[Carrier] WHERE b.CarrierId = Id) AS [CARRIER],
		b.Vessel, 
		b.Voyage,
		b.Origin,
		b.[Load],
		b.Discharge,
		b.Destination, 
		b.Commodity, 
		b.Equipment, 
		b.Temp, 
		b.Vents, 
		b.Notes
	FROM [dbo].[Booking] b
		JOIN [dbo].BookingReference bf ON b.Id = bf.BookingId
	WHERE bf.GiffiId = @GiffiId
RETURN 0
