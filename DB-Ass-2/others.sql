create table Organizations (OID int primary key not null,
Oname varchar(40),
Oaddress varchar(60) );
create table DBevent (EID int primary key not null,
Ename varchar(30),
DBlocation varchar(30),
DBtype varchar(30),
DBstart_date date,
DBstart_time time,
DBend_date date,
DBend_time time,
);
create table Participants (PID int primary key not null,
Pname varchar(40),
bdate date,
gender varchar(1) check(gender in ('F','M','O')),
OID int,
foreign key (OID) references Organizations on delete set null on update cascade,
);
create table Attended (PID int,
EID int,
UNIQUE (PID, EID),
foreign key (PID) references Participants on delete set null on update cascade,
foreign key (EID) references DBevent on delete set null on update cascade,);
create table Sponsors 
(EID int,
OID int ,
Amounts int,
Unique (OID,EID),
foreign key (OID) references Organizations on delete set null on update cascade,
foreign key (EID) references DBevent on delete set null on update cascade,);

insert into DBevent values(1,'ABC','lahore','Seminar','2022-2-22','2:00:00','2022-2-22','6:00:00');
insert into DBevent values(2,'DEF','lahore','Seminar','2022-1-25','2:00:00','2022-1-25','6:00:00');
insert into DBevent values(3,'GHI','lahore','Seminar','2022-12-22','2:00:00','2022-12-22','6:00:00');
insert into DBevent values(4,'JKL','lahore','Conference','2022-2-22','2:00:00','2022-2-22','6:00:00');
insert into DBevent values(5,'MNO','lahore','Workshop','2022-12-22','2:00:00','2022-12-22','6:00:00');
insert into DBevent values(6,'MNO','lahore','Workshop','2023-1-03','2:00:00','2023-1-03','6:00:00');
select * from DBevent;
insert into Organizations values(1,'SOFTEC','FAST,lahore');
insert into Organizations values(2,'FAST','Faisal Town,lahore');
insert into Organizations values(3,'Techlogix','FAST,lahore');
insert into Organizations values(4,'DEF','FAST,lahore');
insert into Organizations values(5,'XYZ','FAST,lahore');
select * from Organizations;

insert into Participants values(1,'Hashim','2002-8-10','M',1);
insert into Participants values(2,'Hugo','2002-8-10','M',1);
insert into Participants values(3,'Ali','2002-8-10','M',1);
insert into Participants values(4,'Asad','2002-8-10','M',1);
insert into Participants values(5,'Sania','2002-8-10','F',NULL);
insert into Participants values(6,'Hania','2002-8-10','F',NULL);
select * from Participants;
insert into Sponsors values(1,1,5000);
insert into Sponsors values(2,1,1000);
insert into Sponsors values(3,3,3000);
insert into Sponsors values(4,5,4000);
insert into Sponsors values(5,3,7000);
insert into Sponsors values(2,3,9000);
select * from Sponsors;
insert into Attended values(1,1);
insert into Attended values(1,4);
insert into Attended values(1,2);
insert into Attended values(1,3);
insert into Attended values(1,5);
insert into Attended values(3,4);
insert into Attended values(4,1);
insert into Attended values(5,1);
select * from Attended;
---List the ids and names of all the Events.
select distinct EID,Ename
from DBevent;
----List the event id, name, and start_time of all the events that took place on January 3, 2023.
select EID,Ename,DBstart_time
from DBevent
where DBstart_date='2023-1-03';
----List the name of female participants younger than 25 who do not belong to any organization.
select distinct Pname
from Participants
where gender='F' and OID is NULL and bdate>='1997-1-1';
----Find the names of the organizations that have sponsored one or more events.
select distinct Oname 
from Sponsors join Organizations on Sponsors.OID=Organizations.OID ;

----Display the ids of the participants who attended the event organized by &quot;Techlogix&quot; on January 25, 2003.
select PID
from ((DBevent join Sponsors on DBevent.EID=Sponsors.EID)join Organizations on Organizations.OID=Sponsors.OID)join Attended on Sponsors.EID=Attended.EID
where DBstart_date='2022-1-25'and  Oname='Techlogix';
----List the names of organizations that have never sponsored a seminar; note seminar is a type of event.
select distinct Oname
from (DBevent join  Sponsors on DBevent.EID=Sponsors.EID)join Organizations on Organizations.OID=Sponsors.OID
where DBtype='Seminar';
----List the ids of participants who attended exactly five events.
Select PID
From Attended
Group by PID
Having COUNT(*) = 5;
--List the number of events attended by each participant.
Select M.PID, M.Pname, COUNT(*) as event_attend
From Participants M inner join Attended N on M.PID = N.PID
Group by M.PID, M.Pname;
--Find the maximum, minimum, and average sponsorship amount.
select max(Amounts) as maxi,min(Amounts) as mini,avg(Amounts) as average
from Sponsors;
--List the name of the organization that has organized a seminar and a workshop in December 2022.
select O.Oname
from DBevent D inner join Sponsors S ON D.EID = S.EID inner join Organizations O ON S.OID = O.OID
where D.DBtype in ('seminar', 'workshop') and  month(D.DBstart_date) = 12 and year(D.DBstart_date) = 2022
group by S.OID, O.Oname
having count(distinct D.DBtype) = 2;
--List the name of the organization that has organized a seminar and a workshop in December 2022.
select O.Oname
from DBevent D inner join Sponsors S ON D.EID = S.EID inner join Organizations O ON S.OID = O.OID
where D.DBtype in ('seminar') and  month(D.DBstart_date) = 12 and year(D.DBstart_date) = 2022
intersect 
select O.Oname
from DBevent D inner join Sponsors S ON D.EID = S.EID inner join Organizations O ON S.OID = O.OID
where D.DBtype in ('workshop') and  month(D.DBstart_date) = 12 and year(D.DBstart_date) = 2022;



--List the names of the participants who have attended a seminar but never attended a conference.
select M.Pname
from Participants M inner join Attended A on M.PID = A.PID inner join DBevent E ON A.EID = E.EID
where E.DBtype = 'Seminar' and M.PID not in(select A.PID
from Attended A inner join DBevent E ON A.EID = E.EID
where E.DBtype = 'conference')
GROUP BY M.PID, M.Pname;
--List the ids of participants who have attended an event on 5-Jan-2023 or who have never attended any event.
select M.PID
from Attended A full outer join Participants M on  A.PID= M.PID full outer join DBevent E On A.EID = E.EID
where E.DBstart_date='01-01-2023' or  E.DBstart_date is null;


DROP TABLE DBevent;
DROP TABLE Organizations;
DROP TABLE Participants;
DROP TABLE Sponsors;
DROP TABLE Attended;