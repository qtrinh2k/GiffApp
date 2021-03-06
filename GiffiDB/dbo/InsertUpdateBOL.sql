﻿CREATE PROCEDURE [dbo].[InsertUpdateBOL]
	@Id int,
	@BookingId int,
	@BOLRef nvarchar(25),
	@ConsigneeAddress nvarchar(200),
	@ConsigneeRef nvarchar(25),
	@PlaceOfReceipt nvarchar(25),
	@NotifyAddress nvarchar(200),
	@PlaceOfDelivery nvarchar(25),
	@SupplierAddress nvarchar(200),
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
			  ,[ConsigneeAddress] = @ConsigneeAddress
			  ,[ConsigneeRef] = @ConsigneeRef
			  ,[PlaceOfReceipt] = @PlaceOfReceipt
			  ,[NotifyAddress] = @NotifyAddress
			  ,[PlaceOfDelivery] = @PlaceOfDelivery
			  ,[SupplierAddress] = @SupplierAddress
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
           ,[ConsigneeAddress]
           ,[ConsigneeRef]
           ,[PlaceOfReceipt]
           ,[NotifyAddress]
           ,[PlaceOfDelivery]
           ,[SupplierAddress]
           ,[WarehouseAddress]
           ,[Notes]
           ,[PlaceOfIssue]
           ,[DateOfIssue]
           ,[CreatedDate]
           ,[ModifiedDate])
		VALUES		
			(@BookingId
			,@BOLRef
			,@ConsigneeAddress
			,@ConsigneeRef
			,@PlaceOfReceipt
			,@NotifyAddress
			,@PlaceOfDelivery
			,@SupplierAddress
			,@WarehouseAddress
			,@Notes
			,@PlaceOfIssue
			,@DateOfIssue
			,@CreatedDate
			,@ModifiedDate)
		COMMIT TRANSACTION

		SELECT SCOPE_IDENTITY()
	END