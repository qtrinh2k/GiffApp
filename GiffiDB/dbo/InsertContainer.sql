CREATE PROCEDURE [dbo].[InsertContainer]
@BookingId int,
@ContainerNo nvarchar(15),
@SealNo bigint,
@PkgsWeight float,
@NetWeight float,
@GRS float,
@Truck nchar(10),
@Invoice bigint,
@CreatedDate datetime
AS
BEGIN TRAN
	SET XACT_ABORT ON
		INSERT INTO [dbo].[Container](
           [BookingId]
           ,[ContainerNo]
           ,[SealNo]
           ,[PkgsWeight]
           ,[NetWeight]
           ,[GRS]
           ,[Truck]
           ,[Invoice]
           ,[CreatedDate])
		VALUES
           (@BookingId,
			@ContainerNo,
			@SealNo,
			@PkgsWeight,
			@NetWeight,
			@GRS,
			@Truck,
			@Invoice,
			@CreatedDate)
COMMIT TRANSACTION

