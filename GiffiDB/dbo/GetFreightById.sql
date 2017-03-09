CREATE PROCEDURE [dbo].[GetFreightByBookingId]
	@bookingId int
AS
	SELECT * 
	FROM [dbo].[Freight] WITH (NOLOCK) 
	WHERE BookingId = @bookingId

