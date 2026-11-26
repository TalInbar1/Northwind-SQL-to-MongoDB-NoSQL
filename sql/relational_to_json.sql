--------------------------??????-------------------------


DECLARE @json NVARCHAR(MAX);
SET @json = (
    SELECT 
        CustomerID,
        CompanyName,
        ContactName,
        ContactTitle,
        Address,
        City,
        Region,
        PostalCode,
        Country,
        Phone,
        Fax
    FROM Customer
    FOR JSON PATH
);

SELECT CAST('<root><![CDATA[' + @json + ']]></root>' AS XML) AS ClickHere;



--------------------------??????-------------------------

DECLARE @json NVARCHAR(MAX);
SET @json = (
    SELECT 
        p.ProductID,
        p.ProductName,
        p.UnitPrice,
        p.UnitsInStock,
        -- ????? ?? ???????? ???????? ?????
        JSON_QUERY((SELECT c.CategoryID, c.CategoryName, c.Description
         FROM Category c WHERE c.CategoryID = p.CategoryID
         FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)) AS Category,
        -- ????? ?? ???? ???????? ?????
        JSON_QUERY((SELECT s.SupplierID, s.CompanyName, s.ContactName
         FROM Supplier s WHERE s.SupplierID = p.SupplierID
         FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)) AS Supplier
    FROM Product p
    FOR JSON PATH
);

SELECT CAST('<root><![CDATA[' + @json + ']]></root>' AS XML) AS ClickHere;
--------------------------??????-------------------------

DECLARE @json NVARCHAR(MAX);
SET @json = (
    SELECT 
        e.EmployeeID,
        e.LastName,
        e.FirstName,
        e.Title,
        e.TitleOfCourtesy,
        e.BirthDate,
        e.HireDate,
        e.Address,
        e.City,
        e.Region,
        e.Country,
        e.HomePhone,
        e.Salary,
        
        -- ????? ???? ?????????? ?????? ????? ?????
        (SELECT t.TerritoryID, RTRIM(t.TerritoryDescription) AS TerritoryDescription,
            
            -- ????? ????? (Region) ???????? ???? ?????????
            JSON_QUERY((SELECT r.RegionID, RTRIM(r.RegionDescription) AS RegionDescription
             FROM Region r WHERE r.RegionID = t.RegionID
             FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)) AS Region
             
         FROM Employee_Territory et
         JOIN Territory t ON et.TerritoryID = t.TerritoryID
         WHERE et.EmployeeID = e.EmployeeID
         FOR JSON PATH) AS Territories
         
    FROM Employee e
    FOR JSON PATH
);

SELECT CAST('<root><![CDATA[' + @json + ']]></root>' AS XML) AS ClickHere;


--------------------------??????-------------------------
DECLARE @json NVARCHAR(MAX);
SET @json = (
    SELECT 
        o.OrderID,
        o.OrderDate,
        o.RequiredDate,
        o.ShippedDate,
        o.ShipVia,
        o.Freight,
        o.ShipName,
        o.ShipCity,
        o.ShipCountry,
        
        -- ????? ????? ???????? ????? (????)
        JSON_QUERY((SELECT c.CustomerID, c.CompanyName, c.ContactName 
         FROM Customer c WHERE c.CustomerID = o.CustomerID 
         FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)) AS Customer,
         
        -- ????? ????? ???????? ????? (????)
        JSON_QUERY((SELECT e.EmployeeID, e.FirstName, e.LastName 
         FROM Employee e WHERE e.EmployeeID = o.EmployeeID 
         FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)) AS Employee,
         
        -- ????? ???? ?????? ???????? ????? (????)
        JSON_QUERY((SELECT s.ShipperID, s.CompanyName 
         FROM Shipper s WHERE s.ShipperID = o.ShipVia 
         FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)) AS Shipper,
         
        -- ???? ????? ?????? (???? ??? ???? ?? ??? ?????)
        (SELECT od.ProductID, p.ProductName, od.UnitPrice, od.Quantity, od.Discount
         FROM Order_Detail od 
         JOIN Product p ON od.ProductID = p.ProductID
         WHERE od.OrderID = o.OrderID 
         FOR JSON PATH) AS OrderDetails
         
    FROM [Order] o
    FOR JSON PATH
);

SELECT CAST('<root><![CDATA[' + @json + ']]></root>' AS XML) AS ClickHere;