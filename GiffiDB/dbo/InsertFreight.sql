CREATE PROCEDURE [dbo].[InsertFreight]
@BookingId int,
@Code nchar(25),
@BS nchar(10),
@PC nchar(1),
@Units int,
@Rate money,
@AmtPPD money,
@AmtCOL money,
@BrkRate money,
@BrkAmt money,
@CreatedBy nchar(25)
AS
	SET XACT_ABORT ON
	BEGIN TRAN
		INSERT INTO [dbo].[Freight]
					([BookingId]
					,[Code]
					,[BS]
					,[PC]
					,[Units]
					,[Rate]
					,[AmtPPD]
					,[AmtCOL]
					,[BrkRate]
					,[BrkAmt]
					,[CreatedBy])
				VALUES
					(@BookingId
					,@Code
					,@BS
					,@PC
					,@Units
					,@Rate
					,@AmtPPD
					,@AmtCOL
					,@BrkRate
					,@BrkAmt
					,@CreatedBy)
	COMMIT TRANSACTION

