CREATE PROCEDURE [dbo].[InsertBooking](
	@createBy NCHAR(50),
	@createTime DateTime,
	@modifyTime DateTime,
	@billToId int,
	@shipperId int,
	@carrierId int,
	@vessel nvarchar(50),
	@vsl nchar(10),
	@originId int,
	@loadId int,
	@dischargeId int,
	@destinationId int,
	@commodity nvarchar(200),
	@equiment nvarchar(100),
	@temp nchar(10),
	@vents nchar(10),
	@status nchar(10),
	@notes ntext
)
AS
BEGIN
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
	[OriginId],
	[LoadId],     
	[DischargeId],
	[DestinationId],
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
	@originId,
	@loadId,
	@dischargeId,
	@destinationId,
	@commodity,
	@equiment,
	@temp,
	@vents,
	@status,
	@notes
)
	COMMIT TRAN
END
GO