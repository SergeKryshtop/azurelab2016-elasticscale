/*****************************************************************************
*   FileName:  Create Enlarged AdventureWorks Tables.sql
*
*   Summary: Creates an enlarged version of the AdventureWorks database
*            for use in demonstrating SQL Server performance tuning and
*            execution plan issues.
*
*   Date: November 14, 2011 
*
*   SQL Server Versions:
*         2008, 2008R2, 2012
*         
******************************************************************************
*   Copyright (C) 2011 Jonathan M. Kehayias, SQLskills.com
*   All rights reserved. 
*
*   For more scripts and sample code, check out 
*      http://sqlskills.com/blogs/jonathan
*
*   You may alter this code for your own *non-commercial* purposes. You may
*   republish altered code as long as you include this copyright and give 
*	due credit. 
*
*
*   THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
*   ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
*   TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
*   PARTICULAR PURPOSE. 
*
******************************************************************************/





IF EXISTS(SELECT 1 FROM SalesLT.SalesOrderHeaderEnlarged)
BEGIN

	DELETE FROM SalesLT.SalesOrderOrderEnlarged;
	
	DELETE FROM SalesLT.SalesOrderHeaderEnlarged;
END



SET IDENTITY_INSERT SalesLT.SalesOrderHeaderEnlarged ON
GO
INSERT INTO SalesLT.SalesOrderHeaderEnlarged (
[SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[ShipToAddressID]
      ,[BillToAddressID]
      ,[ShipMethod]
      ,[CreditCardApprovalCode]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[Comment]
      ,[rowguid]
      ,[ModifiedDate]
	  ,TerritoryID

)
SELECT 
[SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[ShipToAddressID]
      ,[BillToAddressID]
      ,[ShipMethod]
      ,[CreditCardApprovalCode]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[Comment]
      ,[rowguid]
      ,[ModifiedDate]
	  ,TerritoryID
FROM SalesLT.SalesOrderHeader WITH (HOLDLOCK TABLOCKX)
GO
SET IDENTITY_INSERT SalesLT.SalesOrderHeaderEnlarged OFF

;

SET IDENTITY_INSERT SalesLT.SalesOrderDetailEnlarged ON
;
BEGIN TRANSACTION


DECLARE @TableVar TABLE
(OrigSalesOrderID int, NewSalesOrderID int)

declare @ValuesTable TABLE (Number int)
;
WITH tblValues ( Number) as
(
      SELECT 1
      UNION ALL
      SELECT Number + 1
      FROM tblValues
      WHERE Number < 1000
)
INSERT INTO @ValuesTable
SELECT * FROM tblValues
OPTION ( MAXRECURSION 0);
;
INSERT INTO SalesLT.SalesOrderHeaderEnlarged 
	(RevisionNumber, OrderDate, DueDate, ShipDate, Status, OnlineOrderFlag, 
	 PurchaseOrderNumber, AccountNumber, CustomerID, TerritoryID, 
	 BillToAddressID, ShipToAddressID, ShipMethod, 
	 CreditCardApprovalCode, SubTotal, TaxAmt, Freight, Comment, 
	 rowguid, ModifiedDate)
OUTPUT inserted.Comment, inserted.SalesOrderID
	INTO @TableVar
SELECT RevisionNumber, DATEADD(dd, number, OrderDate) AS OrderDate, 
	 DATEADD(dd, number, DueDate),  DATEADD(dd, number, ShipDate), 
	 Status, OnlineOrderFlag, 
	 PurchaseOrderNumber, 
	 AccountNumber, CustomerID, TerritoryID, BillToAddressID, 
	 ShipToAddressID, ShipMethod, CreditCardApprovalCode, 
	 SubTotal, TaxAmt, Freight, Comment,
	 NEWID(), DATEADD(dd, number, ModifiedDate)
FROM SalesLT.SalesOrderHeader AS soh WITH (HOLDLOCK TABLOCKX)
CROSS JOIN (
		SELECT number
		FROM (	SELECT TOP 10000 number
				FROM @ValuesTable
				ORDER BY NEWID() DESC 
			UNION
				SELECT TOP 10000 number
				FROM @ValuesTable
				ORDER BY NEWID() DESC 
			UNION
				SELECT TOP 10000 number
				FROM @ValuesTable
				ORDER BY NEWID() DESC 
			UNION
				SELECT TOP 10000 number
				FROM @ValuesTable
				ORDER BY NEWID() DESC 
		  ) AS tab
) AS Randomizer
ORDER BY OrderDate, number

INSERT INTO SalesLT.SalesOrderDetailEnlarged 
	(SalesOrderID, OrderQty, ProductID, 
	 UnitPrice, UnitPriceDiscount, rowguid, ModifiedDate)
SELECT 
	tv.NewSalesOrderID, OrderQty, ProductID, 
	UnitPrice, UnitPriceDiscount, NEWID(), ModifiedDate 
FROM SalesLT.SalesOrderDetail AS sod
JOIN @TableVar AS tv
	ON sod.SalesOrderID = tv.OrigSalesOrderID
ORDER BY sod.SalesOrderDetailID

COMMIT