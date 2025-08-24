1. Order and Customer Insights
--What is the average unit price of all products?

SELECT AVG(Unitprice)
from products;

--Which customers are located in Germany?

SELECT CompanyName, CustomerName, City
FROM customers
WHERE country = 'Germany';

--What orders were made by the customer ALFKI

SELECT OrderID, OrderDate, RequiredDate
FROM orders
WHERE CustomerID = 'ALFKI';


--Which orders were made in 1997?

SELECT OrderID, Orderdate, shipcity
FROM orders
WHERE year(OrderDate) = '1997';

2. Sales Insights
--What is the total sales amount handled by each employee?

SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSales
FROM Employees e
JOIN Orders o 
    ON e.EmployeeID = o.EmployeeID
JOIN `OrderDetails` od 
    ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales DESC;


--What are the top 5 most expensive products, showing their names and prices?

SELECT productname, unitprice
FROM products
ORDER BY unitprice DESC
LIMIT 5;

--Which customers have placed more than 10 orders?

SELECT c.CustomerID, c.CompanyName, COUNT(o.OrderID) AS NumberOfOrders
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(o.OrderID) > 10
ORDER BY NumberOfOrders DESC;

--Which products have never been ordered, along with their suppliers?

SELECT 
    p.ProductName
FROM Products p
JOIN Suppliers s 
    ON p.SupplierID = s.SupplierID
LEFT JOIN OrderDetails od 
    ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL;

--For each order, what is the most expensive product purchased, along with the order ID and customer name?

SELECT 
    c.CustomerID,
    c.CompanyName,
    COUNT(o.OrderID) AS NumberOfOrders
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(o.OrderID) > 10
ORDER BY NumberOfOrders DESC;

Which employees have not processed any orders, and what are their hire dates?

SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    e.HireDate
FROM Employees e
LEFT JOIN Orders o 
    ON e.EmployeeID = o.EmployeeID
WHERE o.EmployeeID IS NULL;

3. Profit Analysis

What is the profit for each order?

SELECT 
    o.OrderID,
    o.OrderDate,
    c.CompanyName AS CustomerName,
    SUM((od.UnitPrice - 5.00) * od.Quantity) AS Profit
FROM Orders o
JOIN OrderDetails od 
    ON o.OrderID = od.OrderID
JOIN Customers c 
    ON o.CustomerID = c.CustomerID
GROUP BY o.OrderID, o.OrderDate, c.CompanyName
ORDER BY Profit DESC;


--Who are the top 3 most profitable customers, based on their total profit contribution?
SELECT 
    c.CompanyName AS CustomerName,
    SUM((od.UnitPrice - 5.00) * od.Quantity) AS TotalProfit
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
JOIN OrderDetails od 
    ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
ORDER BY TotalProfit DESC
LIMIT 3;

 How can employees be ranked by the total number of orders they have processed?    

SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    COUNT(o.OrderID) AS NumberOfOrders,
    RANK() OVER (ORDER BY COUNT(o.OrderID) DESC) AS EmployeeRank
FROM Employees e
JOIN Orders o 
    ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY EmployeeRank;

     

     
     