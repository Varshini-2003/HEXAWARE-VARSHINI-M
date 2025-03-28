
create database PayXpert;
USE PayXpert;

CREATE TABLE Employee(
EmployeeID INT not null primary key IDENTITY(1,1),
FirstName VARCHAR(65),
LastName VARCHAR(65),
DateOfBirth DATE,
Gender VARCHAR(40),
Email VARCHAR(30) UNIQUE,
PhoneNumber BIGINT,
Emp_Address TEXT,
POSITION VARCHAR(55),
JoiningDate DATE,
TerminationDate DATE
);

SELECT * FROM Employee;

CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES Employee(EmployeeID),
    PayPeriodStartDate DATE,
    PayPeriodEndDate DATE,
    BasicSalary BIGINT,
    OvertimePay BIGINT,
    Deductions BIGINT,
    NetSalary BIGINT
);

SELECT * FROM Payroll;

CREATE TABLE Tax (
    TaxID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES Employee(EmployeeID),
    TaxYear INT,
    TaxableIncome BIGINT,
    TaxAmount BIGINT
);

SELECT * FROM Tax;

CREATE TABLE FinancialRecord (
    RecordID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES Employee(EmployeeID),
    RecordDate DATE,
    Description TEXT,
    Amount BIGINT,
    RecordType VARCHAR(50)
);

SELECT * FROM FinancialRecord;