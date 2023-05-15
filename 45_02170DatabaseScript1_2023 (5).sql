DROP DATABASE IF EXISTS Swebshop;
CREATE DATABASE Swebshop;
USE Swebshop;

DROP TABLE IF EXISTS Order_Products;
DROP TABLE IF EXISTS Supplier_Products;
DROP TABLE IF EXISTS Shipment;
DROP TABLE IF EXISTS CustomerOrder;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS ShippingMethod;
DROP VIEW IF EXISTS active_customers;

CREATE TABLE Customer
	(CustomerID INT AUTO_INCREMENT,
     CustomerName VARCHAR(40),
     PhoneNumber VARCHAR(10),
     EmailAddress VARCHAR(50),
     CustomerAddress VARCHAR(50),
     ZipCode VARCHAR(4),
     PRIMARY KEY(CustomerID)
    );

CREATE TABLE CustomerOrder
	(OrderID VARCHAR(20),
	 CustomerID INT,
     OrderDate DATE, # xx-xx-xxxx day-month-year = DATE
     PRIMARY KEY(OrderID,CustomerID),
     FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
    );

CREATE TABLE ShippingMethod
	(ShipmentMethod VARCHAR(20),
     DeliveryTime VARCHAR(20),
	 Primary KEY(ShipmentMethod)
    );

CREATE TABLE Shipment
    (   ShipmentID VARCHAR(20),
        ShipmentDate DATE,
        DeliveryStatus ENUM('Delivered', 'In Transit', 'Unknown', 'Order processed', 'Order placed', 'Returned', 'Cancelled'),
        OrderID VARCHAR(20),
        CustomerID INT,
        ShipmentMethod VARCHAR(20),
        PRIMARY KEY(ShipmentID, ShipmentDate),
        FOREIGN KEY (OrderID, CustomerID)
        REFERENCES CustomerOrder(OrderID, CustomerID) ON DELETE CASCADE,
        FOREIGN KEY(ShipmentMethod) REFERENCES ShippingMethod(ShipmentMethod)
    );
    
CREATE TABLE Category
	(CategoryName VARCHAR(20),
	 CategoryDescription VARCHAR(100),
     PRIMARY KEY(CategoryName)
    );

CREATE TABLE Product
	(ProductID VARCHAR(20),
	 Price DECIMAL(8,2),
     ProductName VARCHAR(100),
     Category VARCHAR(20),
     ProductDescription VARCHAR(100),
     Stock INT,
     CHECK(Stock > 0),
     PRIMARY KEY(ProductID),
     FOREIGN KEY(Category) REFERENCES Category(CategoryName) ON DELETE SET NULL  
    );

CREATE TABLE Order_Products
	(OrderID VARCHAR(20),
     CustomerID INT,
	 ProductID VARCHAR(20),
     AmountProduct INT,
     PRIMARY KEY(OrderId,CustomerID,ProductID),
     FOREIGN KEY(OrderID) REFERENCES CustomerOrder(OrderID) ON DELETE CASCADE,
     FOREIGN KEY(ProductID) REFERENCES Product(ProductID)   
    );

CREATE TABLE Supplier
	(SupplierID VARCHAR(20),
     SupplierName VARCHAR(40),
     EmailAddress VARCHAR(40),
     SupplierAddress VARCHAR(50),
     ZipCode VARCHAR(4),
     PRIMARY KEY(SupplierID)
    );

CREATE TABLE Supplier_Products
	(SupplierID VARCHAR(20),
	 ProductID VARCHAR(20),
     PRIMARY KEY(SupplierID,ProductID),
     FOREIGN KEY(SupplierID) REFERENCES Supplier(SupplierID) ON DELETE CASCADE,
     FOREIGN KEY(ProductID) REFERENCES Product(productID)
    );
    
CREATE VIEW active_customers AS
    SELECT DISTINCT Customer.CustomerName, Customer.EmailAddress FROM CustomerOrder INNER JOIN Customer
    ON CustomerOrder.CustomerID = Customer.CustomerID
    WHERE CustomerOrder.OrderDate >= date_add(curdate(), INTERVAL -1 MONTH);

INSERT INTO Customer(CustomerName,PhoneNumber,EmailAddress,CustomerAddress,ZipCode) VALUES
('Hans Hansen','4550608010','Hans@example.com','Hansvej 77',4600),
('Mans Hansen','4550438010','Mans@example.com','Mansvej 78',4800),
('Jens Hansen','4520608010','Jens@example.com','Jensvej 80',4600),
('Jans Hansen','4530608010','Jans@example.com','Jansvej 45',4800),
('Lone Hansen','4540608010','Lone@example.com','Hansvej 77',4600),
('Marie Hansen','4560608010','Marie@example.com','Mansvej 78',4800),
('Ole Olesen','4570608010','Ole@example.com','Olevej 37',2700),
('Ulrik Olsen','4580608010','Ulrik@example.com','Ulrikvej 77 st. tv',2800),
('Mads Mansen','4590608010','Mads@example.com','Madsvej 12',2900),
('Gitte Olsen','4551608010','Gitte@example.com','Olevej 37',2700),
('Morten Frandsen','4552608010','Morten@example.com','Mortensvej 453 2th',3700),
('Christian Eriksen','4553608010','Christian@example.com','Christiansvej 20',3800),
('Niels Nielsen','4554608010','Niels@example.com','Nielsvej 32',3900),
('Jacob Hartmann','4555608010','Jacobi@example.com','Jacobivej 45',1600),
('Henrik Heinrichsen','4556608010','Henrik@example.com','Henriksvej 88',1700);



INSERT CustomerOrder VALUES
('ORD0003', 1, curdate()),
('ORD0002', 1, date_add(curdate(), INTERVAL -10 DAY)),
('ORD0001', 1, date_add(curdate(), INTERVAL -12 DAY)),
('ORD0001', 2, date_add(curdate(), INTERVAL -300 DAY)),
('ORD0002', 4, curdate()),
('ORD0001', 4, date_add(curdate(), INTERVAL -5 DAY)),
('ORD0001', 6, curdate()),
('ORD0002', 7, date_add(curdate(), INTERVAL -7 DAY)),
('ORD0001', 7, date_add(curdate(), INTERVAL -20 DAY)),
('ORD0001', 8, date_add(curdate(), INTERVAL -6 DAY)),
('ORD0001', 9, date_add(curdate(), INTERVAL -3 DAY)),
('ORD0001', 10, curdate()),
('ORD0001', 12, date_add(curdate(), INTERVAL -2 DAY)),
('ORD0001', 14, date_add(curdate(), INTERVAL -15 DAY)),
('ORD0001', 15, date_add(curdate(), INTERVAL -30 DAY));



   
INSERT ShippingMethod VALUES
('Home Delivery', '1-2 weeks.'),
('Priority Delivery', '2-5 days.');


INSERT Category VALUES
('Electronics', 'Things that go zip and zap.'),
('Books','Leaf through some dead trees.'),
('Games','How to spend way to much time on your computer or console.'),
('DVD & Blu-Ray', 'For when your tired and just want to relax.'),
('General', 'Just useful stuff.');



INSERT Product VALUES
('P0001', 100.00, 'Printer', 'Electronics', 'A solid printer for the home or office.', 20),
('P0002', 450.00, 'Bowser Party 10', 'Games', 'A game for the whole family.', 100),
('P0003', 99.95, 'Harry Potter and the Garden Gnome', 'Books', 'The long-awaited continuation of the award Harry Potter franchise.', 5),
('P0004', 599.00 , 'The Witcher 4: Complete Edition', 'Games', 'Complete Edition', 10),
('P0005', 99.95 , 'My Name', 'DVD & Blu-Ray', 'A spiritual successor to Your Name by award winning director Makoto Shinkai.', 10),
('P0006', 9999.95, 'LG 4K OLED TV', 'Electronics', 'A TV for the next generation of gamers.', 10),
('P0007', 999.95, 'The Legend of Link: Collector\'s Edition', 'Games', 'Embark on a new adventure in Hyrule.', 5),
('P0008', 150.00, 'Basic Mousepad', 'General', 'A mousepad.', 100),
('P0009', 50.00, 'Cradle: Black Flame', 'Books', 'A book for fantasy enthusiasts.', 50),
('P0010', 1500.00, 'Coffee Machine', 'Electronics', 'A solid coffee machine.', 10),
('P0011', 250.00, 'Hollow Knight: Silksong', 'Games', 'An outstanding metroidvania.', 100),
('P0012', 99.95, 'Howl\'s Flying Castle', 'DVD & Blu-Ray', 'The sequel to Howl\'s Moving Castle by Hayao Miyazaki.', 100),
('P0013', 50.00, 'Basic Paper', 'General', '100 pieces of printer paper.', 100),
('P0014', 300.00, 'Basic Printer Ink', 'General', 'Printer ink.', 100),
('P0015', 2000.00, 'Roomba', 'Electronics', 'No need to worry about vacuuming ever again.', 20);

INSERT Order_Products VALUES
('ORD0003', 1, 'P0001',4),
('ORD0003', 1, 'P0013',15),
('ORD0003', 1, 'P0014',10),
('ORD0002', 1, 'P0004',2),
('ORD0001', 1, 'P0005',3),
('ORD0001', 1, 'P0006',4),
('ORD0001', 2, 'P0007',2),
('ORD0002', 4, 'P0013',40),
('ORD0001', 4, 'P0014',50),
('ORD0001', 4, 'P0001',2),
('ORD0001', 6, 'P0002',20),
('ORD0002', 7, 'P0013',20),
('ORD0001', 7, 'P0014',30),
('ORD0001', 8, 'P0008',50),
('ORD0001', 8, 'P0002',20),
('ORD0001', 9, 'P0009',10),
('ORD0001', 10, 'P0012',15),
('ORD0001', 12, 'P0015',5),
('ORD0001', 12, 'P0010',1),
('ORD0001', 14, 'P0006',2),
('ORD0001', 15, 'P0010',3);


INSERT  Supplier VALUES 
('SUP001', 'Hansens Book Engross', 'Books@HansensEngross.com', 'Karsholtvej 26', '4293'),
('SUP002', 'Burgers DVD emporium', 'contact@BurgersDVDs.com', 'Algade 102', '4300' ),
('SUP003', 'Knuds Tennis shop', 'Knud@KnudsTennis.dk', 'Roskildevej 458', '2620' ),
('SUP004', 'The Gnome Depot', 'Gardengnomes@ThegnomeDepot.com', 'Skovvejen 55', '4690' ),
('SUP005', 'Hans Smykker', 'Kontakt@Hanssmyker.com', 'vesterfarimaksgade 102', '1301' ),
('SUP006', 'Grahams superstrong chili sauces', 'GetSauced@Graham.com', 'Lillevej 5', '5600' ),
('SUP007', 'Super tape supplier', 'contact@Supertape.com', 'Algade 103', '4300' ),
('SUP008', 'Christian Eriksens Bold biks', 'ChrisE@Boldbiksen.com', 'Nansengade 75', '1301' ),
('SUP009', 'Hansens Game Engross', 'Games@HansenEngross.com', 'Karsholtvej 28', '4293' ),
('SUP010', 'Madam Aquas Waterbeds', 'Main@Aquabeds.com', 'vandvej 14', '2720' ),
('SUP011', 'Daves Lumber and lumbar support', 'Dave@ArtisanalWoods.com', 'strandvejen 24', '2660' ),
('SUP013', 'Dennis Blueray shop', 'contact@BluerayShops.com', 'Algade 103', '4300' ),
('SUP014', 'Swebshops Online solutions' , 'Swebshops@gmail.com', 'Raadhusdammen 17', '2620' ),
('SUP015', 'Big brain zap shop', 'Zipzap@BigBrain.com', 'Hovedvejen 27', '9990' );

INSERT Supplier_Products Values
('SUP009','P0002'),
('SUP004','P0003'),
('SUP009','P0004'),
('SUP013','P0005'),
('SUP015','P0006'),
('SUP009','P0007'),
('SUP010','P0008'),
('SUP001','P0009'),
('SUP015','P0010'),
('SUP002','P0011'),
('SUP013','P0012'),
('SUP002','P0012'), 
('SUP011','P0013'),
('SUP006','P0014'),
('SUP015','P0015');


INSERT INTO Shipment(ShipmentID, ShipmentDate, DeliveryStatus, CustomerID, OrderID, ShipmentMethod) VALUES 
('SHIP0001', curdate(), 'Order placed', '1', 'ORD0003', 'Home Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 10 DAY), 'In Transit', '1', 'ORD0002', 'Home Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 12 DAY), 'Delivered', '1', 'ORD0001', 'Priority Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 300 DAY), 'Delivered', '2', 'ORD0001', 'Home Delivery' ),
('SHIP0002', curdate(), 'Order placed', '4', 'ORD0002', 'Priority Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 5 DAY), 'In Transit', '4', 'ORD0001', 'Priority Delivery' ),
('SHIP0003', curdate(), 'Order placed', '6', 'ORD0001', 'Home Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 7 DAY), 'In Transit', '7', 'ORD0002', 'Home Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 20 DAY), 'Unknown', '7', 'ORD0001', 'Home Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 6 DAY), 'In Transit', '8', 'ORD0001', 'Home Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 3 DAY), 'Order processed', '9', 'ORD0001', 'Home Delivery' ),
('SHIP0004', curdate(), 'Order placed', '10', 'ORD0001', 'Priority Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 2 DAY), 'Order processed', '12', 'ORD0001', 'Priority Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 15 DAY), 'Order processed', '14', 'ORD0001', 'Home Delivery' ),
('SHIP0001', date_add(curdate(), INTERVAL - 30 DAY), 'Order processed', '15', 'ORD0001', 'Home Delivery' );


SELECT * FROM Customer;
SELECT * FROM CustomerOrder;
SELECT * FROM ShippingMethod;
SELECT * FROM Shipment;
SELECT * FROM Category;
SELECT * FROM Product;
SELECT * FROM Order_Products;
SELECT * FROM Supplier;
SELECT * FROM Supplier_Products;
SELECT * FROM active_Customers;



