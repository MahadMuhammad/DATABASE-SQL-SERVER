-- Event (EID, Ename, location, type, start_date, start_time, end_date, end_time)
-- Organization (OID, Oname, address)
-- Participants (PID, Pname, bdate, gender, OID)
-- Sponsors (EID, OID, amount)
-- Attended (PID, EID)

-- Q1. 1.	Write appropriate SQL DDL statements for declaring the above relational schema.
-- Specify the appropriate keys and referential integrity constraints and actions.  

-- TABLE 1
CREATE DATABASE EventDB;

CREATE TABLE Event (
    EID INT PRIMARY KEY,
    Ename VARCHAR(50) NOT NULL,
    location VARCHAR(50),
    type VARCHAR(15) ,
    start_date DATE ,
    start_time TIME ,
    end_date DATE,
    end_time TIME,
);
SELECT * FROM Event;
-- DROP TABLE Event;

-- TABLE 2
CREATE TABLE Organization (
    OID INT PRIMARY KEY,
    Oname VARCHAR(50) NOT NULL,
    address VARCHAR(25)
);
SELECT * FROM Organization;

-- TABLE 3
CREATE TABLE Participants(
    PID INT PRIMARY KEY,
    Pname VARCHAR(50) NOT NULL,
    bdate DATE,
    gender CHAR(1),
    OID INT FOREIGN KEY REFERENCES Organization(OID) ON DELETE SET NULL ON UPDATE CASCADE
);
SELECT * FROM Participants;

-- TABLE 4
CREATE TABLE Sponsors(
    EID INT ,
    OID INT ,
    amount DECIMAL ,
    PRIMARY KEY(EID, OID),
    FOREIGN KEY (EID) REFERENCES Event(EID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (OID) REFERENCES Organization(OID) ON DELETE CASCADE ON UPDATE CASCADE
);
SELECT * FROM Sponsors;

-- TABLE 5
CREATE TABLE Attended(
    PID INT ,
    EID INT ,
    PRIMARY KEY(PID, EID),  -- Here primary key is a composite key
    FOREIGN KEY (PID) REFERENCES Participants(PID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (EID) REFERENCES Event(EID) ON DELETE CASCADE ON UPDATE CASCADE
);
SELECT * FROM Attended;

--DROP TABLE Event;
--DROP TABLE Organization;
--DROP TABLE Participants;
--DROP TABLE Sponsors;
--DROP TABLE Attended;

