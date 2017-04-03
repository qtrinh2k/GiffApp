CREATE PROCEDURE [dbo].[GetBillingItemsByBookingId]
	@bookingId int
AS
	SELECT bi.[Id], [BookingId], [CodeId], [Description], [BillingAmount], [PayoutAmount], c.Code as [Vendor]
	FROM [dbo].[BillingItems] bi
	JOIN [dbo].Company c on c.Id = bi.VendorId
	WHERE [BookingId] = @bookingId
