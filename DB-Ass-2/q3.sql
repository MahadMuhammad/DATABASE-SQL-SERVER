-- Write down SQL statements for the following queries:
--          1.	List the ids and names of all the Events.
SELECT EID,Ename FROM Event;

-- 2. List the event id, name, and start_time of all the events that took place on January 3, 2023.
SELECT EID, Ename, start_time 
FROM Event
WHERE start_date = '2023-01-03';	--start_date>='2023-01-03' AND end_date<='2023-01-03';

--3.	List the name of female participants younger than 25 who do not belong to any organization.
SELECT Pname
FROM Participants
WHERE gender = 'F' AND OID IS NULL AND bdate > DATEADD(year, -25, GETDATE()) ;

-- 4.	Find the names of the organizations that have sponsored one or more events. 
SELECT DISTINCT Organization.Oname -- One Organization can sponsor one or more event so we need DISTINCT
FROM Organization JOIN Sponsors ON Organization.OID=Sponsors.OID;
-- OR We can use this
SELECT Oname
FROM Organization
WHERE Organization.OID IN (SELECT OID FROM Sponsors);


-- 5.	Display the ids of the participants who attended the event organized by "Techlogix" on January 25, 2003.
-- There is an error in this question
-- SELECT PID
-- FROM Attended JOIN Event ON Attended.EID=Event.EID
-- WHERE Event.Ename = 'Techlogix' AND Event.start_date = '2003-01-25';


-- 6.	List the names of organizations that have never sponsored a seminar; note seminar is a type of event. 
SELECT Organization.Oname
FROM Organization
EXCEPT 
SELECT Organization.Oname 
FROM Event JOIN (Organization JOIN Sponsors ON Organization.OID = Sponsors.OID) ON Event.EID=Sponsors.EID
WHERE Event.type='seminar';
-- OR
SELECT Oname
FROM Organization
WHERE Organization.OID NOT IN (SELECT OID FROM Sponsors JOIN Event ON 
Sponsors.EID=Event.EID WHERE Event.type = 'Seminar');
