CREATE PROCEDURE [dbo].[InsertBookingReference]
	@bookingId int,
	@giffiId bigint,
	@isClone bit
AS
	if(@giffiId	<= 0)
	begin
		set @giffiId = CAST(CONCAT(CAST(YEAR(GETDATE()) AS bigint),CAST(RIGHT('10000' + CAST(@bookingId AS VARCHAR(6)), 6) AS bigint)) as bigint)
	end

	INSERT INTO BookingReference(BookingId, GiffiId, CloneGiffiId)
	VALUES(@bookingId, @giffiId, 0)
RETURN 0
