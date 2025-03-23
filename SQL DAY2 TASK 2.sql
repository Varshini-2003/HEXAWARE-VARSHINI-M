--1)Create a user-defined database named EmployeeRecords with specific file paths for the .mdf and .ldf files.
create database EmployeeRecords
use EmployeeRecords

--2) Rename the EmployeeRecords database to HR_Database using T-SQL.
alter database EmployeeRecords modify name= HR_Database

--3)Drop the HR_Database safely, ensuring there are no active connections before deletion.
drop database HR_Database

--4)Identify at least five commonly used data types in SQL Server and explain their use cases.
--int
--date
--varchar
--bit 
--float

--5)Create a Customers table with appropriate columns (CustomerID, FullName, Email, Phone, DateJoined).
create table Customers(
CustomerID int,
FullName varchar(50),
Email varchar(25), 
Phone varchar(15), 
DateJoined date
);

--6)Modify the Customers table to add a new column Address.
alter table Customers add Address varchar (20)

--7)Rename the Customers table to ClientDetails.
exec sp_rename 'Customers','ClientDetails'

--8)Drop the ClientDetails table safely.
drop table ClientDetails

--9)Insert five sample records into the Customers table.
insert into Customers values
(1,'Ram','Ram.10@gmail.com','9845321678','2021-05-08','12,abc'),
(2,'Ravi','ravi.45@yahoo.com','8451236910','2020-07-03','45.tfyu'),
(3,'Rahul','rahul.22@gmail.com','7896541230','2016-08-12','78,fhi'),
(4,'Anu','anu.1101@gmail.com','98745632156','2018-05-29','78fbdf'),
(5,'Raj','raj.464@gmail.com','8756423190','2014-12-01','36,vfbdfb');

--10)Update the email of a customer whose CustomerID = 3.
update Customers set email='new@gmail.com' where CustomerID=3

--11)Delete a customer record where the CustomerID = 5.
delete Customers where CustomerID=5

--12)Demonstrate inserting multiple records in a single query for better efficiency.
insert into Customers values
(6,'Ragu','Ragu.08@gmail.com','9845451678','2021-07-08','12,hghdf'),
(7,'Yash','yash1845@yahoo.com','8412345910','2017-07-03','45.fxrdhv'),
(8,'Banu','Banu.2024@gmail.com','789571230','2016-07-12','78,hbjgjfu');

--13)Retrieve and display only the FullName and Email of all customers.
select FullName, Email from Customers

--14)Retrieve all customers who joined after 2020-01-01.
select * from Customers where DateJoined>'2020-01-01'

--15)Fetch all customers whose names start with 'J' using a LIKE query.
select * from Customers where FullName like 'j%'

--16)Retrieve customers where Phone is NULL (i.e., customers who haven't provided a phone number).
select * from Customers where Phone is null

--17)Filter customers using IN—Retrieve records where CustomerID is either 1, 3, or 7.
select * from Customers where CustomerID in ('1','3','7')

--18)Use DISTINCT to list unique domain names from customer emails (e.g., gmail.com, yahoo.com).
select distinct substring(Email, charindex('@', Email) + 1, len(Email)) as DomainName from Customers;

--19)Use AND and OR together—Retrieve customers who either live in 'New York' OR have joined before 2019-06-01.
select * from Customers where Address = 'New York' or DateJoined < '2019-06-01';

--20)Retrieve customers where DateJoined is BETWEEN 2018-01-01 AND 2023-12-31.
select * from Customers where DateJoined between '2018-01-01' and '2023-12-31'

--21)Use column and table aliases to rename output fields while selecting.
SELECT * FROM Customers 
WHERE ID > 12 
AND Location = 'Chicago';

--22)Demonstrate a query that filters using multiple conditions, such as WHERE Age > 25 AND City = 'Chicago'.
select * from Customers where ID >12 and Location='Chicago'

--23)Execute and analyze filtering queries to optimize performance using EXPLAIN plans (if applicable).