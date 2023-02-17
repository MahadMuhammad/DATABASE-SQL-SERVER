-- Event (EID, Ename, location, type, start_date, start_time, end_date, end_time)
-- Organization (OID, Oname, address)
-- Participants (PID, Pname, bdate, gender, OID)
-- Sponsors (EID, OID, amount)
-- Attended (PID, EID)
-- 2.	Insert 5 or more tuples in each of the above tables.

-- TABLE 1
INSERT INTO Event VALUES (1, 'Future Fest','Expo Centre, Lahore','conferences', '2023-01-01', '8:00 AM', '2023-01-03', '5:00 PM');
INSERT INTO Event VALUES (2, 'SOFTEC', 'FAST-NUCES, Lahore','conferences', '2023-05-01', '8:00 AM', '2023-05-03', '5:00 PM');
INSERT INTO Event VALUES (3, 'Coding Guru', 'LUMS', 'workshop', '2023-03-01', '8:00 AM', '2023-03-03', '5:00 PM');
INSERT INTO Event VALUES (4, 'NASCON', 'FAST-NUCES, Islamabad', 'conferences', '2023-04-01', '8:00 AM', '2023-04-03', '5:00 PM');
INSERT INTO Event VALUES (5, 'Takra', 'UCP, Lahore', 'seminar', '2023-02-01', '8:00 AM', '2023-02-03', '5:00 PM');

SELECT * FROM Event;
--DELETE FROM Event WHERE EID = 2;

-- TABLE 2
INSERT INTO Organization VALUES (1, 'Educative', 'Gulberg III, Lahore, Punjab');
INSERT INTO Organization VALUES (2, 'NETSOL', 'Main Ghazi Rd, Lahore');
INSERT INTO Organization VALUES (3, 'Folio3', 'Gulberg 2, Lahore, Punjab');
INSERT INTO Organization VALUES (4, 'Ejad-Labs', 'Johar Town, Lahore, Punjab');
INSERT INTO Organization VALUES (5,'Mindstorm Studios','DHA Phase 2, Lahore, Punjab');
SELECT * FROM Organization;

-- TABLE 3
INSERT INTO Participants VALUES (1,'Muhammad Mahad','2000-01-01','M',1);
INSERT INTO Participants VALUES (2,'Muhammad Ali Butt','2001-02-02','M',2);
INSERT INTO Participants VALUES (3,'Zaki Haider','2002-03-03','M',3);
INSERT INTO Participants VALUES (4,'Syeda Ayesha','2003-04-04','F',4);
INSERT INTO Participants VALUES (5,'Zainab Rehman','2004-05-05','F',5);
SELECT * FROM Participants;

-- TABLE 4
INSERT INTO Sponsors VALUES (1,5,50000);
INSERT INTO Sponsors VALUES (2,4,75000);
INSERT INTO Sponsors VALUES (3,3,25000);
INSERT INTO Sponsors VALUES (4,2,110000);
INSERT INTO Sponsors VALUES (5,1,250000);
SELECT * FROM Sponsors;

-- TABLE 5
INSERT INTO Attended VALUES (5,1);
INSERT INTO Attended VALUES (4,2);
INSERT INTO Attended VALUES (3,3);
INSERT INTO Attended VALUES (2,4);
INSERT INTO Attended VALUES (1,5);
SELECT * FROM Attended;