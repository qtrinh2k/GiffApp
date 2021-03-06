﻿CREATE PROCEDURE [dbo].[GetBookingById]
	@id int = 0
AS
	SELECT b.Id, 
		bf.GiffiId, 
		b.CreatedBy, 
		b.ModifiedTime, 
		(SELECT TOP 1 CompanyName FROM [dbo].[Company] WHERE b.BillToId = Id) AS [BILLTO],
		(SELECT TOP 1 CompanyName FROM [dbo].[Company] WHERE b.ShipperId = Id) AS [SHIPPER],
		b.Vessel, 
		b.Voyage,
		b.Origin,
		b.[Load],
		b.ETD,
		b.Discharge,
		b.Destination,
		b.ETA,
		b.Commodity, 
		b.Equipment, 
		b.Temp, 
		b.Vents, 
		b.Notes
	FROM [dbo].[Booking] b
		JOIN [dbo].BookingReference bf ON b.Id = bf.BookingId
	WHERE b.Id = @id
RETURN 0
