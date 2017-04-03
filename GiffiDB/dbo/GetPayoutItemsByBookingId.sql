CREATE PROCEDURE [dbo].[GetPayoutItemsByBookingId]
	@bookingId int
AS
	SELECT a.MapId, c.Code, b.PayoutAmount, (b.BillingAmount - b.PayoutAmount) as NET
	FROM [dbo].[BillingItems] as b
	JOIN [dbo].AccountingCode as a on a.Id = b.CodeId
	JOIN [dbo].Company as c on b.VendorId = c.Id
	WHERE b.BookingId = @bookingId and a.MapId IS NOT NULL
