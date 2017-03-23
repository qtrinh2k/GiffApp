CREATE PROCEDURE [dbo].[UpdateFreight]
@Id int,
@BookingId int,
@Code int,
@BS nchar(10),
@PC nchar(1),
@Units int,
@Rate money,
@AmtPPD money,
@AmtCOL money,
@BrkRate money,
@BrkAmt money,
@ModifiedDate datetime
AS
BEGIN TRAN
	SET XACT_ABORT ON
	UPDATE [dbo].[Freight]
	   SET [BookingId] = @BookingId
		  ,[Code] = @Code
		  ,[BS] = @BS
		  ,[PC] = @PC
		  ,[Units] = @Units
		  ,[Rate] = @Rate
		  ,[AmtPPD] = @AmtPPD
		  ,[AmtCOL] = @AmtCOL
		  ,[BrkRate] = @BrkRate
		  ,[BrkAmt] = @BrkAmt
		  ,[ModifiedDate] = @ModifiedDate
	 WHERE Id = @Id
 COMMIT TRANSACTION
