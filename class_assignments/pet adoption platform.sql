create database PET;
use PET;


/*1.	SQL Schema Creation:
o	Create a database schema for PetCare.
o	Define tables with attributes similar to the ones described below:
	Pets (PetID, Name, Age, Breed, Type, AvailableForAdoption)
	Shelters (ShelterID, Name, Location)
	Donations (DonationID, DonorName, DonationType, DonationAmount, DonationItem, DonationDate)
	AdoptionEvents (EventID, EventName, EventDate, Location)
	Participants (ParticipantID, ParticipantName, ParticipantType, EventID as Foreign Key)
2.	Table Constraints:
o	Define primary and foreign keys.
o	Set constraints for null values and unique attributes where applicable.
o	Ensure the script checks if tables exist before creating them.
*/
create table Pets(PetID int not null primary key identity(1,1),
Name varchar(50),
Age int,
Breed varchar(50),
Type varchar(50),
AvailableForAdoption varchar(50) not null
);
create table Shelters(ShelterID int not null primary key identity(1,1),
Name varchar(50),
Location varchar(100),
);
create table Donations(DonationID int not null primary key identity(1,1),
DonorName varchar(50),
DonarType varchar(50),
DonationAmount int,
DonationItem varchar(50),
DonationDate date,
);
create table AdoptionEvents(
EventID int not null primary key identity(1,1),
EventName varchar(50),
EventDate date,
Location Varchar(100),
);
create table Participants(
ParticipantID int not null primary key,
ParticipantName varchar(50),
ParticipantType varchar(50),
EventID int not null foreign key references AdoptionEvents(EventID) on delete cascade,
);

insert into Pets values
('Bella', 3, 'Labrador', 'Dog', 'YES'),
('Max', 2, 'Persian', 'Cat', 'YES'),
('Charlie', 1, 'Beagle', 'Dog',' NO'),
('Luna', 4, 'Siamese', 'Cat', 'YES'),
('Rocky', 5, 'Bulldog', 'Dog',' NO'),
('Milo', 2, 'Maine Coon', 'Cat', 'YES');


insert into Shelters values
('Happy Paws Shelter', 'New York'),
('Safe Haven', 'Los Angeles'),
('Furry Friends', 'Chicago'),
('Paw Rescue Center', 'Houston'),
('Animal Care Home', 'Miami'),
('Rescue Me Shelter', 'San Francisco');

insert into Donations values
('John Doe', 'Monetary', 100, 'shampoo', '2025-03-01'),
('Jane Smith', 'Item', 456, 'Dog Food', '2025-03-05'),
('Michael Brown', 'Monetary', 250, 'Toys', '2025-03-10'),
('Emily Johnson', 'Item', 800, 'Cat Toys', '2025-03-12'),
('Daniel Wilson', 'Monetary', 50, 'Cat Food', '2025-03-15'),
('Sophia Davis', 'Item', 900, 'Pet Beds', '2025-03-20');



insert into AdoptionEvents values
('Spring Adoption Fair', '2025-04-01', 'Central Park, NY'),
('Paws for Love', '2025-04-10', 'LA Animal Center'),
('Adopt a Friend', '2025-04-15', 'Chicago Expo Center'),
('Furry Companions Day', '2025-04-20', 'Houston Pet Plaza'),
('Forever Home Event', '2025-04-25', 'Miami Beach Park'),
('Happy Tails Meetup', '2025-04-30', 'San Francisco Square');


insert into Participants values
(1,'Alice Carter', 'Adopter', 1),
(2,'Bob Miller', 'Volunteer', 2),
(3,'Charlie White', 'Sponsor', 3),
(4,'Diana Green', 'Adopter', 4),
(5,'Ethan Black', 'Volunteer', 5),
(6,'Fiona Blue', 'Sponsor', 6);

/*3.	Retrieve Available Pets:
o	Write an SQL query to list pets available for adoption.
o	Output should include the pet's Name, Age, Breed, and Type.*/


select Name,Age,Breed,Type from Pets where AvailableForAdoption='YES';


/*4.	Retrieve Event Participants:
o	Write an SQL query to list participant names and types for a specific event based on EventID.*/


declare @EventID int =1
select ParticipantName , ParticipantType 
from Participants
where EventID=@EventID;

/*5.	Update Shelter Information (Stored Procedure):
o	Create a stored procedure to update a shelter’s name and location.
o	The procedure should take ShelterID, NewName, and NewLocation as parameters.*/

create procedure shelter @ShelterID int, @NewName varchar(50), @NewLocation varchar(100)
AS 
begin
update Shelters set Name= @NewName, Location=@NewLocation
where ShelterID=@ShelterID;
END;


/*6.	Calculate Shelter Donations:
o	Write an SQL query to calculate the total donation amount per shelter.
o	The output should include Shelter Name and Total Donation Amount.*/

--6) SQL query to calculate the total donation amount per shelter
SELECT s.Name AS ShelterName, SUM(d.DonationAmount) AS TotalDonations
FROM Shelters s
JOIN Donations d ON s.ShelterID = d.DonationID
GROUP BY s.Name;

--7) SQL query to list all pets that do not have an owner.
SELECT * FROM Pets WHERE AvailableForAdoption = 'Yes' ORDER BY Age;

-- 8) SQL query to retrieve total donations per month and year
SELECT YEAR(DonationDate) AS Year, MONTH(DonationDate) AS Month, SUM(DonationAmount) AS TotalDonations
FROM Donations
GROUP BY YEAR(DonationDate), MONTH(DonationDate);

-- 9) Retrieve distinct pet breeds where pets are aged between 1 and 3 years or older than 5 years
SELECT Name, Breed, Age FROM Pets WHERE Age BETWEEN 1 AND 3 OR Age > 5 
ORDER BY Age;

-- 10) List all pets and their respective shelters where pets are available for adoption
SELECT P.Name, P.AvailableForAdoption, S.Name, S.Location FROM Pets P
JOIN Shelters S ON S.ShelterID = P.PetID WHERE P.AvailableForAdoption = 'Yes';

--11)Count Event Participants by City:
DECLARE @City NVARCHAR(100) = 'New York';
SELECT COUNT(*) AS TotalParticipants
FROM AdoptionEvents e
JOIN Participants p ON e.EventID = p.EventID
WHERE e.Location = @City;

--12) Unique Breeds of Young Pets:
SELECT DISTINCT Breed FROM Pets WHERE Age BETWEEN 1 AND 5;

--13. Find Pets Not Yet Adopted:
SELECT * FROM Pets WHERE AvailableForAdoption = 1;

--14. Retrieve Adopted Pets and Adopters:
SELECT p.Name AS PetName, pa.ParticipantName AS Adopter
FROM Pets p
JOIN Participants pa ON p.PetID = pa.ParticipantID;

--15.  Count Available Pets in Shelters
SELECT s.Name AS ShelterName, COUNT(p.PetID) AS AvailablePets
FROM Shelters s
LEFT JOIN Pets p ON s.ShelterID = p.PetID
WHERE p.AvailableForAdoption = 'Yes'
GROUP BY s.Name;



--16. Find Matching Pet Pairs in Shelters:
SELECT p1.Name AS Pet1, p2.Name AS Pet2, p1.Breed, s.Name AS Shelter
FROM Pets p1
JOIN Pets p2 ON p1.PetID = p2.PetID AND p1.Breed = p2.Breed AND p1.PetID < p2.PetID
JOIN Shelters s ON p1.PetID = s.ShelterID;


--17. Find All Shelter-Event Combinations
SELECT s.Name AS Shelter, e.EventName AS Event
FROM Shelters s
CROSS JOIN AdoptionEvents e;

--18.Identify the Most Successful Shelter
SELECT s.Name AS Shelter_Name, COUNT(*) AS Total_Adoptions
FROM Shelters s
JOIN Pets p ON s.ShelterID = p.PetID
WHERE p.AvailableForAdoption = 'No'
GROUP BY s.Name
ORDER BY Total_Adoptions DESC;



--19. Trigger for Adoption Status Update
CREATE OR ALTER TRIGGER UpdateAdoptionStatus 
ON Participants
AFTER INSERT 
AS 
BEGIN
    SET NOCOUNT ON;
    
    -- Update only existing pets and ensure only adoptable pets are updated
    UPDATE Pets
    SET AvailableForAdoption = 0
    WHERE PetID IN (SELECT PetID FROM inserted)
    AND AvailableForAdoption = 1; 
END;


-- 20. Data Integrity Check: Prevent Duplicate Adoptions
-- Check if the constraint exists before adding it
IF NOT EXISTS (
    SELECT 1 FROM sys.objects 
    WHERE type = 'UQ' AND name = 'UniqueAdoption'
)
BEGIN
    ALTER TABLE Participants 
    ADD CONSTRAINT UniqueAdoption UNIQUE (ParticipantName, EventID);
END;
