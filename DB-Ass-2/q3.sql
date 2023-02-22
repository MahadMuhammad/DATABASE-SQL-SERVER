-- Muhammad Mahad 21L-6195
-- Write down SQL statements for the following queries:

--------------------------------------------------------------------------------
-- 1. List the ids and names of all the Events.
SELECT EID,Ename FROM Event;


--------------------------------------------------------------------------------
-- 2. List the event id, name, and start_time of all the events that took place on January 3, 2023.
SELECT EID, Ename, start_time 
FROM Event
WHERE start_date = '2023-01-03';	--start_date>='2023-01-03' AND end_date<='2023-01-03';

--------------------------------------------------------------------------------
--3.	List the name of female participants younger than 25 who do not belong to any organization.
SELECT Pname
FROM Participants
WHERE gender = 'F' AND OID IS NULL AND bdate > DATEADD(year, -25, GETDATE()) ;

--------------------------------------------------------------------------------
-- 4.	Find the names of the organizations that have sponsored one or more events. 
SELECT DISTINCT Organization.Oname -- One Organization can sponsor one or more event so we need DISTINCT
FROM Organization JOIN Sponsors ON Organization.OID=Sponsors.OID;
-- OR We can use this
SELECT Oname
FROM Organization
WHERE Organization.OID IN (SELECT Sponsors.OID FROM Sponsors);


--------------------------------------------------------------------------------
-- 5.	Display the ids of the participants who attended the event organized by "Techlogix" on January 25, 2003.
SELECT Sponsors.EID, Event.Ename
FROM 
	Attended 
	JOIN
		(Event JOIN
		(Organization JOIN Sponsors ON Organization.OID = Sponsors.OID)
		ON Event.EID = Sponsors.EID)
	ON Event.EID = Attended.EID
WHERE Organization.Oname = 'Techlogix' AND Event.start_date ='2003-01-25';-- ='2022-12-22'; 

--------------------------------------------------------------------------------
-- 6.	List the names of organizations that have never sponsored a seminar; note seminar is a type of event. 
SELECT Organization.Oname
FROM Organization
                        EXCEPT 
SELECT Organization.Oname 
FROM Event JOIN (Organization JOIN Sponsors ON Organization.OID = Sponsors.OID) ON Event.EID=Sponsors.EID
WHERE Event.type='seminar';

-- OR we can use this

SELECT Organization.Oname
FROM Organization
WHERE Organization.OID NOT IN (
    SELECT OID FROM Sponsors JOIN Event ON Sponsors.EID=Event.EID WHERE Event.type = 'Seminar'
);

--------------------------------------------------------------------------------
-- 7.	List the ids of participants who attended exactly five events.
SELECT	Attended.PID
FROM Attended
GROUP BY Attended.PID
HAVING COUNT(EID) = 5;


--------------------------------------------------------------------------------
-- 8.	List the number of events attended by each participant.
SELECT Participants.PID, Participants.Pname, COUNT(EID) AS Count
FROM Attended RIGHT JOIN Participants ON Attended.PID = Participants.PID
GROUP BY Participants.PID, Participants.Pname
ORDER BY PID ASC;

--------------------------------------------------------------------------------
-- 9.	Find the maximum, minimum, and average sponsorship amount.
SELECT 
	MAX(Sponsors.amount) AS MAX_SPONSORSHIP,
	MIN(Sponsors.amount) AS MIN_SPONSORSHIP,
	AVG(Sponsors.amount) AS AVG_SPONSORSHIP
FROM Sponsors;	

--------------------------------------------------------------------------------
-- 10.	List the name of the organization that has organized a seminar and a workshop in December 2022.
SELECT Organization.Oname 
FROM
	Event JOIN 
	(Organization JOIN Sponsors ON Organization.OID = Sponsors.OID)
	ON Event.EID = Sponsors.EID
WHERE Event.type='Seminar'AND Event.start_date LIKE '2022-12-__'
					INTERSECT   --  Here, we use this instead of AND because AND will check both conditions and we need only one condition at each tuple
SELECT Organization.Oname 
FROM
	Event JOIN 
	(Organization JOIN Sponsors ON Organization.OID = Sponsors.OID)
	ON Event.EID = Sponsors.EID
WHERE Event.type='Workshop'AND Event.start_date LIKE '2022-12-__';


-- we cannot use this because the sql-server check semiar and workshop in a same tuple
-- SELECT Organization.Oname
-- FROM Organization JOIN Sponsors ON Organization.OID = Sponsors.OID
-- WHERE Sponsors.EID IN (
--     SELECT Event.EID
--     FROM Event
--     WHERE Event.type = 'Seminar' AND Event.start_date LIKE '2022-12-__'
--     )
--         AND
--     Sponsors.EID IN (
--     SELECT Event.EID
--     FROM Event
--     WHERE Event.type = 'Workshop' AND Event.start_date LIKE '2022-12-__'
--     );


--------------------------------------------------------------------------------
-- 11.	List the names of the participants who have attended a seminar but never attended a conference.
SELECT DISTINCT Participants.Pname
FROM Event JOIN
	(Participants JOIN Attended ON Participants.PID = Attended.PID) -- Here, we get Participants who attended meetings
	ON (Event.type = 'Seminar' AND Event.EID = Attended.EID) -- Here, we get Participants who attended seminars
	EXCEPT
SELECT DISTINCT Participants.Pname
FROM Event JOIN
	(Participants JOIN Attended ON Participants.PID = Attended.PID) -- Here, we get Participants who attended meetings
	ON (Event.type = 'Conference' AND Event.EID = Attended.EID); 

-- OR we can use this
SELECT Participants.Pname
FROM Participants
WHERE Participants.PID IN (
	SELECT Attended.PID FROM Attended JOIN Event ON Attended.EID=Event.EID WHERE Event.type='Seminar'
	)
						AND 
	Participants.PID NOT IN (
	SELECT Attended.PID FROM Attended JOIN Event ON Attended.EID=Event.EID WHERE Event.type='Conference'
	);


--------------------------------------------------------------------------------
-- 12.	List the ids of participants who have attended an event on 5-Jan-2023 or who have never attended any event.
(SELECT Participants.PID
FROM Participants 
EXCEPT
SELECT Participants.PID
FROM Participants JOIN Attended ON Participants.PID = Attended.PID) -- Here, we get Participants who never attended any event
							UNION
(SELECT Attended.PID                                                -- Here, we get Participants who attended an event on 5-Jan-2023
FROM Attended JOIN Event ON  Attended.EID = Event.EID
WHERE start_date='2023-01-05');

-- OR we can use this
SELECT Participants.PID
FROM Participants LEFT JOIN Attended ON Participants.PID = Attended.PID 
WHERE Attended.PID IS NULL 
	OR Attended.PID IN (
	SELECT Attended.PID 
	FROM Attended JOIN Event ON Attended.EID=Event.EID 
	WHERE Event.start_date LIKE '2023-01-05'
	);



