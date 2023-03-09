CREATE TABLE Event (
  EID int PRIMARY KEY,
  Ename varchar(255),
  location varchar(255),
  type varchar(255),
  start_date date,
  start_time time,
  end_date date,
  end_time time
);

CREATE TABLE Organization (
  OID int PRIMARY KEY,
  Oname varchar(255),
  address varchar(255)
);

CREATE TABLE Participants (
  PID int PRIMARY KEY,
  Pname varchar(255),
  bdate date,
  gender varchar(255),
  OID int NULL REFERENCES Organization(OID)
);

CREATE TABLE Sponsors (
  EID int REFERENCES Event(EID),
  OID int REFERENCES Organization(OID),
  amount int,
  PRIMARY KEY (EID, OID)
);

CREATE TABLE Attended (
  PID int REFERENCES Participants(PID),
  EID int REFERENCES Event(EID),
  PRIMARY KEY (PID, EID)
);

-- INSERT SAMPLE DATA

INSERT INTO Event (EID, Ename, location, type, start_date, start_time, end_date, end_time)
VALUES
  (1, 'Seminar 1', 'New York', 'seminar', '2022-01-01', '09:00:00', '2022-01-01', '18:00:00'),
  (2, 'Seminar 2', 'Los Angeles', 'seminar', '2022-02-01', '09:00:00', '2022-02-01', '18:00:00'),
  (3, 'Workshop 1', 'San Francisco', 'workshop', '2022-03-01', '09:00:00', '2022-03-01', '18:00:00'),
  (4, 'Workshop 2', 'Chicago', 'workshop', '2022-04-01', '09:00:00', '2022-04-01', '18:00:00'),
  (5, 'Conference 1', 'Seattle', 'conference', '2022-05-01', '09:00:00', '2022-05-03', '18:00:00'),
  (6, 'Conference 2', 'Washington DC', 'conference', '2022-06-01', '09:00:00', '2022-06-03', '18:00:00');

INSERT INTO Organization (OID, Oname, address)
VALUES
  (1, 'Techlogix', 'New York'),
  (2, 'Google', 'Mountain View'),
  (3, 'Microsoft', 'Redmond'),
  (4, 'Amazon', 'Seattle');

INSERT INTO Participants (PID, Pname, bdate, gender, OID)
VALUES
  (1, 'John Doe', '1990-01-01', 'M', 2),
  (2, 'Jane Doe', '1995-01-01', 'F', NULL),
  (3, 'Bob Smith', '1985-01-01', 'M', 3),
  (4, 'Alice Smith', '1989-01-01', 'F', NULL),
  (5, 'Hakaan Ali', '1992-01-01', 'M', 1),
  (6, 'Sara Lee', '1996-01-01', 'F', 4);

INSERT INTO Sponsors (EID, OID, amount)
VALUES
  (1, 1, 1000),
  (2, 2, 2000),
 

