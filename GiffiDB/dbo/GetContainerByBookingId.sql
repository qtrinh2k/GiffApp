CREATE PROCEDURE [dbo].[GetContainerByBookingId]
	@bookingId int
AS
	SELECT
		[Id]
      ,[BookingId]
      ,[ContainerNo]
      ,[SealNo]
      ,[PkgsWeight]
      ,[NetWeight]
      ,[GRS]
      ,[Truck]
      ,[Invoice]
      ,[CreatedDate]
  FROM [dbo].[Container] WITH (NOLOCK)
  WHERE BookingId = @bookingId
