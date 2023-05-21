-- Show shipmentID's and DeliveryStatus in descending order by ShipmentDate of shipments from this month (march, 2023) that have not been delivered, returned or canceled 
SELECT ShipmentID, DeliveryStatus
FROM Shipment 
WHERE DeliveryStatus NOT IN ('Delivered', 'Returned', 'Canceled')
AND 
ShipmentDate LIKE '2023-03-__'
ORDER BY ShipmentDate DESC;

-- Show the number of shipments for each delivery status
SELECT COUNT(ShipmentID), DeliveryStatus
FROM Shipment 
GROUP BY DeliveryStatus;

-- Show customers that have placed more than 1 different orders
SELECT * 
FROM Customer
NATURAL JOIN 
(SELECT DISTINCT OrderID, CustomerID 
FROM CustomerOrder
GROUP BY CustomerID
HAVING COUNT(OrderID) > 1)
AS distinctCustomerOrders;


DROP FUNCTION IF EXISTS totalPriceForCustomer;
DROP PROCEDURE IF EXISTS categoryIncome;
DROP TRIGGER IF EXISTS Order_Products_After_Insert;

DELIMITER //
CREATE FUNCTION totalPriceForCustomer(inputcustomerID INT,inputOrderID VARCHAR(20)) RETURNS DECIMAL(15,2)
    BEGIN
        DECLARE totalPrice DECIMAL(15,2);
        SELECT SUM(price*AmountProduct) INTO totalPrice From Order_Products natural join Product
        WHERE inputcustomerID = customerID AND inputOrderID = OrderID;
		RETURN totalPrice;
END //
DELIMITER ;

SELECT totalPriceForCustomer(14,'ORD0001');


DELIMITER //
CREATE PROCEDURE categoryIncome(IN _category VARCHAR(20), OUT result int)
BEGIN
    SELECT SUM(AmountProduct * Price) INTO result
    FROM Product 
    RIGHT JOIN Order_Products
    USING (ProductID)
    WHERE Category = _category;
END//
DELIMITER ;

Call categoryIncome('Electronics',@result);
Select @result;

DELIMITER //
CREATE TRIGGER Order_Products_After_Insert
AFTER INSERT ON Order_Products FOR EACH ROW
UPDATE Product
	SET Stock = Stock - NEW.AmountProduct
    Where Product.ProductID = New.ProductID //
DELIMITER ;

SELECT * FROM Order_Products;
SELECT * FROM Product;

SELECT * FROM Order_Products WHERE OrderID = 'ORD0003' AND CustomerID = 1;
SELECT * FROM Product WHERE ProductID = 'P0011';

INSERT Order_Products VALUES
('ORD0003', 1, 'P0011',80);

SELECT * FROM Order_Products WHERE OrderID = 'ORD0003' AND CustomerID = 1;
SELECT * FROM Product WHERE ProductID = 'P0011';


SELECT * FROM Customer WHERE CustomerID = 2;

UPDATE Customer 
SET EmailAddress = "testmail@test.com"
WHERE CustomerID = 2 ;

SELECT * FROM Customer WHERE CustomerID = 2;

SELECT * FROM Customer WHERE CustomerName = 'Mans Hansen';
SELECT * FROM CustomerOrder Where CustomerID = 2;
SELECT * FROM Order_Products Where CustomerID = 2;
SELECT * FROM Shipment Where CustomerID = 2;

DELETE FROM Customer 
Where CustomerName = 'Mans Hansen';

SELECT * FROM Customer WHERE CustomerName = 'Mans Hansen';
SELECT * FROM CustomerOrder Where CustomerID = 2;
SELECT * FROM Order_Products Where CustomerID = 2;
SELECT * FROM Shipment Where CustomerID = 2;

SELECT * FROM Shipment; 

SELECT * FROM Shipment;

UPDATE Shipment SET DeliveryStatus = 
    CASE 
        WHEN DeliveryStatus = 'Order processed' AND CustomerID = 15 
        THEN 'In Transit'
        ELSE DeliveryStatus
    END;

SELECT * FROM Shipment WHERE CustomerID = 15;


SELECT * FROM Supplier WHERE EmailAddress = "Zipzap@BigBrain.com";
SELECT * FROM Supplier_Products WHERE SupplierID = 'SUP015';

DELETE FROM Supplier
    WHERE EmailAddress = "Zipzap@BigBrain.com";
    
SELECT * FROM Supplier WHERE EmailAddress = "Zipzap@BigBrain.com";
SELECT * FROM Supplier_Products WHERE SupplierID = 'SUP015';
