--1) Write a query to return all category names with their descriptions from the Categories table.
SELECT CategoryName, Description
FROM Categories;

--2) Write a query to return the contact name, customer id, company name and city name of all Customers in London
SELECT ContactName, CustomerID, CompanyName, City
FROM Customers
WHERE City = 'London';

--3) Write a query to return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number
SELECT *
FROM Suppliers
WHERE Fax != 'null'
AND (ContactTitle = 'Marketing Manager' OR ContactTitle = 'Sales Representative');

--4) Write a query to return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Dec 31, 1997 and with freight under 100 units.
SELECT CustomerID
FROM Orders
WHERE RequiredDate BETWEEN '1997-01-01' AND '1997-12-31'
AND Freight < 100;

--5) Write a query to return a list of company names and contact names of all customers from Mexico, Sweden and Germany.
SELECT CompanyName, ContactName
FROM Customers
WHERE Country = 'Mexico' OR Country = 'Sweden' OR Country = 'Germany';

--6) Write a query to return a count of the number of discontinued products in the Products table.
SELECT COUNT(ProductID) AS NumDiscontinued
FROM Products
WHERE Discontinued = 1;

--7) Write a query to return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.
SELECT CategoryName, Description
FROM Categories
WHERE CategoryName LIKE 'Co%';

--8) Write a query to return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.
SELECT CompanyName, City, Country, PostalCode
FROM Suppliers
WHERE Address LIKE '%rue%'
ORDER BY CompanyName;

--9) Write a query to return the product id and the quantity ordered for each product labelled as 'Quantity Purchased' in the Order Details table ordered by the Quantity Purchased in descending order.
SELECT ProductID, Quantity AS 'Quantity Purchased'
FROM OrderDetails
ORDER BY Quantity DESC;

--10) Write a query to return the company name, address, city, postal code and country of all customers with orders that shipped using Speedy Express, along with the date that the order was made.
SELECT Customers.CompanyName, Customers.Address, Customers.City, Customers.PostalCode, Customers.Country, Orders.OrderDate
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.ShipVia = 1;

--11) Write a query to return a list of Suppliers containing company name, contact name, contact title and region description.
SELECT CompanyName, ContactName, ContactTitle, Region AS 'Region Description'
FROM Suppliers;

--12) Write a query to return all product names from the Products table that are condiments.
SELECT Products.ProductName
FROM Products
INNER JOIN Categories
ON Products.CategoryID = Categories.CategoryID
WHERE Products.CategoryID = 2;

--13) Write a query to return a list of customer names who have no orders in the Orders table.
SELECT ContactName, CustomerID
FROM Customers
WHERE Customers.CustomerID NOT IN (
	SELECT CustomerID
	FROM Orders
)
;

--14) Write a query to add a shipper named 'Amazon' to the Shippers table using SQL.
SET IDENTITY_INSERT Shippers ON
INSERT INTO Shippers (ShipperID, CompanyName, Phone)
VALUES (4,'Amazon','(503)555-9999'); 

--15) Write a query to change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.
UPDATE Shippers
SET CompanyName = 'Amazon Prime Shipping'
WHERE CompanyName = 'Amazon';

--16) Write a query to return a complete list of company names from the Shippers table. Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
SELECT Orders.ShipName, CONVERT(int,ROUND(SUM(Orders.Freight),0)) AS 'Freight Total'
FROM Shippers
LEFT JOIN Orders
ON Shippers.ShipperID = Orders.ShipVia 
GROUP BY Orders.ShipName;
--tODO: FIND OUT WHERE NULL CAME FROM

--17) Write a query to return all employee first and last names from the Employees table by combining the 2 columns aliased as 'DisplayName'. The combined format should be 'LastName, FirstName'.
SELECT concat(LastName, ', ',FirstName) AS DisplayName
FROM Employees;

--18) Write a query to add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.

INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
VALUES ('GOLIA', 'Gogo Gadget', 'Travis Golia', 'Coder', '123 Main St', 'Poway', 'CA', 92064, 'USA', '(123)456-7890', NULL);

SET IDENTITY_INSERT Orders ON
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES (11078, 'GOLIA', 4, '2016-10-30', '2016-11-16', '2016-11-12', 3, 33.12, 'Wowow', '123 Front St', 'Berlin', NULL, 44087, 'Germany');

INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11078, 6, 25.00, 2, 0);

--19) Write a query to remove yourself and your order from the database.
DELETE FROM OrderDetails
WHERE OrderID = 11078;

DELETE FROM Orders
WHERE OrderID = 11078; 

DELETE FROM Customers
WHERE CustomerID = 'GOLIA';

--NOTE: TO MAKE THIS WORK, I WENT INTO TABLE DESIGN->RELATIONSHIPS AND UPDATED THE 'INSERT AND UPDATE Specific' TO 'Cascade' SO THAT IT I COULD DELETE LINKED COLUMNS WITH NO ERROR
--ALSO, THIS ONLY WORKS NOW WHEN I RUN IT TWICE... WOULD DEFINITELY LIKE TO UNDERSTAND ADDING/DELETING LINKED VALUES BETTER

--20) Write a query to return a list of products from the Products table along with the total units in stock for each product. Include only products with TotalUnits greater than 100.
SELECT ProductName, UnitsInStock
FROM Products
WHERE UnitsInStock > 100;