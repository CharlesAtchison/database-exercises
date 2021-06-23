-- database to be used
USE albums_db;


-- This will return the count of how many rows are in the albums table
SELECT 
	COUNT(*)
	
FROM albums;

-- This will return the unique artist names
SELECT 
	COUNT(DISTINCT artist) as number_of_unique_artist_names
	
FROM albums;

-- This will return the primary key for the albums table 

SELECT MAX(id) as current_primary_key

FROM albums;

-- This will return the oldest/most_recent release date for any album

SELECT 
	MIN(release_date) as oldest_release_date,
	MAX(release_date) as most_recent_release_date

FROM albums;

-- This will return the name of all albums by 'Pink Floyd'

SELECT
	name
FROM albums
WHERE artist = 'Pink Floyd';

-- This will return the year "Sgt. Pepper's Lonely Hearts Club" was released

SELECT 
	release_date
FROM albums	
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

-- This will return genre for the album "Nevermind"
SELECT
	genre
FROM albums
WHERE name = "Nevermind";

-- This will return albums that were released in the 1990's
SELECT
	name
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

-- This will return which albums had less than 20 million sales
SELECT 
	name
FROM albums
WHERE sales < 20;	

-- This will return albums with a genre of "Rock" (won't return hard rock or progressive rock because it doesn't match exactly, you'd need to use in modifier
SELECT
	name
FROM albums
WHERE UPPER(genre) LIKE '%ROCK%';	

