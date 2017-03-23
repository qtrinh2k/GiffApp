CREATE PROCEDURE [dbo].[UpdateBillingItem]
	@Id int,
	@BookingId int,
	@CodeId int,
	@Quantity int = 1,
	@Description NVARCHAR(50),
	@BillingAmount money,
	@PayoutAmount money
AS
	BEGIN TRAN
	SET XACT_ABORT ON
	UPDATE [dbo].[BillingItems]
	SET
		CodeId = @CodeId,
		Quantity = @Quantity,
		[Description] = @Description,
		[BillingAmount] = @BillingAmount,
		[PayoutAmount] = @PayoutAmount,
		[ModifiedDate] = GETDATE()
	WHERE
		[Id] = @Id AND [BookingId] = @BookingId
RETURN 0
