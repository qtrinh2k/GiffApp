CREATE PROCEDURE [dbo].[InsertFreight]
@BookingId int,
@Code nchar(10),
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
/*
	IF EXISTS(SELECT Count(*) FROM [dbo].[Freight] WHERE [BookingId] = @BookingId)
		BEGIN
			raiserror ('InsertFreight: BookingId already exist!!!', 16, 1) ;
			/*RETURN -100 RECORD ALREADY EXIST*/
		END
	ELSE
		BEGIN
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
		END
*/

