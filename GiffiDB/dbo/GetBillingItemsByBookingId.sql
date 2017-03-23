CREATE PROCEDURE [dbo].[GetBillingItemsByBookingId]
	@bookingId int
AS
	SELECT [BookingId], [CodeId], [Description], [BillingAmount], [PayoutAmount] 
	FROM [dbo].[BillingItems] 
	WHERE [BookingId] = @bookingId

