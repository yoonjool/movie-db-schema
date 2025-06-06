-- 1. Find movies with a specific keyword in the title (String Operation)
SELECT name FROM Movies WHERE name LIKE '%Star Wars%';

-- 2. Get movies released after 2020 that also have a score of 5.0 or higher (Set Operation: INTERSECT)
SELECT name FROM Movies WHERE year >= 2020
INTERSECT
SELECT name FROM Movies WHERE score >= 5.0;

-- 3. Count the number of movies per genre and sort in descending order (GROUP BY + ORDER BY)
SELECT genre, COUNT(*) AS movie_count
FROM Movies
GROUP BY genre
ORDER BY movie_count DESC;

-- 4. Get genres with an average score above 7.5 (HAVING clause)
SELECT genre, AVG(score) AS avg_score
FROM Movies
GROUP BY genre
HAVING AVG(score) > 7.5;

-- 5. Show number of movies and average score by director (Aggregate Functions)
SELECT director, COUNT(*) AS movie_count, AVG(score) AS avg_score
FROM Movies
GROUP BY director
ORDER BY avg_score DESC;

-- 6. Retrieve the top 10 highest-scoring movies (WITH clause)
WITH TopMovies AS (
    SELECT name, score
    FROM Movies
    ORDER BY score DESC
    LIMIT 10
)
SELECT * FROM TopMovies;

-- 7. Analyze collaborations between a specific actor and directors (JOIN)
SELECT 
    m.Director, 
    COUNT(m.Name) AS Collaboration_Count, 
    SUM(m.Gross) AS Total_Gross
FROM Movies m
WHERE m.Star = 'Leonardo DiCaprio'
GROUP BY m.Director
ORDER BY Total_Gross DESC, Collaboration_Count DESC;

-- 8. Get top 3 highest-grossing movies per year (WITH + RANK)
WITH RankedMovies AS (
    SELECT 
        Name, 
        Year, 
        Gross, 
        RANK() OVER (PARTITION BY Year ORDER BY Gross DESC) AS Rank
    FROM Movies
)
SELECT * 
FROM RankedMovies
WHERE Rank <= 3
ORDER BY Year DESC, Rank ASC;
