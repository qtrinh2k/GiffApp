﻿CREATE PROCEDURE [dbo].[DeleteContainer]
	@Id int
AS
BEGIN TRAN
	SET XACT_ABORT ON
	DELETE FROM [dbo].[Container] WHERE Id = @Id
COMMIT TRANSACTION

