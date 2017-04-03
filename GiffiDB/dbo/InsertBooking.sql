CREATE PROCEDURE [dbo].[InsertBooking](
	@createdBy NCHAR(50),
	@createdTime DateTime,
	@modifiedTime DateTime,
	@billToId int,
	@shipperId int,
	@shipperRefNo nvarchar(25),
	@carrierId int,
	@carrierRefNo nvarchar(25),
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
	@status nchar(15),
	@notes nvarchar(500)
)
AS
BEGIN
	Declare @bookingId as Int
	Declare @giffiRefId as bigInt
	BEGIN TRAN 
	SET XACT_ABORT ON
		INSERT INTO Booking (          
	[CreatedBy],     
	[CreatedTime],   
	[ModifiedTime],  
	[BillToId], 
	[ShipperId],
	[ShipperRefNo],     
	[CarrierId],
	[CarrierRefNo], 
	[Vessel],     
	[Voyage],       
	[Origin],
	[Load],
	[ETD],     
	[Discharge],
	[Destination],
	[ETA],
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
	@shipperRefNo,
	@carrierId,
	@carrierRefNo,
	@vessel,
	@voyage,
	@origin,
	@load,
	@ETD,
	@discharge,
	@destination,
	@ETA,
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