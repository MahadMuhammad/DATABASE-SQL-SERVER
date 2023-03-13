-- Muhammad Mahad 21L-6195

-- A.  Create a view that includes the participant's name, the name and type of Event he attended, and the number 
--      of days the Event lasted. 
CREATE VIEW event_participant_info_v(p_name,e_name,e_type,e_duration) AS
	SELECT Participants.Pname AS p_name, Event.Ename AS e_name, Event.type, DATEDIFF(dd,Event.start_date,Event.end_date) AS e_duration
	FROM (Participants JOIN Attended ON Participants.PID = Attended.PID)
		JOIN Event ON Attended.EID = Event.EID;

SELECT * FROM event_participant_info_v;

-- Delete the view
DROP VIEW Event_Participant;

-- B. Create a view that includes the Organization's name, the number of events it sponsored, and the total amount 
-- of sponsorship, but only for the Organizations that have sponsored more than 3 Events.
CREATE VIEW org_sponsor_info_v(o_name, e_count, total_amount) AS
	SELECT Organization.Oname , COUNT(Sponsors.EID), SUM(Sponsors.amount)
	FROM Organization JOIN Sponsors ON Organization.OID = Sponsors.OID
	GROUP BY Organization.Oname
	HAVING COUNT(Sponsors.EID) > 3;

SELECT * FROM org_sponsor_info_v;

-- Delete the view
DROP VIEW org_sponsor_info_v;

-- C. Create a trigger that prints a message when an Organization sponsor more than 100000 for an 
-- event. 
CREATE TRIGGER sponsor_amount_trigger ON Sponsors
AFTER INSERT -- Didn't use AFTER UPDATE because it will be triggered when the amount is updated to more than 100000
AS
	IF EXISTS (SELECT * FROM inserted WHERE amount > 100000 )
	BEGIN
		PRINT ' Organization sponsor more than 100000 for an event. ';
	END;

-- Insert a new sponsor
INSERT INTO Sponsors VALUES (1, 4, 1000000);

-- Delete the trigger
DROP TRIGGER sponsor_amount_trigger;

-- delete the sponsor
DELETE FROM Sponsors WHERE EID = 1 AND OID = 4 AND amount = 1000000;

-- D. Create a trigger that prints a message when an event is canceled, and its data is deleted from the 
-- Event table 
CREATE TRIGGER event_cancel_trigger ON Event
AFTER DELETE
AS
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        PRINT ' Event is canceled, and its data is deleted from the Event table ';
    END;

-- Deleting Event
DELETE FROM Event WHERE EID = 1;

INSERT INTO Event (EID, Ename, location, type, start_date, start_time, end_date, end_time)
VALUES
  (1, 'Seminar 1', 'New York', 'seminar', '2022-01-01', '09:00:00', '2022-01-01', '18:00:00');

-- Deleting trigger
DROP TRIGGER event_cancel_trigger;


