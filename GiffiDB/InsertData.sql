/****** Script for SelectTopNRows command from SSMS  ******/
  USE [GiffiDB]
GO

INSERT INTO [dbo].[AccountingCode]
           ([Id]
           ,[Name]
           ,[MapId])
     VALUES
           (4010, 'AF', 'AIRFRT', 5010),
		   (4030, 'OF', 'OCEN FREIGHT', 5030),
		   (4050, 'TRN', 'TRANSLOAD', 5050),
           (4070, 'TRK', 'TRUCKING', 5070),
		   (4090, 'GIC', 'GIFFI COMMISSION', 5090),
		   (4110, 'BLC', 'BANKING - LC', 5110),
           (4130, 'BRK', 'BROKERAGE', 5130),
		   (4140, 'ASF', 'ASSOCIATION FEE', 5140),
		   (4150, 'COO', 'CERT OF ORIGIN', 5150),
           (4170, 'CF', 'CONSULAR FEE', 5170),
		   (4200, 'PP', 'PIER PASS', 5200),
		   (4210, 'CSN', 'COMMISSION', 5210),
           (4310, 'FOR', 'FORDWARDING', null),
		   (4330, 'CS', 'COURIER SERVICES', 5330),
		   (4350, 'DP', 'DOC. PREP', 5350)
GO

INSERT INTO [dbo].[Company]
([Code],[CompanyName],CompanyType,[FederalNumber],[Address],[City],[State],[ZipCode],[Country],[Phone],[Email])
VALUES
('BLOGLO','BLOOM GLOBAL CORP','Customer',NULL,'7293 GOLDEN MEADOW COURT','MISSISSAUGA','ONT','LW50B9','CANADA','604-111-1222',NULL),
('ROCASS','ROCKY & ASSCOCIATES','Customer',NULL,'700 23 ST','REDMOND','WA','98101','USA','206-421-2345','ROCKY@GMAIL.COM'),
('ROMFI','ROMANZOFF FISH CO','Customer',NULL,'4502 14TH AVE NW','SEATTLE','WA','981107','USA',NULL,NULL),
('SALFRU','SALIX FRUITS','Customer',NULL,'1070 BRIDGE MILL AVE','CANTON','GA','30114','USA','917-555-1212',NULL),
('APLUSA','AMERICAN PRES LINES','Vendor',NULL,'100 X ST','SEATTLE','WA','98111','USA',NULL,NULL),
('COSUSA','COSCO SHIPPING CO','Vendor',NULL,'100 Y ST','SEATTLE','WA','98111','USA',NULL,NULL),
('MOLUSA','MOL SHIPPING CO','Vendor',NULL,'25 Z ST','HOUSTON','TX','75451','USA',NULL,NULL),
('HAPUSA','HAPAG LLOYD','Vendor',NULL,'GREEN BOWLING DR','HOUSTON','TX','74541','USA',NULL,NULL),
('NICUSA','NICHRIE USA','Vendor',NULL,'1400 4 TH AVE, SUITE 2010','SEATTLE','WA','98125','USA',NULL,NULL)

--CONCAT(YEAR(GETDATE()) - 2000, CAST(RIGHT('10000' + CAST(@bookingId AS VARCHAR(6)), 6) AS bigint))
declare @startNumber as bigint = 10000
declare @bookingId as bigint = 6000
declare @giffiId as bigint = 0

	if(@giffiId	<= 0)
	begin
		set @giffiId = CONCAT(YEAR(GETDATE()) - 2000, @startNumber + @bookingId)
	end
select  @giffiId



DECLARE @RC int
DECLARE @createdBy nchar(50)
DECLARE @createdTime datetime
DECLARE @modifiedTime datetime
DECLARE @billToId int
DECLARE @shipperId int
DECLARE @carrierId int
DECLARE @vessel nvarchar(50)
DECLARE @vsl nchar(10)
DECLARE @origin nvarchar(50)
DECLARE @load nvarchar(50)
DECLARE @discharge nvarchar(50)
DECLARE @destination nvarchar(50)
DECLARE @commodity nvarchar(200)
DECLARE @equipment nvarchar(100)
DECLARE @temp nchar(10)
DECLARE @vents nchar(10)
DECLARE @status nchar(10)
DECLARE @notes nvarchar(500)

-- TODO: Set parameter values here.
declare @date as datetime = GETDATE()
EXECUTE @RC = [dbo].[InsertBooking] 
   @createdBy = 'steve'
  ,@createdTime = @date
  ,@modifiedTime = @date
  ,@billToId = 1
  ,@shipperId = 2
  ,@carrierId = 3
  ,@vessel = '123'
  ,@vsl = '123'
  ,@origin = 'Seattle'
  ,@load = 'Tokyo'
  ,@discharge = 'Tokyo'
  ,@destination = 'Tokyo'
  ,@commodity = 'abc'
  ,@equipment = '123'
  ,@temp = 78
  ,@vents = '123'
  ,@status = 'Open'
  ,@notes = 'test ttest'
SELECT @RC
GO