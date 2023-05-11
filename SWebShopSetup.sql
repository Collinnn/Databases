
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS TransactionTable;
DROP TABLE IF EXISTS Transaction_Product;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Catergory;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Supplier_Product;

CREATE TABLE Customers
	(CustomerID VARCHAR(20) NOT NULL,
     CustomerName VARCHAR(20),
     Phone VARCHAR(10),
     Mail VARCHAR(20),
     Address VARCHAr(20),
     PRIMARY KEY(CustomerID)
    );
CREATE TABLE TransactionTable
	(TransactionID VARCHAR(20),
	 CustomerID VARCHAR(20),
     Transaction_Date       VARCHAR(8),    #Assume xx-xx-xxxx day-month-year = 8 
     DISCOUNT	 VARCHAR(20),
     PRIMARY KEY(TransactionID,CustomerID),
     FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID) ON DELETE SET NULL
    );
CREATE TABLE Transaction_Product
	(TransactionID VARCHAR(20),
     CustomerID VARCHAR(20),
     ProductID VARCHAR(20),
     PRIMARY KEY(TransactionID,CustomerID,ProductID),
     FOREIGN KEY(TransactionID) REFERENCES TransactionTable(TransactionID) ON DELETE SET NULL,
     FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID) ON DELETE SET NULL,
     FOREIGN KEY(ProductID) REFERENCES Product(ProductID) ON DELETE SET NULL    
    );
CREATE TABLE Product
	(ProductID VARCHAR(20),
	 Price     VARCHAR(20),
     Category  VARCHAR(20),
     Product_Description VARCHAR(20),
     Stock     VARCHAR(20),
     PRIMARY KEY(ProductID),
     FOREIGN KEY(Category) REFERENCES Category(CategoryName) ON DELETE SET NULL    
    );
CREATE TABLE Category
	(CategoryName VARCHAR(20),
	 Category_Description VARCHAR(20),
     PRIMARY KEY(CategoryName)
    );
CREATE TABLE Supplier
	(SupplierID VARCHAR(20),
     SupplierName VARCHAR(20),
     Mail VARCHAR(20),
     Address VARCHAR(20),
     PRIMARY KEY(SupplierID),
     FOREIGN KEY(SupplierID) REFERENCES Supplier_Product(SupplierID) ON DELETE SET NULL
    );

CREATE TABLE Supplier_Product
	(SupplierID VARCHAR(20),
	 ProductID VARCHAR(20),
     PRIMARY KEY(SupplierID,ProductID),
     FOREIGN KEY(SupplierID) REFERENCES Supplier(SupplierID) ON DELETE SET NULL
    );


    
