/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 *
  FROM [GiffiDB].[dbo].[Company]

  INSERT INTO [dbo].[Company]
           ([CompanyName],[Code],CompanyType,[FederalNumber],[Address1],[Address2],[City],[State],[ZipCode],[ZipCode2],[Country],[Phone],[Email])
     VALUES ('Asia Company','ABC USA','Vendor','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('Euro Company','XYZ USA','Carrier','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('Seattle Company','123 USA','Carrier','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('China Company','XYZ USA','Carrier','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('GIFFI Company','Giffi USA','Vendor','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('JOHN Company','XYZ USA','Vendor','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('JOHN Company','XYZ USA','Vendor','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('JOHN Company','XYZ USA','Vendor','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com')
GO

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