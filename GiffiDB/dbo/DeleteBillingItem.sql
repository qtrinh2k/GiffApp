CREATE PROCEDURE [dbo].[DeleteBillingItem]
	@BillingItemId int,
	@BookingId int
AS
BEGIN TRAN
SET XACT_ABORT ON

DELETE FROM [dbo].[BillingItems]
      WHERE Id = @BillingItemId and BookingId = @BookingId

COMMIT TRAN
