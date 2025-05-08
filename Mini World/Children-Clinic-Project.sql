-- Patients Table
CREATE TABLE Patients (
  PatientID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  DateOfBirth DATE,
  Gender CHAR(1),
  GuardianName VARCHAR(100),
  ContactInfo VARCHAR(50),
  Address VARCHAR(100)
);

INSERT INTO Patients VALUES
(1, 'Emma', 'Lopez', '2015-03-14', 'F', 'Maria Lopez', '555-1234', '12 Oak St'),
(2, 'Aiden', 'Kim', '2014-07-23', 'M', 'James Kim', '555-2345', '34 Pine Ave'),
(3, 'Sofia', 'Patel', '2012-11-09', 'F', 'Nita Patel', '555-3456', '78 Cedar Rd'),
(4, 'Ethan', 'White', '2013-01-05', 'M', 'Laura White', '555-4567', '56 Maple Blvd'),
(5, 'Mia', 'Cruz', '2016-06-17', 'F', 'Luis Cruz', '555-5678', '89 Birch Ln');

-- Therapists Table
CREATE TABLE Therapists (
  TherapistID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Specialty VARCHAR(50),
  Email VARCHAR(100),
  PhoneNumber VARCHAR(20)
);

INSERT INTO Therapists VALUES
(1, 'Sarah', 'Brown', 'Anxiety', 'sbrown@clinic.com', '555-1111'),
(2, 'Daniel', 'Lee', 'ADHD', 'dlee@clinic.com', '555-2222'),
(3, 'Rachel', 'Gomez', 'Autism', 'rgomez@clinic.com', '555-3333'),
(4, 'Michael', 'Green', 'Depression', 'mgreen@clinic.com', '555-4444'),
(5, 'Emily', 'Nguyen', 'Behavioral Issues', 'enguyen@clinic.com', '555-5555');

-- Appointments Table
CREATE TABLE Appointments (
  AppointmentID INT PRIMARY KEY,
  PatientID INT,
  TherapistID INT,
  Date DATE,
  Time VARCHAR(10),
  Notes TEXT,
  FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
  FOREIGN KEY (TherapistID) REFERENCES Therapists(TherapistID)
);

INSERT INTO Appointments VALUES
(1, 1, 1, '2025-04-01', '10:00AM', 'Initial consultation'),
(2, 2, 2, '2025-04-02', '11:00AM', 'Follow-up for behavior review'),
(3, 3, 3, '2025-04-03', '9:00AM', 'Weekly check-in'),
(4, 4, 1, '2025-04-04', '2:00PM', 'Anxiety test results'),
(5, 5, 2, '2025-04-05', '1:00PM', 'First ADHD screening');

-- Treatments Table
CREATE TABLE Treatments (
  TreatmentID INT PRIMARY KEY,
  TreatmentName VARCHAR(50),
  Description TEXT,
  Frequency VARCHAR(20),
  Duration VARCHAR(20)
);

INSERT INTO Treatments VALUES
(1, 'CBT', 'Cognitive Behavioral Therapy', 'Weekly', '10 weeks'),
(2, 'Play Therapy', 'Therapy using play interaction', 'Biweekly', '8 weeks'),
(3, 'Social Skills', 'Focus on peer interaction', 'Weekly', '6 weeks'),
(4, 'Art Therapy', 'Expressive therapy via art', 'Weekly', '6 weeks'),
(5, 'Group Therapy', 'Peer support and discussion', 'Weekly', '12 weeks');

-- Patient_Treatments Table
CREATE TABLE Patient_Treatments (
  ID INT auto_increment PRIMARY KEY,
  PatientID INT,
  TreatmentID INT,
  StartDate DATE,
  EndDate DATE,
  OutcomeNotes TEXT,
  FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
  FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID)
);

INSERT INTO Patient_Treatments VALUES
(1, 1, 1, '2025-04-01', '2025-06-10', 'Showing improvement'),
(2, 2, 2, '2025-04-02', '2025-05-28', 'Increased engagement'),
(3, 3, 3, '2025-04-03', '2025-05-15', 'Better social interaction'),
(4, 4, 1, '2025-04-04', '2025-06-13', 'Still needs follow-up'),
(5, 5, 2, '2025-04-05', '2025-05-30', 'Progressing well');

-- Table Showing Appointments
SELECT 
  p.FirstName AS PatientFirstName,
  p.LastName AS PatientLastName,
  a.Date,
  a.Time,
  t.FirstName AS TherapistFirstName,
  t.LastName AS TherapistLastName
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Therapists t ON a.TherapistID = t.TherapistID;

-- Table showing patients In & out dates (Staff Review)
SELECT 
  p.PatientID,
  p.FirstName,
  p.LastName,
  t.TreatmentName,
  pt.StartDate,
  pt.EndDate
FROM Patient_Treatments pt
JOIN Patients p ON pt.PatientID = p.PatientID
JOIN Treatments t ON pt.TreatmentID = t.TreatmentID
ORDER BY p.PatientID, pt.StartDate;


-- Results on the Patients
SELECT 
  CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
  t.Specialty AS Diagnosis,
  CONCAT(th.FirstName, ' ', th.LastName) AS Therapist,
  tr.Duration,
  pt.OutcomeNotes
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Therapists th ON a.TherapistID = th.TherapistID
JOIN Patient_Treatments pt ON p.PatientID = pt.PatientID
JOIN Treatments tr ON pt.TreatmentID = tr.TreatmentID
JOIN Therapists t ON a.TherapistID = t.TherapistID;