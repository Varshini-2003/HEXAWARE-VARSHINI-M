-- Database Initialization
CREATE DATABASE CourseManagement;
USE CourseManagement;

-- Tables Creation
CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY IDENTITY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Expertise VARCHAR(100) NOT NULL
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY,
    CourseName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Duration INT NOT NULL,
    InstructorID INT NOT NULL,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY IDENTITY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY IDENTITY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    CONSTRAINT UQ_Student_Course UNIQUE (StudentID, CourseID) -- Prevent duplicate enrollments
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY,
    StudentID INT NOT NULL,
    AmountPaid DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

CREATE TABLE Assessments (
    AssessmentID INT PRIMARY KEY IDENTITY,
    CourseID INT NOT NULL,
    AssessmentType VARCHAR(50) NOT NULL,
    TotalMarks INT NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Sample Data
INSERT INTO Instructors (FullName, Email, Expertise) VALUES
('John Doe', 'john.doe@email.com', 'Technology'),
('Jane Smith', 'jane.smith@email.com', 'Business'),
('Robert Brown', 'robert.brown@email.com', 'Marketing'),
('Alice Johnson', 'alice.johnson@email.com', 'Finance'),
('Chris White', 'chris.white@email.com', 'Design'),
('Emma Davis', 'emma.davis@email.com', 'Management'),
('David Wilson', 'david.wilson@email.com', 'Programming');

INSERT INTO Courses (CourseName, Category, Duration, InstructorID) VALUES
('Python Basics', 'Technology', 40, 1),
('Business Strategy', 'Business', 35, 2),
('Digital Marketing', 'Marketing', 30, 3),
('Investment Planning', 'Finance', 45, 4),
('UI/UX Design', 'Design', 25, 5),
('Project Management', 'Management', 50, 6),
('Advanced Python', 'Programming', 60, 7);

INSERT INTO Students (FullName, Email, PhoneNumber) VALUES
('Michael Johnson', 'michael@email.com', '1234567890'),
('Sarah Wilson', 'sarah@email.com', '0987654321'),
('David Lee', 'david@email.com', '1122334455'),
('Emily Clark', 'emily@email.com', '5566778899'),
('Sophia Lewis', 'sophia@email.com', '6677889900'),
('James Anderson', 'james@email.com', '4455667788'),
('Emma Thompson', 'emma@email.com', '7788990011');

INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1, 1), (2, 1), (3, 2), (4, 3), (5, 4), (6, 5), (7, 6);

INSERT INTO Payments (StudentID, AmountPaid) VALUES
(1, 200.00), (2, 150.00), (3, 300.00), (4, 400.00), (5, 250.00), (6, 500.00), (7, 350.00);

INSERT INTO Assessments (CourseID, AssessmentType, TotalMarks) VALUES
(1, 'Quiz', 100), (2, 'Assignment', 100), (3, 'Project', 100), (4, 'Exam', 100), (5, 'Quiz', 100), (6, 'Assignment', 100), (7, 'Final Test', 100);


-- 1. Retrieve Available Courses
SELECT c.CourseName, c.Category, c.Duration, i.FullName AS InstructorName
FROM Courses c
JOIN Instructors i ON c.InstructorID = i.InstructorID;

-- 2. Retrieve Students Enrolled in a Specific Course
DECLARE @CourseID INT = 1; 
SELECT s.FullName, s.Email, e.EnrollmentDate
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
WHERE e.CourseID = @CourseID;

-- 3. Update Instructor Information (Stored Procedure)
CREATE PROCEDURE UpdateInstructorInfo
    @InstructorID INT,
    @FullName VARCHAR(100),
    @Email VARCHAR(100)
AS
BEGIN
    UPDATE Instructors SET FullName = @FullName, Email = @Email WHERE InstructorID = @InstructorID;
END;

-- 4. Calculate Total Payments per Student
SELECT s.FullName, COALESCE(SUM(p.AmountPaid), 0) AS TotalPaid
FROM Students s
LEFT JOIN Payments p ON s.StudentID = p.StudentID
GROUP BY s.FullName;

-- 5. Retrieve Students Without Enrollments
SELECT s.FullName FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;

-- 6. Retrieve Monthly Revenue
SELECT YEAR(PaymentDate) AS Year, MONTH(PaymentDate) AS Month, SUM(AmountPaid) AS TotalRevenue
FROM Payments
GROUP BY YEAR(PaymentDate), MONTH(PaymentDate)
ORDER BY Year, Month;

-- 7. Find Students Enrolled in More Than 3 Courses
SELECT s.FullName
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
GROUP BY s.FullName
HAVING COUNT(e.CourseID) > 3;

-- 8. Retrieve Instructor-wise Course Count
SELECT i.FullName, COUNT(c.CourseID) AS CourseCount
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
GROUP BY i.FullName;

-- 9. Find Students Without Payments
SELECT s.FullName FROM Students s
LEFT JOIN Payments p ON s.StudentID = p.StudentID
WHERE p.StudentID IS NULL;

-- 10. Retrieve Courses with No Enrollments
SELECT c.CourseName FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
WHERE e.CourseID IS NULL;

-- 11. Retrieve Students Without Payments:
SELECT s.StudentID, s.FullName
FROM Students s
LEFT JOIN Payments p ON s.StudentID = p.StudentID
WHERE p.PaymentID IS NULL;

-- 12. Retrieve Courses with No Enrollments:
SELECT c.CourseID, c.CourseName
FROM Courses c
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
WHERE e.EnrollmentID IS NULL;


-- 13. Find the Most Popular Course:
SELECT TOP 1 c.CourseID, c.CourseName, COUNT(e.EnrollmentID) AS TotalEnrollments
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
ORDER BY TotalEnrollments DESC;

-- 14. Retrieve Students and Their Total Marks in a Course:
SELECT s.FullName, c.CourseName, SUM(a.TotalMarks) AS TotalMarks
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
JOIN Assessments a ON c.CourseID = a.CourseID
GROUP BY s.FullName, c.CourseName;

-- 15. List Courses with Assessments but No Enrollments:
SELECT c.CourseID, c.CourseName
FROM Courses c
JOIN Assessments a ON c.CourseID = a.CourseID
LEFT JOIN Enrollments e ON c.CourseID = e.CourseID
WHERE e.EnrollmentID IS NULL;

-- 16. Retrieve Payment Status per Student:
SELECT s.FullName, COUNT(e.EnrollmentID) AS EnrolledCourses, 
       COALESCE(SUM(p.AmountPaid), 0) AS TotalPaid
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Payments p ON s.StudentID = p.StudentID
GROUP BY s.FullName;

--17. Find Course Pairs with the Same Instructor:
SELECT c1.CourseName AS Course1, c2.CourseName AS Course2, i.FullName AS Instructor
FROM Courses c1
JOIN Courses c2 ON c1.InstructorID = c2.InstructorID AND c1.CourseID < c2.CourseID
JOIN Instructors i ON c1.InstructorID = i.InstructorID;


-- 18. List All Possible Student-Course Combinations:
SELECT s.FullName, c.CourseName
FROM Students s
CROSS JOIN Courses c;


-- 19. Determine the Instructor with the Highest Number of Students:
SELECT TOP 1 i.FullName, COUNT(e.StudentID) AS TotalStudents
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName
ORDER BY TotalStudents DESC;

--20. Trigger to Prevent Double Enrollment:
CREATE TRIGGER PreventDuplicateEnrollment
ON Enrollments
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM Enrollments e
        JOIN inserted i ON e.StudentID = i.StudentID AND e.CourseID = i.CourseID
        GROUP BY e.StudentID, e.CourseID
        HAVING COUNT(*) > 1
    )
    BEGIN
        ROLLBACK;
        PRINT 'Error: Student cannot enroll in the same course more than once.';
    END
END;