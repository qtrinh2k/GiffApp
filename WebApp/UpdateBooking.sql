CREATE PROCEDURE [dbo].[UpdateBooking]
	@Id int,
	@createdBy NCHAR(50),
	@modifiedTime DateTime,
	@billToId int,
	@shipperId int,
	@shipperRefNo nvarchar(25),
	@carrierId int,
	@vessel nvarchar(50),
	@voyage nchar(10),
	@origin nvarchar(50),
	@load nvarchar(50),
	@ETD Datetime,
	@discharge nvarchar(50),
	@destination nvarchar(50),
	@ETA Datetime,
	@cutOffDate Datetime,
	@DOC Datetime,
	@cargoCut Datetime,
	@VGM Datetime,
	@commodity nvarchar(200),
	@equipment nvarchar(100),
	@temp nchar(10),
	@vents nchar(10),
	@notes nvarchar(500)
AS

BEGIN TRAN
	SET XACT_ABORT ON
UPDATE [dbo].[Booking]
   SET [CreatedBy] = @createdBy
      ,[ModifiedTime] = @modifiedTime
      ,[BillToId] = @billToId
      ,[ShipperId] = @shipperId
      ,[ShipperRefNo] = @shipperRefNo
      ,[CarrierId] = @carrierId
      ,[Vessel] = @vessel
      ,[Voyage] = @voyage
      ,[Origin] = @origin
      ,[Load] = @load
      ,[ETD] = @ETD
      ,[Discharge] = @discharge
      ,[Destination] = @destination
      ,[ETA] = @ETA
      ,[CutOffDate] = @cutOffDate
      ,[DOC] = @DOC
      ,[CargoCut] = @cargoCut
      ,[VGM] = @VGM
      ,[Commodity] = @commodity
      ,[Equipment] = @equipment
      ,[Temp] = @temp
      ,[Vents] = @vents
      ,[Notes] = @notes
      ,[Status] = 'UPDATE'
 WHERE [Id] = @Id
 COMMIT TRAN