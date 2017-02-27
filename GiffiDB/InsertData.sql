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