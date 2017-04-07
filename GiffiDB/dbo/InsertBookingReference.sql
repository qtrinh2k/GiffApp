CREATE PROCEDURE [dbo].[InsertBookingReference]
	@bookingId int,
	@giffiId float
AS
	DECLARE @newGiffId as FLOAT
	IF(@giffiId	<= 0) /* new booking */
	begin
		set @giffiId = CONCAT(YEAR(GETDATE()) - 2000, @bookingId)
			BEGIN TRAN
		SET XACT_ABORT ON
			INSERT INTO BookingReference(BookingId, GiffiId, ParentGiffiId)
			VALUES(@bookingId, @giffiId, ROUND(@giffiId, 0, 1))
		COMMIT TRAN
	end
RETURN @giffiId
