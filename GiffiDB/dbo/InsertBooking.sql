CREATE PROCEDURE [dbo].[InsertBooking](
	@createBy NCHAR(50),
	@createTime DateTime,
	@modifyTime DateTime,
	@billToId int,
	@shipperId int,
	@carrierId int,
	@vessel nvarchar(50),
	@vsl nchar(10),
	@origin nvarchar(50),
	@load nvarchar(50),
	@discharge nvarchar(50),
	@destination nvarchar(50),
	@commodity nvarchar(200),
	@equiment nvarchar(100),
	@temp nchar(10),
	@vents nchar(10),
	@status nchar(10),
	@notes ntext
)
AS
BEGIN
	Declare @bookingId as Int

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
	[Commodity],
	[Equiment],    
	[Temp],     
	[Vents],
	[Status],
	[Notes])
 VALUES(
	@createBy,
	@createTime,
	@modifyTime,
	@billToId,
	@shipperId,
	@carrierId,
	@vessel,
	@vsl,
	@origin,
	@load,
	@discharge,
	@destination,
	@commodity,
	@equiment,
	@temp,
	@vents,
	@status,
	@notes
)

	COMMIT TRAN
	
	 set @bookingId = SCOPE_IDENTITY()
	 
	return @bookingId

END
GO