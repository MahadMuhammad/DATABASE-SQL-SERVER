-- Muhammad Mahad 21L-6195
-- Event (EID, Ename, location, type, start_date, start_time, end_date, end_time)
-- Organization (OID, Oname, address)
-- Participants (PID, Pname, bdate, gender, OID)
-- Sponsors (EID, OID, amount)
-- Attended (PID, EID)
-- 2.	Insert 5 or more tuples in each of the above tables.

-- TABLE 1
INSERT INTO Event VALUES 
(1,'ABC','lahore','Seminar','2022-02-22','02:00:00','2022-02-22','06:00:00'),
(2,'DEF','lahore','Seminar','2022-01-25','02:00:00','2022-01-25','06:00:00'),
(3,'GHI','lahore','Seminar','2022-12-22','02:00:00','2022-12-22','06:00:00'),
(4,'JKL','lahore','Conference','2022-02-22','02:00:00','2022-02-22','06:00:00'),
(5,'MNO','lahore','Workshop','2022-12-22','02:00:00','2022-12-22','06:00:00'
);

SELECT * FROM Event;
--DELETE FROM Event WHERE EID = 2;


------------------------------------------------------------------------------------
-- TABLE 2
INSERT INTO Organization VALUES 
(1,'SOFTEC','FAST,lahore'),
(2,'FAST','Faisal Town,lahore'),
(3,'Techlogix','FAST,lahore'),
(4,'DEF','FAST,lahore'),
(5,'XYZ','FAST,lahore');
SELECT * FROM Organization;

------------------------------------------------------------------------------------
-- TABLE 3
INSERT INTO Participants VALUES 
(1,'Hashim','2002-08-10','M',1),
(2,'Hugo','2002-08-10','M',1),
(3,'Ali','2002-08-10','M',1),
(4,'Asad','2002-08-10','M',1),
(5,'Sania','2002-08-10','F',NULL),
(6,'Hania','2002-08-10','F',NULL);
SELECT * FROM Participants;

------------------------------------------------------------------------------------
-- TABLE 4
INSERT INTO Sponsors VALUES 
(1,1,5000),
(2,1,1000),
(3,3,3000),
(4,5,4000),
(5,3,7000),
(2,3,9000);
SELECT * FROM Sponsors;

------------------------------------------------------------------------------------
-- TABLE 5
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