-- Patients Table
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    HealthID VARCHAR(50) UNIQUE NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    Phone VARCHAR(20),
    Location VARCHAR(100),
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Doctors Table
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);

-- Pharmacies Table
CREATE TABLE Pharmacies (
    PharmacyID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Phone VARCHAR(20)
);

-- Medicines Table
CREATE TABLE Medicines (
    MedicineID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT
);

-- PharmacyStock Table (medicines available at pharmacies)
CREATE TABLE PharmacyStock (
    StockID INT AUTO_INCREMENT PRIMARY KEY,
    PharmacyID INT,
    MedicineID INT,
    Quantity INT,
    FOREIGN KEY (PharmacyID) REFERENCES Pharmacies(PharmacyID),
    FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID)
);

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    TriageLevel ENUM('Urgent', 'Moderate', 'Mild'),
    Status VARCHAR(50) DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Prescriptions Table
CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT,
    MedicineID INT,
    Dosage VARCHAR(100),
    Duration VARCHAR(100),
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID)
);
