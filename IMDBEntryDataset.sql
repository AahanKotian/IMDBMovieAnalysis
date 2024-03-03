-- 3. Exploratory data analysis (EDA)
-- Count the number of movies
SELECT COUNT(*) AS TotalMovies FROM imdbmovies;
-- The amount of TotalMovies is 7668

-- Count the number of movies by rating category
SELECT rating, COUNT(*) AS RatingCount
FROM imdbmovies
GROUP BY rating
ORDER BY RatingCount DESC;
-- Of the 14 types of ratings R has 3697, PG-13 has 2112 and PG has 1252 out of a total of 7668.

-- Calculate the average score for each rating category
SELECT rating, AVG(score) AS AvgScore
FROM imdbmovies
WHERE score IS NOT NULL
GROUP BY rating
ORDER BY AvgScore DESC;
-- Of the 14 ratings, the top 3 are TV-MA with the highest average score of 7.02, TV-PG at 6.94 and Not Rated at 6.91.

-- Calculate the average score of each genre
SELECT genre, AVG(score) AS AvgScore
FROM imdbmovies
GROUP BY genre
ORDER BY AvgScore DESC;
--The 3 highest genres with the highest average score are History at 8.3, Musical at 8.05 and Biography at 7.03092550790068

-- Calculate the average budget of each genre
SELECT genre, AVG(budget) AS AvgBudget
FROM imdbmovies
WHERE budget IS NOT NULL
GROUP BY genre
ORDER BY AvgBudget DESC;
-- The genre with the highest average budget is Animation at $75,785,197.13 and the lowest is History at $323,562.

-- Calculate the total budget of each genre
SELECT genre, SUM(budget) AS TotalBudget
FROM imdbmovies
WHERE budget IS NOT NULL
GROUP BY genre
ORDER BY TotalBudget DESC;
-- The genre with the highest total budget is Action at $82,886,723,068 and the lowest is History at $323,562.

-- Calculate the average gross revenue by genre. 
SELECT genre, AVG(gross) AS AvgGrossRevenue
FROM imdbmovies
WHERE gross IS NOT NULL
GROUP BY genre
ORDER BY AvgGrossRevenue DESC;
-- Similar to the above, the genre with the highest average gross revenue is Animation at $239,916,358.42 while Music is the lowest at $110,014.

-- Calculate the total gross revenue by genre.
SELECT genre, SUM(gross) AS TotalGrossRevenue
FROM imdbmovies
WHERE gross IS NOT NULL
GROUP BY genre
ORDER BY TotalGrossRevenue DESC;
-- The genre with the highest total gross revenue is Action is $243,435,855,754 while Music is the lowest at $110,014.

-- Calculate the Top 3 genres by average profit
SELECT TOP 3 genre, AVG(gross - budget) AS AvgProfit
FROM imdbmovies
WHERE gross IS NOT NULL AND budget IS NOT NULL
GROUP BY genre
ORDER BY AvgProfit DESC;
-- Interestingly, Family movies take the top spot of $467,458,146.75, Animation has an average of $204,072,214.44 and Action has $109,397,756.16.

-- Calculate the Bottom 3 genres by average profit
SELECT TOP 3 genre, AVG(gross - budget) AS AvgProfit
FROM imdbmovies
WHERE gross IS NOT NULL AND budget IS NOT NULL
GROUP BY genre
ORDER BY AvgProfit ASC;
-- The lowest average profit is Westerns at -$487057, Romance at $9,535,381, Sci-Fi at $13,193,435.66.

-- Find out the most common genres
SELECT genre, COUNT(*) AS GenreCount
FROM imdbmovies
GROUP BY genre
ORDER BY GenreCount DESC;
-- The most common genres of film are Comedy, Action and Drama at 2245, 1705 and 1518 respectively while the least common are Sport, History and Music.

-- Calculate the average rating and score for movies
SELECT AVG(score) AS AvgScore
FROM imdbmovies;
--The Average Score is 6.39.

-- Identify the highest-grossing movies
SELECT TOP 3 name, genre, gross
FROM imdbmovies
WHERE gross IS NOT NULL  -- Exclude movies with NULL gross values
ORDER BY gross DESC;
--The Top 3 Highest Grossing Movies are Avatar at $2,847,246,203, Avengers: Endame at $2,797,501,328, and Titanic and $2,201,647,264.
-- They are two Action movies and a Drama respectively.

-- Identify the lowest-grossing movies
SELECT TOP 3 name, genre, gross
FROM imdbmovies
WHERE gross IS NOT NULL  
ORDER BY gross ASC;  -- Order by gross revenue in ascending order
--The Bottom 3 Lowest Grossing Movies are Trojan War at $309, Madadayo at $596 and Run with the Hunted at $682.
-- They are a Comedy, Drama and Crime movie respectively.

-- Identify the highest-rated movies
SELECT TOP 10 name, genre, score
FROM imdbmovies
WHERE genre IS NOT NULL  
ORDER BY score DESC;
-- The Top 3 Highest Rated Movies are The Shawshank Redemption with a rating of 9.3, The Dark Knight with a rating of 9 and Schindler's List with 8.9
-- They are a Drama, Action movie and Biography respectively.

-- Identify the lowest-rated movies
SELECT TOP 10 name, genre, score
FROM imdbmovies
WHERE score IS NOT NULL
ORDER BY score ASC;
-- The Bottom 3 Lowest Rated Movies are Superbabies: Baby Geniuses 2, Disaster Movie, and The Hottie & the Nottie at 1.9. Incidentally, they are all comedies.

-- Check the distribution of movie runtimes
SELECT 
    CASE 
        WHEN runtime <= 90 THEN 'Short (< 90 mins)'
        WHEN runtime <= 120 THEN 'Medium (90-120 mins)'
        ELSE 'Long (> 120 mins)'
    END AS RuntimeCategory,
    COUNT(*) AS MovieCount
FROM imdbmovies
WHERE gross IS NOT NULL  -- Exclude movies with NULL gross values
GROUP BY 
    CASE 
        WHEN runtime <= 90 THEN 'Short (< 90 mins)'
        WHEN runtime <= 120 THEN 'Medium (90-120 mins)'
        ELSE 'Long (> 120 mins)'
    END;
-- Of the 3 Runtime Categories: Short(<90 mins) had a movie count of 1047. Medium (90-120 mins) had a movie count of 5031. Long (>120 mins) had a movie count of 1400

-- 5. Feature engineering
-- Calculate the profit for each movie (gross - budget)
SELECT name, gross - budget AS Profit
FROM imdbmovies
WHERE gross IS NOT NULL;  -- Exclude movies with NULL gross values
-- The Top 3 Movies with the highest overall profit was The Shining at $27,998,772, The Blue Lagoon at $54,353,106, and Star Wars: Episode V at $520,375,067.

-- 6. Advanced analysis
-- Analyze trends in movie ratings and scores over the years
SELECT year, AVG(score) AS AvgScore
FROM imdbmovies
GROUP BY year
ORDER BY AvgScore DESC;
--The first year is 1980 with an Average Score of 6.30 and the Average Score of 2020 is 5.97.
-- 2016 has the highest Average Score of any year at 6.623 while 2020 has the lowest score. 
-- This correlates with the enjoyment or lack thereof of the kinds of movies that were produced in these years.

-- Identify the most successful directors based on average ratings or gross profit.
SELECT director, AVG(score) AS AvgScores, SUM(gross-budget) AS TotalGross
FROM imdbmovies
GROUP BY director
ORDER BY TotalGross DESC;
-- The director with the highest average movie score was Christopher Nolan at 8.163 but Steven Spielberg has the highest gross profit at $7,737,549,370.

-- Identify the most successful writers based on average ratings or gross profit.
SELECT writer, AVG(score) AS AvgScores, SUM(gross-budget) AS TotalGross
FROM imdbmovies
GROUP BY writer
ORDER BY TotalGross DESC;
--The writer was the highest average score according to movie output was James Cameron at 7.8 while the highest total gross profit was Christopher Markus at $6,169,181,621.

-- Identify the most successful actors based on average ratings or gross revenue.
SELECT star, AVG(score) AS AvgScores, SUM(gross-budget) AS TotalGross
FROM imdbmovies
GROUP BY star
ORDER BY TotalGross DESC;
-- The actor with the highest average score according to movie output is Leonardo DiCaprio is 7.5 and while Robert Downey Jr. has the highest gross profit of $9,557,937,746.

-- Examine actors by movie count
SELECT star, COUNT(*) AS MovieCount
FROM imdbmovies
GROUP BY star
ORDER BY MovieCount DESC;
-- The actor acting in the most amount of movie was Nicolas Cage at 43 and Robert De Niro and Tom hanks trailing close behind at 41.

-- Examine directors by movie count
SELECT director, COUNT(*) AS MovieCount
FROM imdbmovies
GROUP BY director
ORDER BY MovieCount DESC;
-- The director with the greatest amount of movies directed is Woody Allen at 38 and Clint Eastwood coming in a close second at 31.

-- What is the Average Score by Movie Runtime?
SELECT RuntimeCategory, AVG(score) AS AvgScore
FROM (
    SELECT 
        CASE 
            WHEN runtime <= 90 THEN 'Short (< 90 mins)'
            WHEN runtime <= 120 THEN 'Medium (90-120 mins)'
            ELSE 'Long (> 120 mins)'
        END AS RuntimeCategory,
        score
    FROM imdbmovies
) AS RuntimeScores
WHERE RuntimeCategory IS NOT NULL
GROUP BY RuntimeCategory
ORDER BY AvgScore DESC;
-- Average Score tends to correlate with length as the longer the runtime the higher the score with Long being 7.03, Medium being 6.31 and Short being 5.90. 

-- What amount of movies directed by a director leads the highest average profit per movie
SELECT director, COUNT(*) AS MovieCount, AVG(gross - budget) AS AvgProfit
FROM imdbmovies
WHERE gross IS NOT NULL AND budget IS NOT NULL
GROUP BY director
ORDER BY AvgProfit DESC;
-- The highest average profit by directory is Anthony Russo at a count of $1,138,649,796.8 after a total of 5 movies.

-- Which Company had the greatest profit?
SELECT company, SUM(gross - budget) AS TotalProfit
FROM imdbmovies
WHERE gross IS NOT NULL AND budget IS NOT NULL
GROUP BY company
ORDER BY TotalProfit DESC;
-- Universal Pictures had the greatest total profit.

-- Which Company had the highest average score based on movie enjoyment?
SELECT company, AVG(score) AS AvgScore
FROM imdbmovies
WHERE score IS NOT NULL
GROUP BY company
ORDER BY AvgScore DESC;
-- Cecchi Gori Pictures tied with O2 Filmes, Strong Heart/Demme Production and Tokuma Shoten at 8.6.
