CREATE PROCEDURE [dbo].[InsertUpdateCOO]
	@Id int,
	@BookingId int,
	@BOLRef nvarchar(25),
	@CertificateRef nvarchar(25),
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
		IF EXISTS (SELECT [Id] FROM [dbo].[CertOfOrigin] WHERE Id = @Id)
	BEGIN
		UPDATE [dbo].[CertOfOrigin]
		   SET [BookingId] = @BookingId
			  ,[BOLRef] = @BOLRef
			  ,[CertificateRef] = @CertificateRef
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
		INSERT INTO [dbo].[CertOfOrigin]
           ([BookingId]
           ,[BOLRef]
		   ,[CertificateRef]
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
			,@CertificateRef
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