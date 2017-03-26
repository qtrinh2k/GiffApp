CREATE PROCEDURE [dbo].[GetPayoutItemsByBookingId]
	@bookingId int
AS
	SELECT a.MapId, b.[Description], b.PayoutAmount
	FROM [dbo].[BillingItems] as b
	JOIN [dbo].AccountingCode as a on a.Id = b.CodeId
	WHERE b.BookingId = @bookingId and a.MapId IS NOT NULL
RETURN 0
