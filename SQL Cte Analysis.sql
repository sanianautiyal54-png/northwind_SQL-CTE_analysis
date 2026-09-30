USE northwind

WITH CustomerOrders AS
(
    SELECT
        CustomerID,
        COUNT(OrderID) AS TotalOrders
    FROM Orders
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    TotalOrders
FROM CustomerOrders
WHERE TotalOrders > 5
ORDER BY TotalOrders DESC;



WITH ProductSales AS
(
    SELECT
        ProductID,
        SUM(Quantity * UnitPrice * (1 - Discount)) AS TotalSales
    FROM [Order Details]
    GROUP BY ProductID
)
SELECT
    ProductID,
    TotalSales
FROM ProductSales
ORDER BY TotalSales DESC;



WITH CustomerOrderCount AS
(
    SELECT
        CustomerID,
        COUNT(OrderID) AS TotalOrders
    FROM Orders
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    TotalOrders
FROM CustomerOrderCount
WHERE TotalOrders > 10
ORDER BY TotalOrders DESC;



WITH EmployeeSales AS
(
    SELECT
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSales
    FROM Employees e
    JOIN Orders o
        ON e.EmployeeID = o.EmployeeID
    JOIN [Order Details] od
        ON o.OrderID = od.OrderID
    GROUP BY
        e.EmployeeID,
        e.FirstName,
        e.LastName
)
SELECT
    EmployeeID,
    EmployeeName,
    TotalSales
FROM EmployeeSales
ORDER BY TotalSales DESC;



WITH CategorySales AS
(
    SELECT
        c.CategoryID,
        c.CategoryName,
        SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSales
    FROM Categories c
    JOIN Products p
        ON c.CategoryID = p.CategoryID
    JOIN [Order Details] od
        ON p.ProductID = od.ProductID
    GROUP BY
        c.CategoryID,
        c.CategoryName
)
SELECT
    CategoryID,
    CategoryName,
    TotalSales
FROM CategorySales
ORDER BY TotalSales DESC;



WITH MonthlySales AS
(
    SELECT
        YEAR(o.OrderDate) AS OrderYear,
        MONTH(o.OrderDate) AS OrderMonth,
        SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSales
    FROM Orders o
    JOIN [Order Details] od
        ON o.OrderID = od.OrderID
    GROUP BY
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
)
SELECT
    OrderYear,
    OrderMonth,
    TotalSales
FROM MonthlySales
ORDER BY
    OrderYear,
    OrderMonth;



WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        c.CompanyName,
        SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSales
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN [Order Details] od
        ON o.OrderID = od.OrderID
    GROUP BY
        c.CustomerID,
        c.CompanyName
)
SELECT
    CustomerID,
    CompanyName,
    TotalSales,
    RANK() OVER (ORDER BY TotalSales DESC) AS SalesRank
FROM CustomerSales
ORDER BY SalesRank;



WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        c.CompanyName,
        SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSales
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN [Order Details] od
        ON o.OrderID = od.OrderID
    GROUP BY
        c.CustomerID,
        c.CompanyName
),
AverageSales AS
(
    SELECT
        AVG(TotalSales) AS AverageCustomerSales
    FROM CustomerSales
)
SELECT
    cs.CustomerID,
    cs.CompanyName,
    cs.TotalSales,
    a.AverageCustomerSales
FROM CustomerSales cs
CROSS JOIN AverageSales a
WHERE cs.TotalSales > a.AverageCustomerSales
ORDER BY cs.TotalSales DESC;


WITH ProductSales AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSales
    FROM Products p
    JOIN [Order Details] od
        ON p.ProductID = od.ProductID
    GROUP BY
        p.ProductID,
        p.ProductName
),
AverageProductSales AS
(
    SELECT
        AVG(TotalSales) AS AverageSales
    FROM ProductSales
)
SELECT
    ps.ProductID,
    ps.ProductName,
    ps.TotalSales,
    aps.AverageSales
FROM ProductSales ps
CROSS JOIN AverageProductSales aps
WHERE ps.TotalSales > aps.AverageSales
ORDER BY ps.TotalSales DESC;



WITH EmployeeSales AS
(
    SELECT
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalSales
    FROM Employees e
    JOIN Orders o
        ON e.EmployeeID = o.EmployeeID
    JOIN [Order Details] od
        ON o.OrderID = od.OrderID
    GROUP BY
        e.EmployeeID,
        e.FirstName,
        e.LastName
),
AverageEmployeeSales AS
(
    SELECT
        AVG(TotalSales) AS AverageSales
    FROM EmployeeSales
)
SELECT
    es.EmployeeID,
    es.EmployeeName,
    es.TotalSales,
    aes.AverageSales,
    CASE
        WHEN es.TotalSales > aes.AverageSales
            THEN 'Above Average'
        ELSE 'Below Average'
    END AS Performance
FROM EmployeeSales es
CROSS JOIN AverageEmployeeSales aes
ORDER BY es.TotalSales DESC;