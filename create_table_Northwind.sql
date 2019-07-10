CREATE TABLE "Categories" (
	"CategoryID" INT not null,
	"CategoryName" VARCHAR(15) not null,
	"Description" TEXT,
	"Picture" BLOB,
	primary key("CategoryID"));

CREATE TABLE "CustomerCustomerDemo" (
	"CustomerID" VARCHAR(5) not null,
	"CustomerTypeID" VARCHAR(10) not null,
	primary key("CustomerID", "CustomerTypeID"));

CREATE TABLE "CustomerDemographics" (
	"CustomerTypeID" VARCHAR(10) not null,
	"CustomerDesc" TEXT,
	primary key("CustomerTypeID"));

CREATE TABLE "Customers" (
	"CustomerID" VARCHAR(5) not null,
	"CompanyName" VARCHAR(40) not null,
	"ContactName" VARCHAR(30),
	"ContactTitle" VARCHAR(30),
	"Address" VARCHAR(60),
	"City" VARCHAR(15),
	"Region" VARCHAR(15),
	"PostalCode" VARCHAR(10),
	"Country" VARCHAR(15),
	"Phone" VARCHAR(24),
	"Fax" VARCHAR(24),
	primary key("CustomerID"));

CREATE TABLE "Employees" (
	"EmployeeID" INT not null,
	"LastName" VARCHAR(20) not null,
	"FirstName" VARCHAR(10) not null,
	"Title" VARCHAR(30),
	"TitleOfCourtesy" VARCHAR(25),
	"BirthDate" TIMESTAMP,
	"HireDate" TIMESTAMP,
	"Address" VARCHAR(60),
	"City" VARCHAR(15),
	"Region" VARCHAR(15),
	"PostalCode" VARCHAR(10),
	"Country" VARCHAR(15),
	"HomePhone" VARCHAR(24),
	"Extension" VARCHAR(4),
	"Photo" BLOB,
	"Notes" TEXT,
	"ReportsTo" INT,
	"PhotoPath" VARCHAR(255),
	primary key("EmployeeID"));

CREATE TABLE "EmployeeTerritories" (
	"EmployeeID" INT not null,
	"TerritoryID" VARCHAR(20) not null,
	primary key("EmployeeID", "TerritoryID"));

CREATE TABLE "Order Details" (
	"OrderID" INT,
	"ProductID" INT,
	"UnitPrice" FLOAT(26),
	"Quantity" INT,
	"Discount" FLOAT(13),
	primary key("OrderID", "ProductID"));

CREATE TABLE "Orders" (
	"OrderID" INT not null,
	"CustomerID" VARCHAR(5),
	"EmployeeID" INT,
	"OrderDate" TIMESTAMP,
	"RequiredDate" TIMESTAMP,
	"ShippedDate" TIMESTAMP,
	"ShipVia" INT,
	"Freight" FLOAT(26),
	"ShipName" VARCHAR(40),
	"ShipAddress" VARCHAR(60),
	"ShipCity" VARCHAR(15),
	"ShipRegion" VARCHAR(15),
	"ShipPostalCode" VARCHAR(10),
	"ShipCountry" VARCHAR(15),
	primary key("OrderID"));

CREATE TABLE "Products" (
	"ProductID" INT not null,
	"ProductName" VARCHAR(40) not null,
	"SupplierID" INT,
	"CategoryID" INT,
	"QuantityPerUnit" VARCHAR(20),
	"UnitPrice" FLOAT(26),
	"UnitsInStock" INT,
	"UnitsOnOrder" INT,
	"ReorderLevel" INT,
	"Discontinued" INT not null,
	primary key("ProductID"));

CREATE TABLE "Region" (
	"RegionID" INT not null,
	"RegionDescription" VARCHAR(50) not null,
	primary key("RegionID"));

CREATE TABLE "Shippers" (
	"ShipperID" INT not null,
	"CompanyName" VARCHAR(40) not null,
	"Phone" VARCHAR(24),
	primary key("ShipperID"));

CREATE TABLE "Suppliers" (
	"SupplierID" INT not null,
	"CompanyName" VARCHAR(40) not null,
	"ContactName" VARCHAR(30),
	"ContactTitle" VARCHAR(30),
	"Address" VARCHAR(60),
	"City" VARCHAR(15),
	"Region" VARCHAR(15),
	"PostalCode" VARCHAR(10),
	"Country" VARCHAR(15),
	"Phone" VARCHAR(24),
	"Fax" VARCHAR(24),
	"HomePage" TEXT,
	primary key("SupplierID"));

CREATE TABLE "Territories" (
	"TerritoryID" VARCHAR(20) not null,
	"TerritoryDescription" VARCHAR(50) not null,
	"RegionID" INT not null,
	primary key("TerritoryID"));

CREATE TABLE "Alphabetical list of products" (
	"ProductID" INT,
	"ProductName" VARCHAR(40),
	"SupplierID" INT,
	"CategoryID" INT,
	"QuantityPerUnit" VARCHAR(20),
	"UnitPrice" FLOAT(26),
	"UnitsInStock" INT,
	"UnitsOnOrder" INT,
	"ReorderLevel" INT,
	"Discontinued" INT,
	"CategoryName" VARCHAR(15));

CREATE TABLE "Current Product List" (
	"ProductID" INT,
	"ProductName" VARCHAR(40));

CREATE TABLE "Customer and Suppliers by City" (
	"City" VARCHAR(15),
	"CompanyName" VARCHAR(40),
	"ContactName" VARCHAR(30),
	"Relationship" );

CREATE TABLE "Order Details Extended" (
	"OrderID" INT,
	"ProductID" INT,
	"ProductName" VARCHAR(40),
	"UnitPrice" FLOAT(26),
	"Quantity" INT,
	"Discount" FLOAT(13),
	"ExtendedPrice" );

CREATE TABLE "Order Subtotals" (
	"OrderID" INT,
	"Subtotal" );

CREATE TABLE "Summary of Sales by Quarter" (
	"ShippedDate" TIMESTAMP,
	"OrderID" INT,
	"Subtotal" );

CREATE TABLE "Summary of Sales by Year" (
	"ShippedDate" TIMESTAMP,
	"OrderID" INT,
	"Subtotal" );

CREATE TABLE "Orders Qry" (
	"OrderID" INT,
	"CustomerID" VARCHAR(5),
	"EmployeeID" INT,
	"OrderDate" TIMESTAMP,
	"RequiredDate" TIMESTAMP,
	"ShippedDate" TIMESTAMP,
	"ShipVia" INT,
	"Freight" FLOAT(26),
	"ShipName" VARCHAR(40),
	"ShipAddress" VARCHAR(60),
	"ShipCity" VARCHAR(15),
	"ShipRegion" VARCHAR(15),
	"ShipPostalCode" VARCHAR(10),
	"ShipCountry" VARCHAR(15),
	"CompanyName" VARCHAR(40),
	"Address" VARCHAR(60),
	"City" VARCHAR(15),
	"Region" VARCHAR(15),
	"PostalCode" VARCHAR(10),
	"Country" VARCHAR(15));

CREATE TABLE "Products Above Average Price" (
	"ProductName" VARCHAR(40),
	"UnitPrice" FLOAT(26));

CREATE TABLE "Products by Category" (
	"CategoryName" VARCHAR(15),
	"ProductName" VARCHAR(40),
	"QuantityPerUnit" VARCHAR(20),
	"UnitsInStock" INT,
	"Discontinued" INT);

