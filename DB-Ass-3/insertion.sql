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
  (5,'FAST','Faisal Town,lahore');

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
  (1  ,1, 1000),
  (2  ,2, 2000),
  (3  ,3, 3000),
  (4  ,5, 4000),
  (5  ,3, 7000),
  (2  ,3, 9000);

  INSERT INTO Attended VALUES 
(1,1),
(1,4),
(1,2),
(1,3),
(1,5),
(3,4),
(4,1),
(5,1);
SELECT * FROM Attended;
  

--DROP TABLE Event;
--DROP TABLE Organization;
--DROP TABLE Participants;
--DROP TABLE Sponsors;
--DROP TABLE Attended;

SELECT * FROM Event ;
SELECT * FROM  Organization;
SELECT * FROM  Participants;
SELECT * FROM  Sponsors;
SELECT * FROM Attended ;
