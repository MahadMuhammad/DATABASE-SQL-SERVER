-- Muhammad Mahad 21L-6195

-- Q1. Write down NESTED SQL QUERIES for the following:

-- 1. For each event Type, print the Event Name and the total number of participants who attended the 
-- Event each year but only for the Events with more than 10 participants. 
SELECT Event.Ename, Event.type, Event.end_date, COUNT(Attended.PID) AS 'Total Participants' 
FROM Event JOIN Attended ON Event.EID = Attended.EID
WHERE Event.EID IN (
    SELECT Event.EID
    FROM Event JOIN Attended ON Event.EID = Attended.EID
    GROUP BY Event.EID
    HAVING COUNT(Attended.PID) > 10
)
GROUP BY Event.type, Event.Ename,Attended.PID,Event.end_date;

-- 2. For each participant, list the names of the events he has attended. If he has not attended any event, indicate this with a null value.
-- SELECT Participants.Pname, Event.Ename
-- FROM Participants LEFT JOIN Attended ON Participants.PID = Attended.PID
-- LEFT JOIN Event ON Attended.EID = Event.EID;
-- -- with nested query
-- SELECT Participants.Pname, Event.Ename
-- FROM Participants LEFT JOIN (
--     SELECT Attended.PID, Attended.EID
--     FROM Attended
-- ) AS Attended ON Participants.PID = Attended.PID
-- LEFT JOIN Event ON Attended.EID = Event.EID;

-- SELECT Attended.EID, Event.Ename
-- FROM Attended , Event
-- WHERE Event.EID NOT IN (
--     SELECT Attended.EID
--     FROM Attended
--     WHERE Attended.PID = 1
-- );

-- Q3. Print the names of the participants who have attended precisely the same set of events attended by 'Hakaan Ali.'
SELECT Participants.Pname
FROM Participants JOIN Attended ON Participants.PID = Attended.PID
WHERE Attended.EID IN (
    SELECT Attended.EID
    FROM Attended
    WHERE Attended.PID = (
        SELECT Participants.PID
        FROM Participants
        WHERE Participants.Pname = 'Hakaan Ali')
)
GROUP BY Participants.PID , Participants.Pname
HAVING COUNT(Attended.EID) = (
    SELECT COUNT(Attended.EID)
    FROM Attended
    WHERE Attended.PID = (
        SELECT Participants.PID
        FROM Participants
        WHERE Participants.Pname = 'Hakaan Ali')
);

SELECT Pname 
FROM Participants 
WHERE PID IN (
  SELECT PID 
  FROM Attended 
  WHERE EID IN (
    SELECT EID 
    FROM Attended 
    WHERE PID = (SELECT PID FROM Participants WHERE Pname = 'Hakaan Ali')
  ) 
  GROUP BY PID 
  HAVING COUNT(DISTINCT EID) = (
    SELECT COUNT(DISTINCT EID) 
    FROM Attended 
    WHERE PID = (SELECT PID FROM Participants WHERE Pname = 'Hakaan Ali')
  )
) 
AND Pname <> 'Hakaan Ali';

-- Q4. Print the name of the participants who have attended all the seminars held in 2022. 
SELECT Participants.Pname
FROM Participants 
WHERE PID IN (
  SELECT PID
  FROM Attended
  WHERE EID IN (
    SELECT EID
    FROM Event
    WHERE type = 'seminar'
    AND YEAR(start_date) = 2022
  )
  GROUP BY PID
  HAVING COUNT(DISTINCT EID) = (
    SELECT COUNT(DISTINCT EID)
    FROM Event
    WHERE type = 'seminar'
    AND YEAR(start_date) = 2022
  )
);

-- 5. Find pair of organizations that have sponsored exactly the same types of events.

-- Q6. List the names of the organizations that have never sponsored any conference.
--with nested query
SELECT Organization.Oname
FROM Organization LEFT JOIN (
    SELECT Organization.OID, Event.type
    FROM Organization JOIN Sponsors ON Organization.OID = Sponsors.OID
    JOIN Event ON Sponsors.EID = Event.EID
    WHERE Event.type = 'conference'
) AS Sponsors ON Organization.OID = Sponsors.OID
WHERE Sponsors.OID IS NULL;

SELECT Organization.Oname AS org_no_conference
FROM Organization
WHERE Organization.OID NOT IN (
	SELECT Sponsors.OID FROM Sponsors
	WHERE Sponsors.EID IN (
		SELECT Event.EID FROM Event 
		WHERE type = 'conference'
	)
);

-- Q7. Print the names and ages of participants with more than the average age.
SELECT Participants.Pname , DATEDIFF(yyyy,bdate, GETDATE()) AS age
FROM Participants
WHERE DATEDIFF(yyyy,bdate, GETDATE()) > (
	SELECT AVG(DATEDIFF(yyyy,bdate, GETDATE()))
	FROM Participants	
);

-- 8. Print the name and ID of the Event with the minimum number of participants among all the 
-- events held in 2022. 
SELECT TOP 1  EID,Ename
FROM Event
WHERE YEAR(start_date) = 2022
ORDER BY (
  SELECT COUNT(PID)
  FROM Attended
  WHERE Attended.EID = Event.EID
) ASC;

-- Q9. Find the names of the organizations that have sponsored one or more events. 
-- SELECT Organization.Oname
-- FROM Organization JOIN Sponsors ON Organization.OID = Sponsors.OID
SELECT Organization.Oname
FROM Organization
WHERE Organization.OID IN(
	SELECT Sponsors.OID
	FROM Sponsors
);

-- Q10. Display the ids of the participants who attended the Event organized by "Techlogix" on January 25, 2003. 
SELECT Attended.PID
FROM Attended
WHERE Attended.EID IN (
	SELECT Sponsors.EID FROM Sponsors WHERE Sponsors.OID IN(
		SELECT Organization.OID FROM Organization WHERE Oname = 'Techlogix'
	)
	AND Attended.EID IN (
		SELECT Event.EID FROM Event WHERE (start_date BETWEEN '2003-01-25' AND '2003-01-25') OR 
		(end_date BETWEEN '2003-01-25' AND '2003-01-25')
	)
);
-- OR
SELECT PID
FROM Attended
WHERE Attended.EID = (
  SELECT Event.EID
  FROM Event
  JOIN Sponsors ON Event.EID = Sponsors.EID
  JOIN Organization ON Sponsors.OID = Organization.OID
  WHERE Oname = 'Techlogix' AND start_date = '2003-01-25'
);

-- 11. List the names of participants who attended exactly five events.
SELECT Participants.Pname
FROM Participants
WHERE Participants.PID IN (
	SELECT Attended.PID FROM Attended 
	GROUP BY Attended.PID
	HAVING COUNT(EID) = 5
);
-- OR
SELECT Pname
FROM Participants
JOIN (
  SELECT PID, COUNT(DISTINCT EID) AS num_events
  FROM Attended
  GROUP BY PID
) AS participant_events
ON Participants.PID = participant_events.PID
WHERE num_events = 5;  

-- 12. List the number of events attended by each participant in 2022.
SELECT Attended.PID , COUNT(Attended.PID) AS event_attended
FROM Attended
WHERE Attended.EID IN (
	SELECT Event.EID FROM Event WHERE YEAR(Event.start_date) = 2022 OR YEAR(Event.end_date) = 2022
)
GROUP BY Attended.PID;
-- OR
SELECT  Participants.PID, Participants.Pname, COUNT(Attended.EID) AS num_events
FROM Participants JOIN Attended ON Participants.PID = Attended.PID
WHERE Attended.EID IN (
    SELECT Event.EID
    FROM Event
    WHERE YEAR(start_date) = 2022
)
GROUP BY Participants.PID , Participants.Pname;


-- 13. Print the organization names that sponsored the maximum and minimum sponsorship 
-- amount for events held in 2022.
SELECT Organization.Oname
FROM Organization
WHERE Organization.OID IN (
    SELECT Sponsors.OID
    FROM Sponsors
    WHERE Sponsors.EID IN (
        SELECT Event.EID FROM Event WHERE YEAR(Event.start_date) = 2022 OR YEAR(Event.end_date) = 2022
    )
    AND Sponsors.amount = (
        SELECT MAX(Sponsors.amount)
        FROM Sponsors
        WHERE Sponsors.EID IN (
            SELECT Event.EID FROM Event WHERE YEAR(Event.start_date) = 2022 OR YEAR(Event.end_date) = 2022
        )
    )
	OR Sponsors.amount = (
        SELECT MIN(Sponsors.amount)
        FROM Sponsors
        WHERE Sponsors.EID IN (
            SELECT Event.EID FROM Event WHERE YEAR(Event.start_date) = 2022 OR YEAR(Event.end_date) = 2022
        )
    )
);
-- OR
SELECT Oname
FROM Organization
JOIN (
  SELECT OID, SUM(amount) AS total_amount
  FROM Sponsors
  JOIN Event ON Sponsors.EID = Event.EID
  WHERE YEAR(Event.start_date) = 2022
  GROUP BY OID
) AS sponsor_amounts
ON Organization.OID = sponsor_amounts.OID
WHERE total_amount = (
  SELECT MAX(total_amount)
  FROM (
    SELECT SUM(amount) AS total_amount
    FROM Sponsors
    JOIN Event ON Sponsors.EID = Event.EID
    WHERE YEAR(Event.start_date) = 2022
    GROUP BY OID
  ) AS max_sponsor
)
OR total_amount = (
  SELECT MIN(total_amount)
  FROM (
    SELECT SUM(amount) AS total_amount
    FROM Sponsors
    JOIN Event ON Sponsors.EID = Event.EID
    WHERE YEAR(Event.start_date) = 2022
    GROUP BY OID
  ) AS min_sponsor
)

-- 14. List the name of the Organization that has organized a seminar and a workshop in December 
-- 2022.
SELECT Organization.Oname
FROM Organization
WHERE Organization.OID IN (
	SELECT Sponsors.OID FROM Sponsors WHERE Sponsors.EID IN (
		SELECT Event.EID FROM Event WHERE 2022 IN (YEAR(Event.start_date),YEAR(Event.end_date))
		AND type IN ('seminar') AND type IN ('workshop')
	)
);
SELECT DISTINCT Organization.Oname
FROM Organization
JOIN Sponsors ON Organization.OID = Sponsors.OID
JOIN Event ON Sponsors.EID = Event.EID
WHERE YEAR(Event.start_date) = 2022
AND MONTH(Event.start_date) = 12
AND Event.type = 'seminar'
AND EXISTS (
  SELECT *
  FROM Sponsors
  JOIN Event ON Sponsors.EID = Event.EID
  WHERE Sponsors.OID = Organization.OID
  AND YEAR(Event.start_date) = 2022
  AND MONTH(Event.start_date) = 12
  AND Event.type = 'workshop'
);

-- 15. List the names of the participants who have attended a seminar but never attended a conference.
SELECT Participants.Pname
FROM Participants
WHERE Participants.PID IN (
	SELECT Attended.PID FROM Attended WHERE Attended.EID IN (
		SELECT Event.EID FROM Event WHERE type = 'seminar' 
			EXCEPT
			SELECT Event.EID FROM Event WHERE type = 'conference'
			)
		);
-- OR
SELECT Participants.Pname
FROM Participants
WHERE Participants.PID IN (
    SELECT Attended.PID FROM Attended WHERE Attended.EID IN (
        SELECT Event.EID FROM Event WHERE type = 'seminar'
    )
    AND Attended.PID NOT IN (
        SELECT Attended.PID FROM Attended WHERE Attended.EID IN (
            SELECT Event.EID FROM Event WHERE type = 'conference'
        )
    )
);
-- OR
SELECT DISTINCT Participants.Pname
FROM Participants
JOIN Attended ON Participants.PID = Attended.PID
JOIN Event ON Attended.EID = Event.EID
WHERE Event.type = 'seminar'
AND Participants.PID NOT IN (
  SELECT Participants.PID
  FROM Participants
  JOIN Attended ON Participants.PID = Attended.PID
  JOIN Event ON Attended.EID = Event.EID
  WHERE Event.type = 'conference'
);




