create database TechShop1;
use TechShop1;
CREATE TABLE Customers (
    CustomerID INT not null PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address VARCHAR(255) NOT NULL
);
CREATE TABLE Products (
    ProductID INT not null PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Price DECIMAL NOT NULL
);
CREATE TABLE Orders (
    OrderID INT not null PRIMARY KEY,
    CustomerID INT NOT NULL FOREIGN KEY  REFERENCES Customers(CustomerID) ,
    OrderDate date,
    TotalAmount int,
   
);

CREATE TABLE OrderDetails (
    OrderDetailID int not null PRIMARY KEY,
    OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderID) ,
    ProductID INT NOT NULL FOREIGN KEY  REFERENCES Products(ProductID),
    Quantity INT,
);
CREATE TABLE Inventory (
    InventoryID INT not null PRIMARY KEY,
    ProductID INT NOT NULL  FOREIGN KEY  REFERENCES Products(ProductID) ,
    QuantityInStock INT ,
    LastStockUpdate date
   
);


INSERT INTO Customers VALUES
(1,'Ram', 'Verma', 'ramverma@yahoo.com', '9876543210', '12 MG Road, Delhi'),
(2,'Kishore', 'Patel', 'kishorepatel@gmail.com', '8765432109', '34 Park Street, Mumbai'),
(3,'Kumar', 'Reddy', 'kumarreddy@yahoo.com', '7654321098', '56 Brigade Road, Bangalore'),
(4,'Haley', 'Pearl', 'haleypearl@gmail.com', '6543210987', '78 Connaught Place, Delhi'),
(5,'Nan', 'laks', 'nan.laks@yahoo.com', '5432109876', '90 Banjara Hills, Hyderabad'),
(6,'Harish', 'potta', 'harish@outlook.com', '4321098765', '21 Sarojini Nagar, Chennai'),
(7,'Kamalesh', 'waran', 'kamalesh@yahoo.com', '3210987654', '33 MG Road, Pune'),
(8,'Rahul', 'logesh', 'delhi@gmail.com', '2109876543', '45 Koramangala, Bangalore'),
(9,'Virat', 'kohli', 'anushka@rcb.com', '1098765432', '67 Jubilee Hills, Hyderabad'),
(10,'joshy', 'agarwal', 'joshy@outlook.com', '9988776655', '89 Indiranagar, Bangalore');

INSERT INTO Products  VALUES
(1, 'Laptop', 'HP PAVILION EC 2004 AX', 58000),
(2, 'Smartphone', 'REALME GT NEO 3T', 32000),
(3, 'Tablet', 'Apple iPad Pro 12.9-inch', 90000),
(4, 'Smartwatch', 'BOAT IZTRA', 4500),
(5, 'Headphones', 'CMF BUDS PRO', 3000),
(6, 'Camera', 'Canon EOS 90D DSLR Camera', 120000),
(7, 'Gaming Console', 'Sony PlayStation 5', 50000),
(8, 'Monitor', 'LG 4K UltraFine 27-inch Monitor', 40000),
(9, 'Keyboard', 'Logitech MX Keys Wireless Keyboard', 12000),
(10, 'Mouse', 'Razer DeathAdder V2 Gaming Mouse', 5000);
select * from Products;
INSERT INTO Inventory  VALUES
(1,1, 20,'2025-03-25'),
(2,2, 30,'2025-03-25'),
(3,3, 15,'2025-03-25'),
(4,4, 25,'2025-03-25'),
(5,5, 40,'2025-03-25'),
(6,6, 10,'2025-03-25'),
(7,7, 12,'2025-03-25'),
(8,8, 18,'2025-03-25'),
(9,9, 50,'2025-03-25'),
(10,10, 35,'2025-03-25');
select * from Inventory;
INSERT INTO Orders  VALUES
(1, 1,'2025-03-25',240000),
(2,2,'2025-03-24',85000),
(3, 3,'2025-03-23',90000),
(4, 4,'2025-03-22',45000),
(5, 5,'2025-03-21',30000),
(6, 6,'2025-03-20',120000),
(7, 7,'2025-03-19',50000),
(8,8, '2025-03-18',40000),
(9, 9,'2025-03-17',12000),
(10, 10,'2025-03-16',5000);



INSERT INTO OrderDetails VALUES
(1, 1,1, 2),
(2, 2,2, 1),
(3, 3,3, 1),
(4, 4,4, 2),
(5, 5,5, 3),
(6, 6,6, 1),
(7, 7,7, 1),
(8, 8,8, 2),
(9, 9, 9,1),
(10,10,10, 2);

--1)Write an SQL query to retrieve the names and emails of all customers.

SELECT FirstName, LastName, Email FROM Customers;
--2. List all orders with their order dates and corresponding customer names.
select o.OrderDate,c.FirstName,c.LastName
from Orders o
join Customers c on o.CustomerID=c.CustomerID;
--3. Insert a new customer record into the "Customers" table.
insert into Customers values(11,'dani','shah','dani123@gmail.com','123456789','27 gandhi nagar,chennai');
--4. Update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
update Products set Price=Price*1.10;
--5. Delete a specific order and its associated order details.
delete from OrderDetails where OrderID=2;
select * from OrderDetails;
delete from Orders where OrderID=2;
select * from Orders;
--6)Insert a new order into the "Orders" table.
insert into Orders values(11,11,'2025-03-12',34500);
select * from Orders;
--7) Update the contact information (email and address) of a specific customer.
update Customers set Email='varsh123@gmail.com' , Address='23, nehru nagar,chennai' where CustomerID=3;
select * from Customers;
--8. Recalculate and update the total cost of each order in the "Orders" table.
UPDATE Orders 
SET TotalAmount = (
    SELECT SUM(P.Price * OD.Quantity) 
    FROM OrderDetails OD 
    JOIN Products P ON OD.ProductID = P.ProductID 
    WHERE OD.OrderID = Orders.OrderID
);
SELECT * FROM Orders;
--9. Delete all orders and their associated order details for a specific customer.
DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 5);
DELETE FROM Orders WHERE CustomerID = 5;
SELECT * FROM Orders;
--10. Insert a new electronic gadget product into the "Products" table.
INSERT INTO Products VALUES (11,'AR GLASS', 'META GLASSES', 15000000);
SELECT * FROM Products;
--11. write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status. 
ALTER TABLE Orders ADD Status VARCHAR(20);

UPDATE Orders

SET Status = 'Shipped'

WHERE OrderID = 8;

--to view

select * from Orders

--12.	Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
ALTER TABLE Customers ADD OrderCount INT DEFAULT 0;

UPDATE Customers

SET OrderCount = (

SELECT COUNT(*) FROM Orders WHERE Orders. CustomerID= Customers.CustomerID

);

--to view

select * from Customers

select * from OrderDetails

--task 3

--1.Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.

SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = o.CustomerID;

--2.Write an SQL query to find the total revenue generated by each electronic gadget product. 
--Include the product name and the total revenue.


SELECT P.ProductName, SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName;

--3. List all customers who have made at least one purchase, including their names and contact information.
select distinct c.CustomerID,c.FirstName, c.LastName ,c.Email, c.Phone
from Customers c
join Orders o on c.CustomerID=o.CustomerID;

--4.Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered.
--Include the product name and the total quantity ordered.
SELECT TOP 1 P.ProductName, SUM(OD.Quantity) AS TotalQuantityOrdered

FROM OrderDetails OD

JOIN Products P ON OD.ProductID = P.ProductID

GROUP BY P.ProductName

ORDER BY TotalQuantityOrdered DESC;

--5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding 
--categories.
SELECT ProductID, ProductName, Description

FROM Products;

--6. Write an SQL query to calculate the average order value for each customer. Include the 
--customers name and their average order value.
select c.FirstName,c.LastName, avg(o.TotalAmount) as AverageOrderValue
from Customers c
join Orders o on c.CustomerID=o.CustomerID
Group by c.CustomerID,c.FirstName,c.LastName;

--7. Write an SQL query to find the order with the highest total revenue. Include the order ID, 
--customer information, and the total revenue.
SELECT TOP 1 O.OrderID, C.FirstName, C.LastName, O.TotalAmount

FROM Orders O

JOIN Customers C ON O.CustomerID = C.CustomerID

ORDER BY O.TotalAmount DESC;


--8. Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
SELECT P.ProductName, COUNT(OD.OrderDetailID) AS TimesOrdered

FROM OrderDetails OD

JOIN Products P ON OD.ProductID = P.ProductID

GROUP BY P.ProductName

ORDER BY TimesOrdered DESC;

--9. Write an SQL query to find customers who have purchased a specific electronic gadget product. 
--Allow users to input the product name as a parameter.
SELECT DISTINCT C.CustomerID, C.FirstName, C.LastName, C.Email

FROM Customers C

JOIN Orders O ON C.CustomerID = O.CustomerID

JOIN OrderDetails OD ON O.OrderID = OD.OrderID

JOIN Products P ON OD.ProductID = P.ProductID

WHERE P.ProductName = 'Laptop';

--10. Write an SQL query to calculate the total revenue generated by all orders placed within a 
--specific time period. Allow users to input the start and end dates as parameters

SELECT SUM(TotalAmount) AS TotalRevenue

FROM Orders

WHERE OrderDate BETWEEN '2025-03-01' AND '2025-10-29';


--task 4


--1. Write an SQL query to find out which customers have not placed any orders.
SELECT CustomerID, FirstName, LastName, Email

FROM Customers

WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

--2. Write an SQL query to find the total number of products available for sale. 
SELECT COUNT(*) AS TotalProducts FROM Products;


--3. Write an SQL query to calculate the total revenue generated by TechShop. 

SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders;


--4. Write an SQL query to calculate the average quantity ordered for products in a specific category. 
--Allow users to input the category name as a parameter.

SELECT AVG(OD.Quantity) AS AvgQuantityOrdered

FROM OrderDetails OD

JOIN Products P ON OD.ProductID = P.ProductID

WHERE P.ProductName = 'Laptop'; -- Change product name as needed


--5. Write an SQL query to calculate the total revenue generated by a specific customer. Allow users 
--to input the customer ID as a parameter.

SELECT C.CustomerID, C.FirstName, C.LastName, SUM(O.TotalAmount) AS TotalRevenue

FROM Customers C

JOIN Orders O ON C.CustomerID = O.CustomerID

WHERE C.CustomerID = 3 -- Change CustomerID as needed

GROUP BY C.CustomerID, C.FirstName, C.LastName;


--6. Write an SQL query to find the customers who have placed the most orders. List their names 
--and the number of orders they have placed.

SELECT TOP 1 C.CustomerID, C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders

FROM Customers C

JOIN Orders O ON C.CustomerID = O.CustomerID

GROUP BY C.CustomerID, C.FirstName, C.LastName

ORDER BY TotalOrders DESC;


--7. Write an SQL query to find the most popular product category, which is the one with the highest 
--total quantity ordered across all orders.

SELECT TOP 1 P.ProductName, SUM(OD.Quantity) AS TotalOrdered

FROM OrderDetails OD

JOIN Products P ON OD.ProductID = P.ProductID

GROUP BY P.ProductName

ORDER BY TotalOrdered DESC;


--8. Write an SQL query to find the customer who has spent the most money (highest total revenue) 
--on electronic gadgets. List their name and total spending.

SELECT TOP 1 C.CustomerID, C.FirstName, C.LastName, SUM(O.TotalAmount) AS TotalSpent

FROM Customers C

JOIN Orders O ON C.CustomerID = O.CustomerID

GROUP BY C.CustomerID, C.FirstName, C.LastName

ORDER BY TotalSpent DESC;


--9. Write an SQL query to calculate the average order value (total revenue divided by the number of 
--orders) for all customers.

SELECT AVG(TotalAmount) AS AvgOrderValue FROM Orders;

--10. Write an SQL query to find the total number of orders placed by each customer and list their 
--names along with the order count.

SELECT C.CustomerID, C.FirstName, C.LastName, COUNT(O.OrderID) AS OrderCount

FROM Customers C

LEFT JOIN Orders O ON C.CustomerID = O.CustomerID

GROUP BY C.CustomerID, C.FirstName, C.LastName;
