CREATE PROCEDURE [dbo].[CloneBooking]
	@bookingId int,
	@newBookingId INT OUTPUT,
	@newGiffiId FLOAT OUT
AS


IF NOT EXISTS (SELECT [ParentGiffiId] FROM [dbo].[BookingReference] WHERE BookingId = @bookingId)
BEGIN
	raiserror ('[CloneBooking] ERROR!!! NOT FOUND BOOKING ID.', 16, 1) ;
END

SET @newGiffiId = 0.01 + (SELECT TOP 1 GiffiId 
FROM [dbo].[BookingReference]
WHERE [ParentGiffiId] in (SELECT [ParentGiffiId] FROM [dbo].[BookingReference] WHERE BookingId = @bookingId)
ORDER BY GiffiId DESC)

BEGIN TRAN
  INSERT INTO [dbo].[Booking]
      ([CreatedBy]
      ,[BillToId]
      ,[ShipperId]
      ,[ShipperRefNo]
      ,[CarrierId]
      ,[CarrierRefNo]
      ,[Vessel]
      ,[Voyage]
      ,[Origin]
      ,[Load]
      ,[ETD]
      ,[Discharge]
      ,[Destination]
      ,[ETA]
      ,[CutOffDate]
      ,[DOC]
      ,[CargoCut]
      ,[VGM]
      ,[Commodity]
      ,[Equipment]
      ,[Temp]
      ,[Vents]
      ,[Notes]
      ,[Status])
	SELECT
	  [CreatedBy]
      ,[BillToId]
      ,[ShipperId]
      ,[ShipperRefNo]
      ,[CarrierId]
      ,[CarrierRefNo]
      ,[Vessel]
      ,[Voyage]
      ,[Origin]
      ,[Load]
      ,[ETD]
      ,[Discharge]
      ,[Destination]
      ,[ETA]
      ,[CutOffDate]
      ,[DOC]
      ,[CargoCut]
      ,[VGM]
      ,[Commodity]
      ,[Equipment]
      ,[Temp]
      ,[Vents]
      ,[Notes]
      ,[Status]
	FROM [dbo].Booking
	WHERE Id = @bookingId
COMMIT TRAN
	set @newBookingId = SCOPE_IDENTITY()
	BEGIN TRAN
	SET XACT_ABORT ON
		INSERT INTO BookingReference(BookingId, GiffiId, ParentGiffiId)
		VALUES(@newBookingId, @newGiffiId, ROUND(@newGiffiId, 0,1))
	COMMIT TRAN

SELECT @newBookingId, @newGiffiId