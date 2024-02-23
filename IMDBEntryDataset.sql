-- 3. Exploratory data analysis (EDA)
-- Count the number of movies
SELECT COUNT(*) AS TotalMovies FROM imdbmovies;
-- The amount of TotalMovies is 7668

-- Count the number of movies by rating category
SELECT rating, COUNT(*) AS RatingCount
FROM imdbmovies
GROUP BY rating
ORDER BY RatingCount DESC;
-- Of the 14 types of ratings R has 3697, PG-13 has 2112 and PG has 1252.

-- Calculate the average score for each rating category
SELECT rating, AVG(score) AS AvgScore
FROM imdbmovies
GROUP BY rating
ORDER BY AvgScore DESC;
-- Of the 14 ratings TV-MA has the highest average score of 7.02222222222222, TV-PG at 6.94 and Not Rated at 6.91631205673759.

-- Calculate the average score of each genre
SELECT genre, AVG(score) AS AvgScore
FROM imdbmovies
GROUP BY genre
ORDER BY AvgScore DESC;
--The 3 highest genres with the highest average score are History at 8.3, Musical at 8.05 and Biography at 7.03092550790068

-- Calculate the average budget of each genre
SELECT genre, AVG(budget) AS AvgBudget
FROM imdbmovies
GROUP BY genre
ORDER BY AvgBudget DESC;
-- The genre with the highest average budget is Animation at $75,785,197.13 and the lowest is history at $323,562.

-- Calculate the average gross revenue by genre.
SELECT genre, AVG(gross) AS AvgGrossRevenue
FROM imdbmovies
GROUP BY genre
ORDER BY AvgGrossRevenue DESC;
-- Similar to the above, the genre with the highest average gross revenue is Animation at $239,916,358.42.

-- Find out the most common genres
SELECT genre, COUNT(*) AS GenreCount
FROM imdbmovies
GROUP BY genre
ORDER BY GenreCount DESC;
-- The most common genres of film are Comedy, Action and Drama at 2245, 1705 and 1518 respectively.

-- Calculate the average rating and score for movies
SELECT AVG(score) AS AvgScore
FROM imdbmovies;
--The Average Score is 6.3902792275574

-- Identify the highest-grossing movies
SELECT TOP 10 name, gross
FROM imdbmovies
ORDER BY gross DESC;
--The Highest Grossing Movies are Avatar, Avengers: Endame, and Titanic.

-- Check the distribution of movie runtimes
SELECT 
    CASE 
        WHEN runtime <= 90 THEN 'Short (< 90 mins)'
        WHEN runtime <= 120 THEN 'Medium (90-120 mins)'
        ELSE 'Long (> 120 mins)'
    END AS RuntimeCategory,
    COUNT(*) AS MovieCount
FROM imdbmovies
GROUP BY 
    CASE 
        WHEN runtime <= 90 THEN 'Short (< 90 mins)'
        WHEN runtime <= 120 THEN 'Medium (90-120 mins)'
        ELSE 'Long (> 120 mins)'
    END;
-- Of the 3 Runtime Categories: Short(<90 mins) had a movie count of 1115. Medium (90-120 mins) had a movie count of 5128. Long (>120 mins) had a movie count of 1425

-- 5. Feature engineering
-- Calculate the profit for each movie (gross - budget)
SELECT name, gross - budget AS Profit
FROM imdbmovies;

-- 6. Advanced analysis
-- Analyze trends in movie ratings and scores over the years
SELECT year, AVG(score) AS AvgScore
FROM imdbmovies
GROUP BY year
ORDER BY year;
--The first year is 1980 with an Average Score of 6.30434782608696 and the Average Score of 2020 is 5.97272727272727.

-- Identify the most successful directors based on average ratings or gross revenue.
SELECT director, AVG(score) AS AvgScores, SUM(gross) AS TotalGross
FROM imdbmovies
GROUP BY director
ORDER BY TotalGross DESC;
-- The director with the highest average movie score was Christopher Nolan at 8.16363636363636 and but Steven Spielberg has the highest gross revenue at $9,629,049,370.

-- Identify the most successful writers based on average ratings or gross revenue.
SELECT writer, AVG(score) AS AvgScores, SUM(gross) AS TotalGross
FROM imdbmovies
GROUP BY writer
ORDER BY TotalGross DESC;
--The writer was the highest average score and total gross revenue was Christopher Markus at 7.41428571428571 and $7,587,181,621.

-- Identify the most successful actors based on average ratings or gross revenue.
SELECT star, AVG(score) AS AvgScores, SUM(gross) AS TotalGross
FROM imdbmovies
GROUP BY star
ORDER BY TotalGross DESC;
-- The actor with the highest average score is Leonardo DiCaprio is 7.5 and while Robert Downey Jr. has a gross revenue of $11,859,526,234.
