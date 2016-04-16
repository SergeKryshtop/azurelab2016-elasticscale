SET TRANSACTION ISOLATION LEVEL READ COMMITTED
GO
WHILE(1 = 1)
BEGIN

SELECT *
FROM 
SalesLT.SalesOrderHeaderEnlarged h 
	INNER JOIN [SalesLT].[SalesOrderDetailEnlarged] d ON h.[SalesOrderID] = d.[SalesOrderID]
	INNER JOIN [SalesLT].[Product] p ON d.ProductID = p.ProductID
WHERE TerritoryID IN (1,2,3) AND DATEPART(year, [ShipDate]) = 2008



SELECT *
FROM 
SalesLT.SalesOrderHeaderEnlarged h 
	INNER JOIN [SalesLT].[SalesOrderDetailEnlarged] d ON h.[SalesOrderID] = d.[SalesOrderID]
	INNER JOIN [SalesLT].[Product] p ON d.ProductID = p.ProductID
WHERE TerritoryID > 3  

END
