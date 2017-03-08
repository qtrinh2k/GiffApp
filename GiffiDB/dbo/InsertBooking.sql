CREATE PROCEDURE [dbo].[InsertBooking](
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
	Declare @bookingId as Int
	Declare @giffiRefId as bigInt
	BEGIN TRAN 
		INSERT INTO Booking (          
	[CreatedBy],     
	[CreatedTime],   
	[ModifiedTime],  
	[BillToId], 
	[ShipperId],     
	[CarrierId],    
	[Vessel],     
	[VSL],       
	[Origin],
	[Load],     
	[Discharge],
	[Destination],
	[CutOffDate],
	[DOC],
	[CargoCut],
	[VGM],
	[Commodity],
	[Equipment],    
	[Temp],     
	[Vents],
	[Status],
	[Notes])
 VALUES(
	@createdBy,
	@createdTime,
	@modifiedTime,
	@billToId,
	@shipperId,
	@carrierId,
	@vessel,
	@vsl,
	@origin,
	@load,
	@discharge,
	@destination,
	@cutOffDate,
	@DOC,
	@cargoCut,
	@VGM,
	@commodity,
	@equipment,
	@temp,
	@vents,
	@status,
	@notes
)

	COMMIT TRAN
	
	 set @bookingId = SCOPE_IDENTITY()
	 
	 EXEC @giffiRefId = InsertBookingReference @bookingId, 0

	return @giffiRefId

END
GO