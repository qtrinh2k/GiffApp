
CREATE PROCEDURE [dbo].[InsertBillingItem]
	@BookingId int,
	@CodeId int,
	@Quantity int = 1,
	@Description NVARCHAR(50),
	@BillingAmount money,
	@PayoutAmount money,
	@VendorId int
AS
	SET XACT_ABORT ON
	BEGIN TRAN
	INSERT INTO [dbo].[BillingItems]
           ([BookingId]
           ,[CodeId]
           ,[Quantity]
           ,[Description]
           ,[BillingAmount]
           ,[PayoutAmount]
		   ,[VendorId])
		VALUES(		
			@BookingId,
			@CodeId,
			@Quantity,
			@Description,
			@BillingAmount,
			@PayoutAmount,
			@VendorId)
	COMMIT TRAN


