CREATE PROCEDURE [dbo].[GetContainerByBookingId]
	@bookingId int
AS
	SELECT
		[Id]
      ,[BookingId]
      ,[ContainerNo]
      ,[SealNo]
      ,[NumOfPkgs]
      ,[NetWeight]
      ,[GRS]
      ,[Truck]
      ,[Invoice]
      ,[CreatedDate]
  FROM [dbo].[Container] WITH (NOLOCK)
  WHERE BookingId = @bookingId
