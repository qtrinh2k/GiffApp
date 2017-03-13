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
	SET XACT_ABORT ON
	IF EXISTS(SELECT ContainerNo FROM [dbo].[Container] WHERE ContainerNo = @ContainerNo AND BookingId = @BookingId)
		BEGIN
			raiserror ('InsertContainer: ContainerNo already exist!!!', 16, 1) ;
			/*RETURN -100 RECORD ALREADY EXIST*/
		END
	ELSE
		BEGIN
			BEGIN TRAN
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
		END



