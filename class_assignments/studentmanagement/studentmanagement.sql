-- Create the database
CREATE DATABASE studentmanagement;


-- Use the database
USE studentmanagement;

-- Create the Students table
CREATE TABLE Students (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100),
    Age INT,
    Major NVARCHAR(100)
);
