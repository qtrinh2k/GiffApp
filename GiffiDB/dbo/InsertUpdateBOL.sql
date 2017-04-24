CREATE PROCEDURE [dbo].[InsertUpdateBOL]
	@Id int,
	@BookingId int,
	@BOLRef nvarchar(25),
	@ConsigneeId int,
	@ConsigneeAddress nvarchar(200),
	@ConsigneeRef nvarchar(25),
	@PlaceOfReceipt nvarchar(25),
	@NotifyId int,
	@NotifyAddress nvarchar(200),
	@PlaceOfDelivery nvarchar(25),
	@SupplierId int,
	@SupplierAddress nvarchar(200),
	@WarehouseId int,
	@WarehouseAddress nvarchar(200),
	@Notes nvarchar(200),
	@PlaceOfIssue nvarchar(25),
	@DateOfIssue datetime,
	@CreatedDate datetime,
	@ModifiedDate datetime
AS
	SET XACT_ABORT ON
		IF EXISTS (SELECT [Id] FROM [dbo].[BillOfLanding] WHERE Id = @Id)
	BEGIN
		UPDATE [dbo].[BillOfLanding]
		   SET [BookingId] = @BookingId
			  ,[BOLRef] = @BOLRef
			  ,[ConsigneeId] = @ConsigneeId
			  ,[ConsigneeAddress] = @ConsigneeAddress
			  ,[ConsigneeRef] = @ConsigneeRef
			  ,[PlaceOfReceipt] = @PlaceOfReceipt
			  ,[NotifyId] = @NotifyId
			  ,[NotifyAddress] = @NotifyAddress
			  ,[PlaceOfDelivery] = @PlaceOfDelivery
			  ,[SupplierId] = @SupplierId
			  ,[SupplierAddress] = @SupplierAddress
			  ,[WarehouseId] = @WarehouseId
			  ,[WarehouseAddress] = @WarehouseAddress
			  ,[Notes] = @Notes
			  ,[PlaceOfIssue] = @PlaceOfIssue
			  ,[DateOfIssue] = @DateOfIssue
			  ,[ModifiedDate] = @ModifiedDate
		 WHERE [Id] = @Id

		 SELECT @Id
	END
	ELSE
	BEGIN
		BEGIN TRAN
		INSERT INTO [dbo].[BillOfLanding]
           ([BookingId]
           ,[BOLRef]
           ,[ConsigneeId]
           ,[ConsigneeAddress]
           ,[ConsigneeRef]
           ,[PlaceOfReceipt]
           ,[NotifyId]
           ,[NotifyAddress]
           ,[PlaceOfDelivery]
           ,[SupplierId]
           ,[SupplierAddress]
           ,[WarehouseId]
           ,[WarehouseAddress]
           ,[Notes]
           ,[PlaceOfIssue]
           ,[DateOfIssue]
           ,[CreatedDate]
           ,[ModifiedDate])
		VALUES		
			(@BookingId
			,@BOLRef
			,@ConsigneeId
			,@ConsigneeAddress
			,@ConsigneeRef
			,@PlaceOfReceipt
			,@NotifyId
			,@NotifyAddress
			,@PlaceOfDelivery
			,@SupplierId
			,@SupplierAddress
			,@WarehouseId
			,@WarehouseAddress
			,@Notes
			,@PlaceOfIssue
			,@DateOfIssue
			,@CreatedDate
			,@ModifiedDate)
		COMMIT TRANSACTION

		SELECT SCOPE_IDENTITY()
	END