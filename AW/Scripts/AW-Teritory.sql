IF EXISTS( SELECT 1 FROM SalesLT.[SalesTerritory])
SET NOEXEC ON
GO

INSERT INTO [SalesLT].[SalesTerritory]
           ([TerritoryID]
		   ,[Name]
           ,[CountryRegionCode]
           ,[Group]
           ,[SalesYTD]
           ,[SalesLastYear]
           ,[CostYTD]
           ,[CostLastYear]
           ,[ModifiedDate])
     VALUES
(1, 'Northwest', 'US', 'North America', 7887186.7882, 3298694.4938, 0.00, 0.00, GETDATE()),
(2, 'Northeast', 'US', 'North America', 2402176.8476, 3607148.9371, 0.00, 0.00, GETDATE()),
(3, 'Central', 'US', 'North America', 3072175.118, 3205014.0767, 0.00, 0.00, GETDATE()),
(4, 'Southwest', 'US', 'North America', 10510853.8739, 5366575.7098, 0.00, 0.00, GETDATE()),
(5, 'Southeast', 'US', 'North America', 2538667.2515, 3925071.4318, 0.00, 0.00, GETDATE()),
(6, 'Canada', 'CA', 'North America', 6771829.1376, 5693988.86, 0.00, 0.00, GETDATE()),
(7, 'France', 'FR', 'Europe', 4772398.3078, 2396539.7601, 0.00, 0.00, GETDATE()),
(8, 'Germany', 'DE', 'Europe', 3805202.3478, 1307949.7917, 0.00, 0.00, GETDATE()),
(9, 'Australia', 'AU', 'Pacific', 5977814.9154, 2278548.9776, 0.00, 0.00, GETDATE()),
(10, 'United Kingdom', 'GB', 'Europe', 5012905.3656, 1635823.3967, 0.00, 0.00, GETDATE())
GO

SELECT * from [SalesLT].[SalesTerritory]

GO
UPDATE header
SET header.TerritoryID = 
(
CASE 
WHEN ad.StateProvince = 'California' THEN 4 
WHEN ad.StateProvince = 'Colorado' THEN 3 
WHEN ad.StateProvince = 'England' THEN 10
WHEN ad.StateProvince = 'Nevada' THEN 1
WHEN ad.StateProvince = 'New Mexico' THEN 5
WHEN ad.StateProvince = 'Utah' THEN 2
END 
)
FROM SalesLT.SalesOrderHeader header INNER JOIN SalesLT.Customer customer ON header.CustomerId = customer.CustomerID
	INNER JOIN SalesLT.CustomerAddress cad ON customer.CustomerID = cad.CustomerId
	INNER JOIN SalesLT.Address ad ON cad.AddressID = ad.AddressID



SET NOEXEC OFF
GO