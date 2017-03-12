CREATE PROCEDURE [dbo].[InsertBookingReference]
	@bookingId int,
	@giffiId bigint
AS

	if(@giffiId	<= 0)
	begin
		set @giffiId = CONCAT(YEAR(GETDATE()) - 2000, @bookingId)
	end

	BEGIN TRAN
	SET XACT_ABORT ON
		INSERT INTO BookingReference(BookingId, GiffiId, CloneGiffiId)
		VALUES(@bookingId, @giffiId, 0)
	COMMIT TRAN

RETURN @giffiId
