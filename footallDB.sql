CREATE schema IF NOT EXISTS football_tournament;

SET search_path = football_tournament, public;

CREATE TABLE League (
	id_league int PRIMARY KEY,
	Country varchar(30) NOT NULL,
	Name varchar(30) NOT NULL
);


CREATE TABLE Stadium (
	id_stadium int PRIMARY KEY,
	Name varchar(30) NOT NULL,
	Country varchar(30) NOT NULL,
	Capacity int NOT NULL
);


CREATE TABLE Team (
	id_team int PRIMARY KEY,
	Name varchar(30) NOT NULL,
	Trainer varchar(30),
	Country varchar(30) NOT NULL,
	Stadium int NOT NULL REFERENCES Stadium(id_stadium),
	League int NOT NULL REFERENCES League(id_league),
	Fans int
);


CREATE TABLE Players (
	id_player int PRIMARY KEY,
	Name varchar(30) NOT NULL,
	Country varchar(30) NOT NULL,
	Salary int NOT NULL
);


CREATE TABLE Judge (
	id_judge int PRIMARY KEY,
	Salary int NOT NULL,
	Country varchar(30) NOT NULL,
	Name varchar(30) NOT NULL
);


CREATE TABLE Game (
  id_game int PRIMARY KEY,
	Stadium int NOT NULL REFERENCES Stadium(id_stadium),
	Home_team int NOT NULL REFERENCES Team(id_team),
	Guest_team int NOT NULL REFERENCES Team(id_team),
	Judge int NOT NULL REFERENCES Judge(id_judge),
	League int NOT NULL REFERENCES League(id_league)
);


CREATE TABLE Players_Teams (
	id_player int REFERENCES Players(id_player),
	id_team int NOT NULL REFERENCES Team(id_team),
	DateStart DATE,
	DateEnd DATE,
	PRIMARY KEY(id_player, DateStart)
);


CREATE TABLE Game_statistic (
	Score varchar(10) NOT NULL,
	Fouls_amount int NOT NULL,
	Corners int NOT NULL,
	Possession varchar(10) NOT NULL,
	Hits_on_target varchar(10) NOT NULL,
	Game int REFERENCES Game(id_game),
	PRIMARY KEY (Game)
);



-- DROP SCHEMA IF EXISTS football_tournament CASCADE;



INSERT INTO Stadium
	VALUES (1, 'Santiago Bernabeu', 'Spain', 82000);

INSERT INTO Stadium
	VALUES (2, 'Camp Nou', 'Spain', 100000);

INSERT INTO Stadium
	VALUES (3, 'Anfield', 'England', 54000);

INSERT INTO Stadium
	VALUES (4, 'Tottenham Hotspur Stadium', 'England', 63000);

INSERT INTO Stadium
	VALUES (5, 'San Siro', 'Italy', 80000);

INSERT INTO Stadium
	VALUES (6, 'Etihad Stadium', 'England', 55000);

INSERT INTO Stadium
	VALUES (7, 'Artemio Franchi', 'Italy', 43000);




INSERT INTO League
	VALUES (1, 'Spain', 'LaLiga');

INSERT INTO League
	VALUES (2, 'England', 'Premier League');

INSERT INTO League
	VALUES (3, 'Italy', 'Seria A');

INSERT INTO League
	VALUES (4, 'Russia', 'RPL');

INSERT INTO League
	VALUES (5, 'USA', 'MLS');




INSERT INTO Team
	VALUES (1, 'Real Madrid FC.', 'Zidane', 'Spain', 1, 1, 80000);

INSERT INTO Team
	VALUES (2, 'Barcelona FC.', 'Velverde', 'Spain', 2, 1, 77000);

INSERT INTO Team
	VALUES (3, 'Liverpool FC.', 'Klopp', 'England', 3, 2, 75000);

INSERT INTO Team
	VALUES (4, 'Tottenham Hotspur', 'Pochettino', 'England', 4, 2, 75000);

INSERT INTO Team
	VALUES (5, 'Milan', 'Gattuso', 'Italy', 5, 3, 70000);

INSERT INTO Team
	VALUES (6, 'Manchester City', 'Guardiola', 'England', 6, 2, 55000);

INSERT INTO Team
	VALUES (7, 'Fiorentina', 'Montella', 'Italy', 7, 3, 45000);




INSERT INTO Players
 VALUES (1, 'Sergio Ramos', 'Spain', 35000);

INSERT INTO Players
	VALUES (2, 'Keylor Navas', 'Costa Rica', 25000);

INSERT INTO Players
	VALUES (3, 'Karim Benzema', 'France', 35000);

INSERT INTO Players
	VALUES (13, 'Cristiano Ronaldo', 'Portugal', 45000);

INSERT INTO Players
	VALUES (4, 'Lionel Messi', 'Argentina', 45000);

INSERT INTO Players
	VALUES (5, 'Luis Suarez', 'Uruguay', 35000);

INSERT INTO Players
	VALUES (6, 'Dembele', 'France', 24000);

INSERT INTO Players
	VALUES (7, 'Mo Salah', 'Egypt', 30000);

INSERT INTO Players
	VALUES (8, 'Sadio Mane', 'Senegal', 23000);

INSERT INTO Players
	VALUES (9, 'Roberto Firmino', 'Brazil', 23000);

INSERT INTO Players
	VALUES (10, 'Harry Kane', 'England', 25000);

INSERT INTO Players
	VALUES (11, 'Son', 'South Korea', 20000);

INSERT INTO Players
	VALUES (12, 'Dele Alli', 'England', 23000);

INSERT INTO Players
	VALUES (14, 'Gareth Bale', 'Wales', 30000);



INSERT INTO Players_Teams
	VALUES (1, 1, '2008-04-01', NULL);

INSERT INTO Players_Teams
	VALUES (2, 1, '2014-09-01', NULL);

INSERT INTO Players_Teams
	VALUES (3, 1, '2011-07-15', NULL);

INSERT INTO Players_Teams
	VALUES (4, 2, '2000-01-01', NULL);

INSERT INTO Players_Teams
	VALUES (5, 2, '2014-03-09', NULL);

INSERT INTO Players_Teams
	VALUES (6, 2, '2018-06-19', NULL);

INSERT INTO Players_Teams
	VALUES (7, 3, '2016-04-30', NULL);

INSERT INTO Players_Teams
	VALUES (8, 3, '2014-01-19', NULL);

INSERT INTO Players_Teams
	VALUES (9, 3, '2013-06-06', NULL);

INSERT INTO Players_Teams
	VALUES (10, 4, '2008-07-08', NULL);

INSERT INTO Players_Teams
	VALUES (11, 4, '2010-08-12', NULL);

INSERT INTO Players_Teams
	VALUES (12, 4, '2015-09-01', NULL);

INSERT INTO Players_Teams
	VALUES (13, 1, '2011-08-01', '2018-07-21');

INSERT INTO Players_Teams
	VALUES (14, 4, '2010-01-09', '2013-06-09');

INSERT INTO Players_Teams
	VALUES (14, 1, '2013-06-10', NULL);



INSERT INTO Judge
	VALUES (1, 15000, 'Russia', 'Sergey Karasev');

INSERT INTO Judge
	VALUES (2, 15000, 'Germany', 'Felix Brych');

INSERT INTO Judge
	VALUES (3, 12500, 'Turkey', 'Cüneyt Çakır');

INSERT INTO Judge
	VALUES (4, 18000, 'Italy', 'Nicola Rizzoli');



INSERT INTO Game
	VALUES (1, 1, 1, 2, 2, 1);

INSERT INTO Game
	VALUES (2, 3, 3, 4, 1, 2);

INSERT INTO Game
	VALUES (3, 4, 4, 3, 1, 2);



INSERT INTO Game_statistic
 VALUES ('2 : 0', 4, 6, '60%-40%', '8 - 2', 1);

INSERT INTO Game_statistic
	VALUES ('0 : 1', 7, 3, '34% - 66%', '4 - 4', 2);

INSERT INTO Game_statistic
	VALUES ('3 : 3', 7, 5, '50% - 50%', '5 - 6', 3);


SELECT *
  FROM Team;

SELECT *
	FROM Stadium;

SELECT *
	FROM Players;

SELECT *
	FROM League;

SELECT *
	FROM Game_statistic;

SELECT *
	FROM Game;

SELECT *
	FROM Players_Teams;



-- запрос выводит счёт матча; id-команд-участниц; Лигу; кол-во фолов и угловых за игру
SELECT GS.Score, G.Guest_team, G.Home_team, L.Name, GS.fouls_amount, GS.Corners
		FROM Game_statistic GS
	INNER JOIN Game G on GS.Game = G.id_game
	INNER JOIN League L on G.League = L.id_league
		ORDER BY GS.Score DESC;



-- Запрос выводит Игрока с зарплатой выше среднего в его команде; его команду; его зарплату
SELECT P.Name, T.Name, P.Salary
		FROM Players P
	INNER JOIN Players_Teams PT ON P.id_player = PT.id_player
	INNER JOIN Team T on PT.id_team = T.id_team
		WHERE DateEnd is NULL
		  AND P.Salary > (SELECT avg(Salary)
		  	FROM Players
		    	INNER JOIN Players_Teams PT2 on Players.id_player = PT2.id_player
		    	INNER JOIN Team T2 on PT2.id_team = T2.id_team
		   			WHERE T2.id_team = PT.id_team
		    		AND PT2.DateEnd is NULL)
	ORDER BY  P.Salary;



-- Выводит счёт в матчах, где судил русский судья
SELECT Score
	FROM Game_statistic
INNER JOIN Game G ON Game_statistic.Game = G.id_game
INNER JOIN Judge J ON G.Judge = J.id_judge
	WHERE J.Country = 'Russia';



-- Выводит топ5 по зарплате игроков, их страну, зарплату
CREATE VIEW topSalaries AS
	(
	SELECT *
	FROM (SELECT Name,
		     Country,
		     Salary,
		     row_number() OVER (ORDER BY Salary DESC)
		     AS top_5
	      FROM Players) AS Q
	WHERE top_5 < 6
	);

SELECT *
	FROM topSalaries;




--Выводит ироков из Англии, их нынешний Клуб и дату начала карьеры в этом клубе
CREATE VIEW EnglishPlayers AS
	(
	SELECT P.Name, T.Name as Team, PT.DateStart
	FROM Team T
	 INNER JOIN Players_Teams PT on T.id_team = PT.id_team
	 INNER JOIN Players P on PT.id_player = P.id_player
  	WHERE P.Country = 'England'
    	 AND PT.DateEnd is NULL
	);

-- DROP VIEW EnglishPlayers;


SELECT *
	FROM EnglishPlayers;


-- триггер, который при добавлении в таблицу нового стадиона, сразу добавляет его в команду
-- здесь, id_team = id_stadium, т.к у каждой команды свой стадион
CREATE OR REPLACE FUNCTION new_stadium() RETURNS TRIGGER
AS $$
  BEGIN
    INSERT INTO Team(id_team, Stadium) VALUES (new.id_stadium, new.id_stadium);

    RETURN new;
	END;
  $$ LANGUAGE plpgsql;


-- drop trigger if exists tr_new_stadium on Stadium;


 CREATE TRIGGER tr_new_stadium AFTER INSERT ON Stadium
  FOR EACH ROW EXECUTE PROCEDURE new_stadium();



INSERT INTO Stadium
	VALUES (8, 'Allianz Stadium', 'Italy', 76000);



SELECT *
	FROM Stadium;

SELECT *
	FROM Team;


-- функция выдаёт название команды по ее id_team
CREATE OR REPLACE FUNCTION
Team_name (input_id_team int)
	RETURNS varchar(30) AS $$
  DECLARE team_name varchar(30);
  BEGIN
    IF input_id_team NOT IN (SELECT id_team FROM Team) THEN
			RAISE EXCEPTION 'This Team does not exist';
		END IF;
    SELECT Team.Name INTO team_name
    	FROM Team
    WHERE id_team = $1;
    RETURN team_name;
	END;
  $$ LANGUAGE plpgsql;

-- DROP FUNCTION team_name(current_id_team integer);

SELECT * FROM Team_name(6);

SELECT * FROM Team_name(0);



-- функция, которая выдает по запросу id_team игроков этой команды и их страны
CREATE OR REPLACE FUNCTION
Players_from_team(input_id_team int)
RETURNS TABLE(
  player varchar(30),
  Country_player varchar(30) ) AS
  $$
  BEGIN
    IF input_id_team NOT IN (SELECT id_team FROM Team) THEN
			RAISE EXCEPTION 'This Team does not exist';
		END IF;
		RETURN QUERY
		SELECT Players.Name, Players.Country FROM Players
    	INNER JOIN Players_Teams PT on Players.id_player = PT.id_player
    WHERE PT.id_team = $1;
	END;
  $$ LANGUAGE plpgsql;

-- DROP FUNCTION Players_from_team(num int);

SELECT * FROM Players_from_team(-3);

SELECT * FROM Players_from_team(2);

SELECT * FROM Players_from_team(9);



CREATE ROLE only_reading
	WITH LOGIN PASSWORD '1234';

GRANT SELECT ON ALL TABLES IN SCHEMA football_tournament
	TO only_reading;


CREATE ROLE super_developer
	WITH LOGIN PASSWORD 'gkgfkdgopdh';

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA football_tournament
	TO super_developer;
