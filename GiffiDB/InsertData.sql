/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Id]
      ,[CompanyName]
      ,[Code]
      ,[CompanyType]
      ,[FederalNumber]
      ,[Address1]
      ,[Address2]
      ,[City]
      ,[State]
      ,[Country]
      ,[ZipCode]
      ,[ZipCode2]
      ,[Phone]
      ,[Email]
      ,[CreatedDate]
  FROM [GiffiDB].[dbo].[Company]

  INSERT INTO [dbo].[Company]
           ([CompanyName],[Code],CompanyType,[FederalNumber],[Address1],[Address2],[City],[State],[ZipCode],[ZipCode2],[Country],[Phone],[Email])
     VALUES ('Asia Company','ABC USA','Vendor','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('Euro Company','XYZ USA','Carrier','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('Seattle Company','XYZ USA','Carrier','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('China Company','XYZ USA','Carrier','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('GIFFI Company','XYZ USA','Vendor','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com'),
			('JOHN Company','XYZ USA','Vendor','123AKD','123 1st Ave','Suite 2','Seattle','WA','98101','0000','USA','206-421-2345','steve@giffi.com')
GO