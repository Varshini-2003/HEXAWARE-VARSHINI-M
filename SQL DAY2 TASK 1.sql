/* Task 1:
Write an SQL script to create a database named StudentRecords.
Rename the StudentRecords database to UniversityRecords.
Delete the UniversityRecords database safely.
List and describe common SQL Server data types.
Create a Students table with appropriate columns and data types.
Add a new column Email to the Students table.
Rename the Students table to UniversityStudents.
Delete the UniversityStudents table.
Insert five sample student records into the Students table.
Update the email of a specific student.
Delete a record of a student who has graduated.
Select and display only the names and emails of students.
Retrieve students based on a specific condition (e.g., age > 18).
Fetch all records from the table.
Retrieve students who belong to a specific department. 
Write queries to demonstrate filtering using these operators.
Execute filtering queries and explain the results.*/

-- Create a database named StudentRecords
create database StudentRecords;
use StudentRecords;
use UniversityRecords;

--Rename the database as UniversityRecords
alter database StudentRecords modify name=UniversityRecords;

--delete database
drop database UniversityRecords

-- Create a Students table
create table Students(
    StudentID int primary key,
    Name varchar(50),
    Age int,
    Depart varchar(10),
);

-- Add a new column Email to the Students table
alter table Students add Email varchar(25);

--Rename Students table to UniversityStudents
exec sp_rename 'Students', 'UniversityStudents'

-- Insert five sample student records
insert into UniversityStudents values 
(1,'Ram',20,'CSE','Ram.10@gmail.com'),
(2,'Ravi',19,'ECE','ravi.45@yahoo.com'),
(3,'Rahul',22,'IT','rahul.22@gmail.com'),
(4,'Anu',21,'CSE','anu.1101@gamil.com'),
(5,'Raj',23,'ECE','raj.464@gmail.com');

-- Update the email of a specific student
update UniversityStudents set Email = 'new.email@example.com' where Name = 'Anu';

-- Delete a record of a student who has graduated
alter table UniversityStudents add EnrollmentDate date;

update UniversityStudents set EnrollmentDate = '2021-06-15' where StudentID = 1;
update UniversityStudents set EnrollmentDate = '2023-09-10' where StudentID = 2;
update UniversityStudents set EnrollmentDate = '2021-11-08' where StudentID = 3;
update UniversityStudents set EnrollmentDate = '2020-05-15' where StudentID = 4;
update UniversityStudents set EnrollmentDate = '2022-09-10' where StudentID = 5;

delete from UniversityStudents where EnrollmentDate < '01-01-2022';

-- Select and display only the names and emails of students
select Name, email from UniversityStudents;

-- Retrieve students based on a specific condition (age > 18)
select * from UniversityStudents where Age > 18;

-- Fetch all records from the table
select * from UniversityStudents;

-- Retrieve students who belong to a specific department
select * from UniversityStudents where Depart = 'CSE';

-- Demonstrate filtering using different operators
-- Using comparison operator (greater than)
select * from UniversityStudents where Age > 20;

-- Using LIKE operator
select * from UniversityStudents where Name LIKE 'R%';

-- Using IN operator
select * from UniversityStudents where Depart IN ('ECE', 'CSE');

-- Using BETWEEN operator
select * from UniversityStudents where Age BETWEEN 18 AND 22;