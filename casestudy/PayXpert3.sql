CREATE DATABASE PayXpert3;
USE PayXpert3;

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    Gender NVARCHAR(10),
    Email NVARCHAR(100) UNIQUE,
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(255),
    Position NVARCHAR(50),
    JoiningDate DATE,
    TerminationDate DATE NULL
);

CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES Employee(EmployeeID) ON DELETE CASCADE,
    PayPeriodStartDate DATE,
    PayPeriodEndDate DATE,
    BasicSalary DECIMAL(10,2),
    OvertimePay DECIMAL(10,2),
    Deductions DECIMAL(10,2),
    NetSalary DECIMAL(10,2)
);

CREATE TABLE Tax (
    TaxID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES Employee(EmployeeID) ON DELETE CASCADE,
    TaxYear INT,
    TaxableIncome DECIMAL(10,2),
    TaxAmount DECIMAL(10,2)
);

CREATE TABLE FinancialRecord (
    RecordID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT FOREIGN KEY REFERENCES Employee(EmployeeID) ON DELETE CASCADE,
    RecordDate DATE,
    Description NVARCHAR(255),
    Amount DECIMAL(10,2),
    RecordType NVARCHAR(50)
);




-- Employee Table
INSERT INTO Employee VALUES
('Vetri', 'V', '1990-05-12', 'Male', 'vetri@gmail.com', '9876543210', 'Bangalore, India', 'Software Engineer', '2020-03-15', NULL),
('Vishal', 'Arjun', '1985-08-23', 'Male', 'vishal@yahoo.com', '9865321470', 'Chennai, India', 'Project Manager', '2018-07-10', NULL),
('Ashok', 'T', '1992-01-30', 'Male', 'ashok@outlook.com', '9987456321', 'Mumbai, India', 'Data Analyst', '2021-06-20', NULL),
('Varshini', 'L', '1995-04-17', 'Female', 'varshini@neo.com', '9873214560', 'Kolkata, India', 'HR Manager', '2019-02-25', NULL),
('Sreeja', 'K', '1988-12-09', 'Female', 'sreeja@kct.com', '9845612378', 'Hyderabad, India', 'Finance Executive', '2017-09-05', NULL),
('Santhosh', 'J', '1993-07-14', 'Male', 'santhosh@vsb.com', '9768543120', 'Delhi, India', 'Software Tester', '2022-11-30', NULL),
('Ravi', 'Kumar', '1991-11-01', 'Male', 'ravi.kumar@gmail.com', '9871234567', 'Pune, India', 'DevOps Engineer', '2021-01-10', NULL),
('Divya', 'R', '1987-03-19', 'Female', 'divya.r@yahoo.com', '9856231478', 'Coimbatore, India', 'Business Analyst', '2016-05-21', NULL),
('Manoj', 'S', '1994-06-27', 'Male', 'manoj@abc.com', '9823456789', 'Jaipur, India', 'UI/UX Designer', '2020-12-01', NULL),
('Priya', 'M', '1990-09-10', 'Female', 'priya.m@gmail.com', '9867895432', 'Nagpur, India', 'Content Strategist', '2018-04-18', NULL);


-- Payroll Table
INSERT INTO Payroll VALUES
(1, '2024-03-01', '2024-03-31', 700000, 50000, 70000, 680000),
(2, '2024-03-01', '2024-03-31', 1200000, 80000, 120000, 1160000),
(3, '2024-03-01', '2024-03-31', 850000, 30000, 85000, 795000),
(4, '2024-03-01', '2024-03-31', 900000, 40000, 90000, 850000),
(5, '2024-03-01', '2024-03-31', 950000, 60000, 95000, 915000),
(6, '2024-03-01', '2024-03-31', 600000, 20000, 60000, 560000),
(7, '2024-03-01', '2024-03-31', 750000, 55000, 75000, 730000),
(8, '2024-03-01', '2024-03-31', 800000, 45000, 80000, 765000),
(9, '2024-03-01', '2024-03-31', 780000, 30000, 78000, 732000),
(10, '2024-03-01', '2024-03-31', 820000, 35000, 82000, 773000);


-- Tax Table
INSERT INTO Tax VALUES
(1, 2024, 840000, 100800),
(2, 2024, 1440000, 172800),
(3, 2024, 1020000, 122400),
(4, 2024, 1080000, 129600),
(5, 2024, 1140000, 136800),
(6, 2024, 720000, 86400),
(7, 2024, 855000, 102600),
(8, 2024, 885000, 106200),
(9, 2024, 870000, 104400),
(10, 2024, 900000, 108000);


-- FinancialRecord Table
INSERT INTO FinancialRecord VALUES
(1, '2024-03-15', 'Health Insurance Deduction', 2000000, 'Credit'),
(2, '2024-03-20', 'Annual Bonus', 5000000, 'Credit'),
(3, '2024-03-25', 'Travel Allowance', 3000000, 'Credit'),
(4, '2024-03-10', 'Salary Advance', -10000, 'Deduction'),
(5, '2024-03-05', 'Loan Repayment', -15000, 'Deduction'),
(6, '2024-03-28', 'Performance Incentive', 700000, 'Credit'),
(7, '2024-03-17', 'Stock Bonus', 1000000, 'Credit'),
(8, '2024-03-22', 'Medical Allowance', 120000, 'Credit'),
(9, '2024-03-12', 'Late Penalty', -5000, 'Deduction'),
(10, '2024-03-27', 'Festive Bonus', 150000, 'Credit');
