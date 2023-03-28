SELECT s.studioName, COUNT(DISTINCT si.actorId) AS NumberOfActors
FROM Studio s
JOIN Movie m ON s.studioId = m.studioId
JOIN StarsIn si ON m.movieId = si.movieId
GROUP BY s.studioName;

-- Write a query to display the actor ids and actor names who have worked in the highest
-- number of movies genre.
SELECT DISTINCT a.actorId , a.actorName, COUNT(mg.genreId)
FROM (Actor a JOIN StarsIn s ON a.actorId = s.actorId)
JOIN Movie m ON m.movieId = s.movieId JOIN MovieGenre mg ON m.movieId = mg.movieId
WHERE mg.genreId IN (
	SELECT genreId
	FROM MovieGenre gm
	GROUP by genreId
	HAVING genreId = MAX(genreId)
)
GROUP BY a.actorId , a.actorName;

WITH GenreCount AS (
    SELECT si.actorId, COUNT(DISTINCT mg.genreId) AS GenreCount
    FROM StarsIn si
    JOIN MovieGenre mg ON si.movieId = mg.movieId
    GROUP BY si.actorId
),
MaxGenreCount AS (
    SELECT MAX(GenreCount) AS MaxGenreCount
    FROM GenreCount
)
SELECT a.actorId, a.actorName,gc.GenreCount
FROM Actor a
JOIN GenreCount gc ON a.actorId = gc.actorId
JOIN MaxGenreCount mgc ON gc.GenreCount = mgc.MaxGenreCount;
-----------------------------------
WITH GenreCount AS (
	SELECT s.actorId, COUNT(DISTINCT mg.genreId) AS GenreCount
	FROM StarsIn s JOIN MovieGenre mg ON s.movieId = mg.movieId 
	GROUP BY s.actorId
),
MaxGenreCount AS (
	SELECT MAX(GenreCount) AS MaxGenreCount FROM GenreCount
)
SELECT a.actorId, a.actorName
FROM Actor a JOIN GenreCount gc ON a.actorId = gc.actorId
JOIN MaxGenreCount mgc ON mgc.MaxGenreCount = gc.GenreCount;

------------------
SELECT a.actorName, m.movieTitle, g.genreName
FROM Actor a
JOIN StarsIn si ON a.actorId = si.actorId
JOIN Movie m ON si.movieId = m.movieId
JOIN MovieGenre mg ON m.movieId = mg.movieId
JOIN Genre g ON mg.genreId = g.genreId
WHERE g.genreId IN (
    SELECT mg.genreId
    FROM MovieGenre mg
    GROUP BY mg.genreId
    HAVING COUNT(DISTINCT mg.movieId) = (
        SELECT MAX(MovieCount)
        FROM (
            SELECT COUNT(DISTINCT mg.movieId) AS MovieCount
            FROM MovieGenre mg
            GROUP BY mg.genreId
        )
    )
);



