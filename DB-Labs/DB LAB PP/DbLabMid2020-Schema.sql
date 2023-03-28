Create Database DbLabMid2020;
go
use DbLabMid2020;

Create Table Movie
(
	movieId int primary key,
	movieTitle varchar(100) NOT NULL,
	releaseDate date,
	runningTime int,
	productionCost float
);

Create Table Actor(
	actorId int primary key,
	actorName varchar(50),
	dateOfBirth date,
	gender varchar(1) check (gender in ('M', 'F'))
);

Create Table StarsIn
(
  actorId int,
  movieId int,
  foreign key  (actorId) references Actor (actorId),
  foreign key (movieId) references Movie (movieId),
  primary key  (actorId, movieId)
);

Create Table Studio 
(
	studioId int primary key,
	studioName varchar(100)  unique,
	address varchar(100),
	networth int
);

Create Table Genre
(
	genreId int primary key,
	genreName varchar(30) NOT NULL
);

Create Table MovieGenre
(
	movieId int, 
    genreId int, 
	foreign key (movieId) references Movie (movieId),
	foreign key (genreId) references Genre (genreId),
	primary key (movieId, genreId)

);
alter table Movie add studioId int;
alter table Movie add foreign key(studioId) references Studio (studioId);


Insert into Genre (genreId, genreName) values (1, 'Action');
Insert into Genre (genreId, genreName) values(3, 'Sci-Fi');
Insert into Genre (genreId, genreName) values(4, 'War');
Insert into Genre (genreId, genreName) values(5, 'History');
Insert into Genre (genreId, genreName) values (6, 'Western');
Insert into Genre (genreId, genreName) values(2, 'Horror');

Insert into Studio (studioId, studioName, address, networth) values(1, 'Universal Studios', 'California', 560000);
Insert into Studio (studioId, studioName, address, networth)  values(2, 'Paramount Pictures', 'California', 10000);
Insert into Studio (studioId, studioName, address, networth) values (3, 'Warner Bros', 'California', 140000);

Insert into Movie values (6, 'Jack Reacher', '2012-12-21', 130, 600000, 2);
Insert into Movie values (7, 'MalcomX', '1992-11-18', 202, 199999, 3);
Insert into Movie values (5, 'Giant', '1956-10-10', 202, 12233, 3);
Insert into Movie values (4, 'Fury', '2014-10-15', 135, 556533, NULL);
Insert into Movie values (3, 'Transformers', '2007-6-12', 143, 77554, 2);
Insert into Movie values (2, 'Night of the Living Dead', '1968-10-1', 90, 17000, NULL);
Insert into Movie values (1, 'city of Ghosts', '2017-10-1', 90, 22500, NULL);
Insert into Movie values(8, 'Pacific Rim', '2013-08-23', 132, 455633, 1);

Insert into MovieGenre (movieId, genreId) values (6, 1);
Insert into MovieGenre(movieId, genreId) values (7, 5);
Insert into MovieGenre(movieId, genreId) values(5,3);
Insert into MovieGenre(movieId, genreId) values (4, 1);
Insert into MovieGenre(movieId, genreId) values (4, 4);
Insert into MovieGenre(movieId, genreId)  values (3, 1);
Insert into MovieGenre(movieId, genreId)  values (2, 2);
Insert into MovieGenre(movieId, genreId)  values (1, 2);
Insert into MovieGenre(movieId, genreId) values (8,3);
Insert into MovieGenre(movieId, genreId) values (8,4);
Insert into MovieGenre(movieId, genreId)  values (8, 2);

Insert into Actor (actorId, actorName, dateOfBirth, gender) values (1, 'Tom Cruise', '1962-07-03', 'M');
Insert into Actor (actorId, actorName, dateOfBirth, gender) values (2, 'Richard Jenkins', '1947-05-04', 'M');
Insert into Actor (actorId, actorName, dateOfBirth, gender) values (5, 'Rosamund Pike', '1979-01-27', 'F');
Insert into Actor (actorId, actorName, dateOfBirth, gender) values (3, 'Elizabeth Taylor', '1932-2-27', 'F');
Insert into Actor (actorId, actorName, dateOfBirth, gender) values (4, 'Denzel Washington', '1954-12-28', 'M');
Insert into Actor (actorId, actorName, dateOfBirth, gender) values (6, 'Shia LaBeouf', '1986-6-11', 'M');
Insert into Actor (actorId, actorName, dateOfBirth, gender) values (7, 'Megan Fox', '1986-5-16', 'F');
Insert into Actor (actorId, actorName, dateOfBirth, gender) values(8, 'Duane Jones', '1937-2-2', 'M');
Insert into Actor (actorId, actorName, dateOfBirth, gender) values(9, 'Judith O''Dea', '1945-4-20', 'F');
Insert into Actor (actorId, actorName, dateOfBirth, gender) values(10, 'Charlie Hunnan', '1980-4-10', 'M');

Insert into StarsIn (actorId, movieId) values (1, 6);
Insert into StarsIn (actorId, movieId) values (2, 6);
Insert into StarsIn (actorId, movieId) values (5,6);
Insert into StarsIn (actorId, movieId) values (4, 7);
Insert into StarsIn (actorId, movieId) values (6, 3);
Insert into StarsIn (actorId, movieId) values (7,3);
Insert into StarsIn (actorId, movieId) values(8, 2);
Insert into StarsIn (actorId, movieId) values(9, 2);
Insert into StarsIn (actorId, movieId) values(10, 8);
Insert into StarsIn (actorId, movieId) values(9, 4);
Insert into StarsIn (actorId, movieId) values(5, 1);

Select * From Actor;
Select * From Genre;
Select * From Movie;
Select * From MovieGenre;
Select * From StarsIn;
Select * From Studio;

