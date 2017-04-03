CREATE PROCEDURE [dbo].[UpdateContainer]
@Id int,
@BookingId int,
@ContainerNo nvarchar(15),
@SealNo nchar(15),
@NumOfPkgs int,
@NetWeight float,
@GRS float,
@Truck nchar(10),
@Invoice bigint,
@CreatedDate datetime
AS
BEGIN TRAN
	SET XACT_ABORT ON
		UPDATE [dbo].[Container]        
		SET [BookingId] = @BookingId
           ,[ContainerNo] = @ContainerNo
           ,[SealNo] = @SealNo
           ,[NumOfPkgs] = @NumOfPkgs
           ,[NetWeight] = @NetWeight
           ,[GRS] = @GRS
           ,[Truck] = @Truck
           ,[Invoice] = @Invoice
           ,[CreatedDate] = @CreatedDate
		WHERE
			Id = @Id
COMMIT TRANSACTION

