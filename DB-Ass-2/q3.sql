-- Write down SQL statements for the following queries:
--          1.	List the ids and names of all the Events.
SELECT EID,Ename FROM Event;

-- 2. List the event id, name, and start_time of all the events that took place on January 3, 2023.
SELECT EID,Ename,start_time 
FROM Event
WHERE end_date='2023-01-03';