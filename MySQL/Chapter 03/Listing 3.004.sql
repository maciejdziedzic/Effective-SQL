-- Ensure you've run SalesOrdersStructureMY.sql
-- and SalesOrdersDataMY.sql in the Sample Databases folder
-- in order to run this example. 

USE SalesOrdersSample;

-- Listing 3.4 Equivalent statement of combined views
SELECT c.CustomerID, c.CustFirstName, c.CustLastName, 
  s.LastOrderDate, s.GrandOrderTotal
FROM Customers AS c
INNER JOIN 
  (SELECT o.CustomerID, SUM(o.OrderTotal) AS GrandOrderTotal,
    MAX(o.OrderDate) AS LastOrderDate  
   FROM Orders AS o
   GROUP BY o.CustomerID) AS s
  ON c.CustomerID = s.CustomerID
WHERE EXISTS 
 (SELECT NULL
  FROM Orders AS o
  WHERE o.CustomerID = c.CustomerID
    AND o.OrderDate > DATE_ADD(CURDATE(), INTERVAL -6 MONTH)); 
