CREATE PROCEDURE [dbo].[UpdateBooking](
	@bookingId int,
	@createdBy NCHAR(50),
	@createdTime DateTime,
	@modifiedTime DateTime,
	@billToId int,
	@shipperId int,
	@carrierId int,
	@vessel nvarchar(50),
	@vsl nchar(10),
	@origin nvarchar(50),
	@load nvarchar(50),
	@discharge nvarchar(50),
	@destination nvarchar(50),
	@cutOffDate Datetime,
	@DOC Datetime,
	@cargoCut Datetime,
	@VGM Float,
	@commodity nvarchar(200),
	@equipment nvarchar(100),
	@temp nchar(10),
	@vents nchar(10),
	@status nchar(15),
	@notes nvarchar(500)
)
AS
BEGIN
	BEGIN TRAN 
	SET XACT_ABORT ON
	UPDATE [dbo].[Booking]
	SET
		[CreatedBy]=@createdBy,        
		[ModifiedTime]=@modifiedTime,  
		[BillToId]= @billToId, 
		[ShipperId] = @shipperId,     
		[CarrierId] = @carrierId,    
		[Vessel] = @vessel,     
		[VSL] = @vsl,       
		[Origin] = @origin,
		[Load] = @load,     
		[Discharge] = @discharge,
		[Destination] = @destination,
		[CutOffDate] = @cutOffDate,
		[DOC] = @DOC,
		[CargoCut] = @cargoCut,
		[VGM] = @VGM,
		[Commodity] = @commodity,
		[Equipment] = @equipment,    
		[Temp] = @temp,     
		[Vents] = @vents,
		[Notes] = @notes
	WHERE Id = @bookingId
	COMMIT TRAN
END
GO