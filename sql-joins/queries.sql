-- write your queries here

-- Join the two tables so that every column and record appears, 
-- regardless of if there is not an owner_id.
SELECT * FROM owners 
JOIN vehicles 
ON owners.id = vehicles.owner_id 
ORDER BY vehicles.owner_id;

-- Count the number of cars for each owner. Display the owners first_name, last_name and count of vehicles. 
-- The first_name should be ordered in ascending order.

SELECT first_name, last_name, COUNT(owner_id) FROM owners o
JOIN vehicles v ON o.id = v.owner_id
GROUP BY (first_name, last_name)
ORDER BY first_name;

-- Count the number of cars for each owner and display the average price for each of the cars as integers. 
-- Display the owners first_name, last_name, average price and count of vehicles.
-- The first_name should be ordered in descending order.
-- Only display results with more than one vehicle and an average price greater than 10000.

SELECT first_name, last_name, AVG(price), COUNT(v.owner_id)
FROM owners o
JOIN vehicles v ON o.id = v.owner_id
GROUP BY (first_name, last_name)
HAVING COUNT(owner_id) > 1 AND AVG(price) > 10000
ORDER BY first_name DESC;


-- Part Two:
-- Tutorials steps 6:
-- #1. Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

-- #2. Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2
  FROM game WHERE id = 1012

-- #3. Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid) 
  WHERE teamid = 'GER'

-- #4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid) 
  WHERE player LIKE 'Mario%'

-- #5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON teamid=id
  WHERE gtime<=10

-- #6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
  FROM game
  JOIN eteam ON (game.team1 = eteam.id)
  WHERE coach = 'Fernando Santos'

-- #7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player
FROM goal
JOIN game ON (goal.matchid = game.id)
WHERE stadium = 'National Stadium, Warsaw'

-- 8. Show names of all players who scored a goal against Germany.
SELECT DISTINCT player
FROM game
JOIN goal ON goal.matchid = game.id
WHERE (team1 = 'GER' OR team2 = 'GER')
AND teamid <> 'GER'

-- 9. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(player) goals_scored
FROM eteam JOIN goal ON eteam.id = goal.teamid
GROUP BY teamname

-- 10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(player) goals_scored
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY stadium

-- 11. For every match involving 'POL', show the matchid, date and the number of
-- goals scored.
SELECT matchid, mdate, COUNT(player) goals_scored
FROM game
JOIN goal ON goal.matchid = game.id
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY goal.matchid

-- 12. For every match where 'GER' scored, show matchid, match date and the
-- number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(player)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER'
GROUP BY game.id

-- 13. List every match with the goals scored by each team as shown.
-- Sort your result by mdate, matchid, team1 and team2.
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game JOIN goal ON goal.matchid = game.id
GROUP BY game.id
ORDER BY mdate, matchid, team1, team2