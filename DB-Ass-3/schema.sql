-- Muhammad Mahad 21L-6195
-- Event (EID, Ename, location, type, start_date, start_time, end_date, end_time)
-- Organization (OID, Oname, address)
-- Participants (PID, Pname, bdate, gender, OID)
-- Sponsors (EID, OID, amount)
-- Attended (PID, EID)

CREATE DATABASE EventDB;

-- TABLE 1
CREATE TABLE Event (
  EID INT PRIMARY KEY,
  Ename VARCHAR(50),
  location VARCHAR(50),
  type VARCHAR(50),
  start_date DATE,
  start_time TIME,
  end_date DATE,
  end_time TIME
);
-- DROP TABLE Event;

------------------------------------------------------------
-- TABLE 2
CREATE TABLE Organization (
  OID INT PRIMARY KEY,
  Oname VARCHAR(25),
  address VARCHAR(50)
);
SELECT * FROM Organization;

------------------------------------------------------------
-- TABLE 3
CREATE TABLE Participants (
  PID INT PRIMARY KEY,
  Pname VARCHAR(25),
  bdate DATE,
  gender CHAR(1),
  --OID INT NULL REFERENCES Organization(OID)
  OID INT FOREIGN KEY REFERENCES Organization(OID) ON DELETE SET NULL ON UPDATE CASCADE
);
SELECT * FROM Participants;

------------------------------------------------------------
-- TABLE 4
CREATE TABLE Sponsors (
  EID INT,-- REFERENCES Event(EID),
  OID INT,-- REFERENCES Organization(OID),
  amount DECIMAL,
  PRIMARY KEY (EID, OID),
  FOREIGN KEY (EID) REFERENCES Event(EID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (OID) REFERENCES Organization(OID) ON DELETE CASCADE ON UPDATE CASCADE
);
SELECT * FROM Sponsors;

------------------------------------------------------------
-- TABLE 5
CREATE TABLE Attended (
  PID INT,-- REFERENCES Participants(PID),
  EID INT,-- REFERENCES Event(EID),
  PRIMARY KEY (PID, EID), -- Here primary key is a composite key
  FOREIGN KEY (PID) REFERENCES Participants(PID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (EID) REFERENCES Event(EID) ON DELETE CASCADE ON UPDATE CASCADE
);


 

