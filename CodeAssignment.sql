CREATE TABLE Products(
    ID INT NOT NULL PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL,
    Price NVARCHAR(150) NOT NULL

)
CREATE TABLE Orders(
    ID INT NOT NULL PRIMARY KEY,
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL
)
CREATE TABLE Customers(
    ID INT NOT NULL PRIMARY KEY,
    FirstName NVARCHAR(150) NOT NULL,
    LastName NVARCHAR(150) NOT NULL,
    CardNumber INT NOT NULL
)
ALTER TABLE Products
    ADD CONSTRAINT FK_ProductToOrder
    FOREIGN KEY (ID) REFERENCES Orders(ProductID);

ALTER TABLE Customers
ADD CONSTRAINT FK_CustomersToOrder
FOREIGN KEY (ID) REFERENCES Orders(CustomerID);

SELECT * FROM Orders
SELECT * FROM Products
SELECT * FROM Customers
-- add at least 3 records into each table
INSERT INTO Products(ID, Name, Price) VALUES (1, 'Water', 0.99);
INSERT INTO Products(ID, Name, Price) VALUES (2, 'Soda', 1.99);
INSERT INTO Products(ID, Name, Price) VALUES (3, 'RedBull', 2.99);

INSERT INTO Orders(ID, ProductID, CustomerID) VALUES (1, 1, 1);
INSERT INTO Orders(ID, ProductID, CustomerID) VALUES (2, 2, 2);
INSERT INTO Orders(ID, ProductID, CustomerID) VALUES (3, 3, 3);


INSERT INTO Customers(ID, FirstName, LastName, CardNumber) VALUES (1, 'Tenzin', 'Wangdu', 10);
INSERT INTO Customers(ID, FirstName, LastName, CardNumber) VALUES (2, 'Nick' , 'E', 20);
INSERT INTO Customers(ID, FirstName, LastName, CardNumber) VALUES (3, 'David', 'A', 30);


-- add product IPhone price at $200
INSERT INTO Products(ID, Name, Price) VALUES (4, 'iPhone', 200);

-- add customer Tina Smith
INSERT INTO Customers(ID, FirstName, LastName, CardNumber) VALUES (4, 'Tina', 'Smith', 40);

-- create order for Tina Smith bought an iPhone
INSERT INTO Orders(ID, ProductID, CustomerID) VALUES (4, 4, 4);

--report all orders by Tina Smith
SELECT ID, ProductID
FROM Orders
WHERE CustomerID IN(
                    SELECT ID
                    FROM Customers
                    WHERE FirstName Like '%Tina%' AND LastName LIKE '%Smith%')

-- report all revenue generated by sales of iPhone
SELECT COUNT(o.ID)*p.Price 
FROM Products as p 
    INNER JOIN Orders as o ON p.ID = o.ProductID
WHERE o.ProductId = 4
GROUP BY COUNT(o.ID)*p.Price


--increase the price of iPhone to $250
UPDATE Products
SET 
    Price = 250
WHERE Name IN 
    (SELECT Name FROM Products WHERE Name Like '%iPhone%' )