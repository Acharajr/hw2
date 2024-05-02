-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Warner Bros.
-- The Dark Knight        2008           PG-13  Warner Bros.
-- The Dark Knight Rises  2012           PG-13  Warner Bros.

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Turns column mode on but headers off
.mode columns
.headers off

-- Drop existing tables, so you'll start fresh each time this script is run.
DROP TABLE IF EXISTS studios;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS actors;
DROP TABLE IF EXISTS roles;

-- Create new tables, according to your domain model
CREATE TABLE studios (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

CREATE TABLE movies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  year_released INTEGER,
  rated TEXT,
  studio_id INTEGER
);

CREATE TABLE actors (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

CREATE TABLE roles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  movie_id INTEGER,
  actor_id INTEGER,
  character_name TEXT
);

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
INSERT INTO studios (name) VALUES ("Warner Bros."); -- 1

INSERT INTO movies (title, year_released, rated, studio_id)
VALUES ("Batman Begins", 2005, "PG-13", 1);

INSERT INTO movies (title, year_released, rated, studio_id)
VALUES ("The Dark Knight", 2008, "PG-13", 1);

INSERT INTO movies (title, year_released, rated, studio_id)
VALUES ("The Dark Knight Rises", 2012, "PG-13", 1);

-- Batman Begins
INSERT INTO actors (name) VALUES ("Christian Bale"); -- 1
INSERT INTO actors (name) VALUES ("Michael Caine"); -- 2
INSERT INTO actors (name) VALUES ("Liam Neeson");  -- 3
INSERT INTO actors (name) VALUES ("Katie Holmes");  -- 4
INSERT INTO actors (name) VALUES ("Gary Oldman");  -- 5

INSERT INTO roles (movie_id, actor_id, character_name) VALUES (1, 1, "Bruce Wayne");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (1, 2, "Alfred");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (1, 3, "Ra's Al Ghul");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (1, 4, "Rachel Dawes");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (1, 5, "Commissioner Gordon");

-- The Dark Knight
INSERT INTO actors (name) VALUES ("Heath Ledger"); -- 6
INSERT INTO actors (name) VALUES ("Aaron Eckhart"); -- 7
INSERT INTO actors (name) VALUES ("Maggie Gyllenhaal"); -- 8

INSERT INTO roles (movie_id, actor_id, character_name) VALUES (2, 1, "Bruce Wayne");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (2, 6, "Joker");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (2, 7, "Harvey Dent");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (2, 2, "Alfred");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (2, 8, "Rachel Dawes");

-- The Dark Knight Rises
INSERT INTO actors (name) VALUES ("Tom Hardy"); -- 9
INSERT INTO actors (name) VALUES ("Joseph Gordon-Levitt"); -- 10
INSERT INTO actors (name) VALUES ("Anne Hathaway"); -- 11

INSERT INTO roles (movie_id, actor_id, character_name) VALUES (3, 1, "Bruce Wayne");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (3, 5, "Commissioner Gordon");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (3, 9, "Bane");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (3, 10, "John Blake");
INSERT INTO roles (movie_id, actor_id, character_name) VALUES (3, 11, "Selina Kyle");

-- Prints a header for the movies output
.print "Movies"
.print "======"
.print ""

-- The SQL statement for the movies output
SELECT movies.title, movies.year_released, movies.rated, studios.name 
FROM movies INNER JOIN studios ON studios.id = movies.studio_id;

-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""

-- The SQL statement for the cast output
SELECT movies.title, actors.name, roles.character_name 
FROM roles 
INNER JOIN movies on movies.id = roles.movie_id 
INNER JOIN actors ON actors.id = roles.actor_id;
