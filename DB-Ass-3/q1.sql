-- Muhammad Mahad 21L-6195

-- Q1. Write down NESTED SQL QUERIES for the following:

-- 1. For each event Type, print the Event Name and the total number of participants who attended the 
-- Event each year but only for the Events with more than 10 participants. with nested query
SELECT E.type,  E.Ename, YEAR(E.start_date) AS year, COUNT(A.PID) AS num_participants
FROM Event AS E 
JOIN Attended AS A 
ON E.EID = A.EID
WHERE E.EID IN ( 
  SELECT EID 
  FROM Attended
  )
GROUP BY E.type,E.Ename, YEAR(E.start_date)
HAVING COUNT(A.PID) > 10;


-- 2. For each participant, list the names of the events he has attended. If he has not attended any event, indicate this with a null value.
SELECT Participants.Pname, Event.Ename
FROM Participants LEFT JOIN Attended ON Participants.PID = Attended.PID
LEFT JOIN Event ON Attended.EID = Event.EID;
-- with nested query
SELECT Pname, Ename
FROM Participants AS P LEFT JOIN Event AS E 
ON P.PID IN (SELECT PID FROM Attended WHERE EID = E.EID);

-- Q3. Print the names of the participants who have attended precisely the same set of events attended by 'Hakaan Ali.'
SELECT DISTINCT P1.Pname
FROM Participants AS P1
WHERE P1.Pname <> 'Hakaan Ali' AND 
  NOT EXISTS (
  SELECT EID
  FROM Attended AS A
  WHERE A.PID = P1.PID
  EXCEPT
  SELECT EID
  FROM Attended  AS A
  WHERE A.PID = (SELECT PID FROM Participants WHERE Pname = 'Hakaan Ali')
) 
AND NOT EXISTS (
  SELECT EID
  FROM Attended AS A
  WHERE A.PID = (SELECT PID FROM Participants WHERE Pname = 'Hakaan Ali')
  EXCEPT
  SELECT EID
  FROM Attended AS A
  WHERE A.PID = P1.PID
);





-- Q4. Print the name of the participants who have attended all the seminars held in 2022. 
SELECT Pname
FROM Participants
WHERE PID IN (
  SELECT PID
  FROM Attended
  WHERE EID IN (
    SELECT EID
    FROM Event
    WHERE type = 'seminar' AND start_date BETWEEN '2022-01-01' AND '2022-12-31'
  )
  GROUP BY PID
  HAVING COUNT(DISTINCT EID) = (
    SELECT COUNT(DISTINCT EID)
    FROM Event
    WHERE type = 'seminar' AND start_date BETWEEN '2022-01-01' AND '2022-12-31'
  )
);
-- OR
SELECT Participants.Pname
FROM Participants JOIN Attended ON Participants.PID = Attended.PID
JOIN Event ON Attended.EID = Event.EID
WHERE type = 'seminar' AND YEAR(start_date) = 2022 AND YEAR(end_date) = 2022
GROUP BY Participants.Pname
HAVING COUNT(DISTINCT Attended.EID) = (
  SELECT COUNT(DISTINCT EID)
  FROM Event
  WHERE type = 'seminar' AND YEAR(start_date) = 2022 AND YEAR(end_date) = 2022
);



-- 5. Find pair of organizations that have sponsored exactly the same types of events.
SELECT O1.Oname, O2.Oname, E.type
FROM Organization O1, Organization O2, Event E
WHERE O1.OID <> O2.OID AND 
E.EID IN (
  SELECT S1.EID 
  FROM Sponsors AS S1 
  WHERE S1.OID = O1.OID)
  AND E.type IN ('workshop', 'seminar', 'conference')
  -- Implementing Division in SQL, two sets are equal if they are subsets of each other
AND NOT EXISTS (      -- O1 has sponsored an event of a type that O2 has not sponsored
  SELECT EID          -- EID of events that O1 has sponsored but O2 has not
  FROM Sponsors AS S1
  WHERE S1.OID = O1.OID AND S1.EID IN (SELECT EID FROM Event WHERE type <> E.type)
                    EXCEPT
  SELECT EID          -- EID of events that O2 has sponsored but O1 has not
  FROM Sponsors AS S2
  WHERE S2.OID = O2.OID AND S2.EID IN (SELECT EID FROM Event WHERE type <> E.type)
)
AND NOT EXISTS (      -- O2 has sponsored an event of a type that O1 has not sponsored
  SELECT EID          -- EID of events that O2 has sponsored but O1 has not
  FROM Sponsors S2
  WHERE S2.OID = O2.OID AND S2.EID IN (SELECT EID FROM Event WHERE type <> E.type)
                  EXCEPT    
  SELECT EID          
  FROM Sponsors S1      -- EID of events that O1 has sponsored but O2 has not
  WHERE S1.OID = O1.OID AND S1.EID IN (SELECT EID FROM Event WHERE type <> E.type)
);


-- Q6. List the names of the organizations that have never sponsored any conference.
--with nested query
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
SELECT Participants.Pname AS p_name , DATEDIFF(yyyy,bdate, GETDATE()) AS age
FROM Participants
WHERE DATEDIFF(yyyy,bdate, GETDATE()) > (
	SELECT AVG(DATEDIFF(yyyy,bdate, GETDATE()))
	FROM Participants	
)
ORDER BY DATEDIFF(yyyy,bdate, GETDATE()) ASC;

-- 8. Print the name and ID of the Event with the minimum number of participants among all the 
-- events held in 2022. 
SELECT EID AS eid, Ename
FROM Event
WHERE YEAR(start_date) = 2022 AND YEAR(end_date) = 2022 
    AND
      (SELECT COUNT(PID) 
      FROM Attended 
      WHERE Attended.EID = Event.EID) 
                < ALL 
         (SELECT COUNT(PID) 
         FROM Attended 
         WHERE YEAR(start_date) = 2022 AND YEAR(end_date) = 2022  
         GROUP BY EID);



-- Q9. Find the names of the organizations that have sponsored one or more events. 
SELECT Organization.Oname
FROM Organization
WHERE Organization.OID IN(
	SELECT Sponsors.OID
	FROM Sponsors
);

-- Q10. Display the ids of the participants who attended the Event organized by "Techlogix" on January 25, 2003. 
SELECT Attended.PID AS participant_id
FROM Attended
WHERE Attended.EID = (
  SELECT Event.EID
  FROM (Event JOIN Sponsors ON Event.EID = Sponsors.EID)
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

-- 12. List the number of events attended by each participant in 2022.
SELECT Attended.PID , COUNT(Attended.PID) AS event_attended
FROM Attended
WHERE Attended.EID IN (
	SELECT Event.EID 
  FROM Event 
  WHERE YEAR(Event.start_date) = 2022 AND YEAR(Event.end_date) = 2022
)
GROUP BY Attended.PID;
-- OR to get the name we need to join
SELECT  Participants.PID, Participants.Pname, COUNT(Attended.EID) AS num_events
FROM Participants JOIN Attended ON Participants.PID = Attended.PID
WHERE Attended.EID IN (
    SELECT Event.EID
    FROM Event
    WHERE YEAR(Event.start_date) = 2022 AND YEAR(Event.end_date) = 2022
)
GROUP BY Participants.PID , Participants.Pname;


-- 13. Print the organization names that sponsored the maximum and minimum sponsorship 
-- amount for events held in 2022.
SELECT Organization.Oname
FROM Organization
WHERE Organization.OID IN (
    SELECT Sponsors.OID
    FROM Sponsors
    WHERE 
    Sponsors.EID IN (
        SELECT Event.EID 
        FROM Event 
        WHERE YEAR(Event.start_date) = 2022 AND YEAR(Event.end_date) = 2022
      )
    AND (
    Sponsors.amount IN (
          SELECT MAX(Sponsors.amount)
          FROM Sponsors
          WHERE Sponsors.EID IN (
            SELECT Event.EID 
            FROM Event 
            WHERE YEAR(Event.start_date) = 2022 AND YEAR(Event.end_date) = 2022
        )
      )
	  OR Sponsors.amount IN (
          SELECT MIN(Sponsors.amount)
          FROM Sponsors
          WHERE Sponsors.EID IN (
            SELECT Event.EID 
            FROM Event 
            WHERE YEAR(Event.start_date) = 2022 AND YEAR(Event.end_date) = 2022
        )
      )
    )
);


-- 14. List the name of the Organization that has organized a seminar and a workshop in December 
-- 2022.
SELECT Organization.Oname
FROM Organization
WHERE Organization.OID IN (
	SELECT Sponsors.OID FROM Sponsors WHERE Sponsors.EID IN (
		SELECT Event.EID FROM Event 
    WHERE 2022 IN (YEAR(Event.start_date),YEAR(Event.end_date)) AND
    12 IN (MONTH(Event.start_date),MONTH(Event.end_date))
		AND Event.type IN ('seminar') 

    UNION
    SELECT Event.EID FROM Event 
    WHERE 2022 IN (YEAR(Event.start_date),YEAR(Event.end_date)) AND
    12 IN (MONTH(Event.start_date),MONTH(Event.end_date))
    AND Event.type IN ('workshop')
	)
);


-- 15. List the names of the participants who have attended a seminar but never attended a conference.
SELECT Participants.Pname
FROM Participants
WHERE Participants.PID IN (
	SELECT Attended.PID FROM Attended WHERE Attended.EID IN (
		SELECT Event.EID FROM Event WHERE Event.type IN ('seminar') 
			EXCEPT
			SELECT Event.EID FROM Event WHERE Event.type IN  ('conference')
			)
		);




