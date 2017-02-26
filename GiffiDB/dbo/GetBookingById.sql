CREATE PROCEDURE [dbo].[GetBookingById]
	@id int = 0
AS
	SELECT b.Id, 
		bf.GiffiId, 
		b.CreatedBy, 
		b.ModifiedTime, 
		(SELECT TOP 1 CompanyName FROM [dbo].[Company] WHERE b.BillToId = Id) AS [BILLTO],
		(SELECT TOP 1 CompanyName FROM [dbo].[Company] WHERE b.ShipperId = Id) AS [SHIPPER],
		(SELECT TOP 1 CarrierName FROM [dbo].[Carrier] WHERE b.CarrierId = Id) AS [CARRIER],
		b.Vessel, 
		b.VSL,
		b.Origin,
		b.[Load],
		b.Discharge,
		b.Destination,
		b.Commodity, 
		b.Equiment, 
		b.Temp, 
		b.Vents, 
		b.Notes
	FROM [dbo].[Booking] b
		JOIN [dbo].BookingReference bf ON b.Id = bf.BookingId
	WHERE b.Id = @id
RETURN 0
