# База Данных - Футбольный турнир

### Логическая модель


![#f03c15](https://placehold.it/15/f03c15/000000?text=+) `PRIMARY KEY`

![#1589F0](https://placehold.it/15/1589F0/000000?text=+) `FOREIGN KEY`

![Screenshot](ER-model.png)

### Физическая модель

![Screenshot](LogicModel.PNG)

### Описание таблиц
 ##### 1. Лиги, в которых играют футбольные команды.
   
 ```SQL
  CREATE TABLE League (
	id_league int PRIMARY KEY,
	Country varchar(30) NOT NULL,
	Name varchar(30) NOT NULL
);
```
 В данной таблице после заполнения содержится 5 полей.
 
 ##### 2. Стадионы, на которых играют команды.
 
 ```SQL
 CREATE TABLE Stadium (
	id_stadium int PRIMARY KEY,
	Name varchar(30) NOT NULL,
	Country varchar(30) NOT NULL,
	Capacity int NOT NULL
);
```
 В данной таблице после заполнения содержится 7 полей.
 
 ##### 3. Команды, которые участвуют в турнире.
 
```SQL
CREATE TABLE Team (
	id_team int PRIMARY KEY,
	Name varchar(30) NOT NULL,
	Trainer varchar(30),
	Country varchar(30) NOT NULL,
	Stadium int NOT NULL REFERENCES Stadium(id_stadium),
	League int NOT NULL REFERENCES League(id_league),
	Fans int
);
```

В данной таблице после заполнения содержится 7 полей.
 
 ##### 4. Игроки, участвующие в турнире.
 
```SQL
CREATE TABLE Players (
	id_player int PRIMARY KEY,
	Name varchar(30) NOT NULL,
	Country varchar(30) NOT NULL,
	Salary int NOT NULL
);
```
В данной таблице после заполнения содержится 14 полей.
 
 ##### 5. Судьи, которые принимают участие в матчах турнира.

```SQL
CREATE TABLE Judge (
	id_judge int PRIMARY KEY,
	Salary int NOT NULL,
	Country varchar(30) NOT NULL,
	Name varchar(30) NOT NULL
);
```
В данной таблице после заполнения содержится 4 поля.
 
 ##### 6. Матчи, проходящие на данном турнире.
 
 ```SQL
 CREATE TABLE Game (
  id_game int PRIMARY KEY,
	Stadium int NOT NULL REFERENCES Stadium(id_stadium),
	Home_team int NOT NULL REFERENCES Team(id_team),
	Guest_team int NOT NULL REFERENCES Team(id_team),
	Judge int NOT NULL REFERENCES Judge(id_judge),
	League int NOT NULL REFERENCES League(id_league)
);
```
В данной таблице после заполнения содержится 3 поля.

 ##### 7. Статистики матчей, проводящихся на турнире.
 
```SQL
CREATE TABLE Game_statistic (
	Score varchar(10) NOT NULL,
	Fouls_amount int NOT NULL,
	Corners int NOT NULL,
	Possession varchar(10) NOT NULL,
	Hits_on_target varchar(10) NOT NULL,
	Game int REFERENCES Game(id_game),
	PRIMARY KEY (Game)
);
```
В данной таблице после заполнения содержится 3 поля.

  ##### 8. Таблица-связка между игроками и командами.
 
 ```SQL
 CREATE TABLE Players_Teams (
	id_player int REFERENCES Players(id_player),
	id_team int NOT NULL REFERENCES Team(id_team),
	DateStart DATE,
	DateEnd DATE,
	PRIMARY KEY(id_player, DateStart)
);
```
В данной таблице после заполнения содержится 14 полей. 

### Описание представлений(view)

##### 1. View возвращает топ-5 игроков с самыми высокими зарплатами на турнире, их страну и саму зарплату.
```SQL
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
```

Это представление нужно для того, чтобы следить за ситуацией на рынке игроков. Владельцам клубов важно понимать сколько получают
на данный момент самые высокооплачиваемые игроки.

##### 2. View выводит ироков из Англии, их нынешний клуб и дату начала карьеры в этом клубе.
```SQL
CREATE VIEW EnglishPlayers AS
	(
	SELECT P.Name, T.Name as Team, PT.DateStart
	  FROM Team T
		INNER JOIN Players_Teams PT on T.id_team = PT.id_team
		INNER JOIN Players P on PT.id_player = P.id_player
	  WHERE P.Country = 'England'
	    AND PT.DateEnd is NULL
	);
```

Это представление нужно для изучения футбольной карьеры английских игроков, так как они очень перспективные.

### Описание триггеров

 ##### 1. Триггер, который при добавлении в таблицу нового стадиона, сразу добавляет его в команду.
 
 ```SQL
 CREATE OR REPLACE FUNCTION new_stadium() RETURNS TRIGGER
AS $$
  BEGIN
    INSERT INTO Team(id_team, Stadium) VALUES (new.id_stadium, new.id_stadium);

    RETURN new;
	END;
  $$ LANGUAGE plpgsql;
  ```
  
  ```SQL
  CREATE TRIGGER tr_new_stadium AFTER INSERT ON Stadium
  FOR EACH ROW EXECUTE PROCEDURE new_stadium();
  ```
  
 
 ### Описание функций 
 
 ##### 1.  Функция на вход принимает id_team, а возвращает её название.
 
 ```SQL
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
```
 
 Очень часто нужно знать именно название команды, а не id. Для этого эта функция и нужна.
 
 ##### 2.  Подаётся на вход id_team. Функция возвращает имена игроков этой команды и их страны.
 
 ```SQL
 CREATE OR REPLACE FUNCTION
Players_from_team(input_id_team int)
RETURNS TABLE(
  player varchar(30),
  Country_player varchar(30) ) AS $$
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
 ```
 
 Функция нужна для понимания, насколько команда мильтинациональная. В некоторых лигах
 существует правило лимита на легионеров. Эта функция может показать превышен ли лимит.
 
 ### Описание ролей
 
 ##### 1. Роль предназначена только для выполнения запросов.
 
 ```SQL
 CREATE ROLE only_reading
	WITH LOGIN PASSWORD 'your password';

GRANT SELECT ON ALL TABLES IN SCHEMA football_tournament
	TO only_reading;
```

##### 2. Роль, права которой распространяются на все операции с данными таблицами.

```SQL
CREATE ROLE super_developer
	WITH LOGIN PASSWORD 'your password';

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA football_tournament
	TO super_developer;
```
