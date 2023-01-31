CREATE TABLE movies (
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    title    TEXT    NOT NULL,
    year     INTEGER NOT NULL,
    director TEXT    NOT NULL,
    genres   TEXT    NOT NULL,
    state    TEXT    CHECK (length(state) = 2) NOT NULL,
    studio_id INTEGER  REFERENCES studio(id)
    
); 


CREATE TABLE actors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    actor_name TEXT NOT NULL,
    yob INTEGER NOT NULL

);


CREATE TABLE movie_has_actor (
    movie_id INTEGER REFERENCES movies (id),
    actor_id INTEGER REFERENCES Actors (id),
    PRIMARY KEY (
        movie_id,
        actor_id
    )
);


CREATE TABLE studio (
                    Id INTEGER PRIMARY KEY AUTOINCREMENT,
                    studio_name TEXT NOT NULL

                    );

INSERT INTO movies (id, title, year, director, genres, state, studio_id) VALUES
                    
    (1, 'Green Book', 2018, 'Peter Farelly', 'Biography', 'US', 1),
    (2, 'Jagten', 2012, 'Thomas Vinterberg', 'Drama', 'DK', 2),
    (3, 'Gegen die Wand', 2004 , 'Fatih Akin', 'Drama', 'DE', 3),
    (4, 'Sivi kamion crvene boje', 2004, 'Srdjan Koljevic', 'Comedy', 'SR', 4),
    (5, 'Laurence anyways', 2012, 'Xavier Dolan', 'Romance', 'CA', 5),
    (6, 'Buffalo 66', 1998, 'Vincent Gallo', 'Crime', 'US', 6),
    (7, 'Ong Bak: The Thai Warrior', 2003, 'Prachya Pinkaew', 'Action', 'SG', 7),
    (8, 'Snabba Cash', 2010, 'Daniel Espinosa', 'Crime', 'SE', 8);
        

INSERT INTO actors (id, actor_name, yob) VALUES 
    (1, 'Viggo Mortensen', 1958),
    (2, 'Mad Mikkelsen', 1965),
    (3, 'Birol Ünel', 1961),
    (4, 'Srdjan Todorovic', 1965),
    (5, 'Melvil Poupaud', 1973),
    (6, 'Vincent Gallo', 1961),
    (7, 'Suzanne Clément', 1969),
    (8, 'Christina Ricci', 1980),     
    (9, 'Mahershala Ali', 1974),
    (10 , 'Sibel Kekilli', 1980),
    (11, 'Thomas Bo Larsen', 1963),
    (12, 'Aleksandra Balmazovic', 1976),
    (13, 'Tony Jaa', 1976),
    (14, 'Joel Kinnaman', 1979);
    



INSERT INTO movie_has_actor (movie_id, actor_id) 

VALUES 
     (1, 1),
     (1, 9),
     (2, 2),
     (2, 11),
     (3, 3),
     (3, 10),
     (4, 4),
     (4, 12),
     (5, 5),
     (5, 7),
     (6, 6),
     (6, 8),
     (7, 13),
     (8, 14);
     

INSERT INTO studio (id, studio_name) 

VALUES
    (1,'DreamWorks Pictures'),
    (2, 'Zentropa'),
    (3, 'Arte'),
    (4, 'Komuna'),
    (5, 'Cinépix Film Properties'),
    (6, 'Lyla Films'),
    (7, 'Baa-Ram-Ewe'),
    (8, 'Tre Vänner Produktion AB');


     
SELECT * FROM movies;
                   
 
SELECT movies.title AS 'Movies', group_concat(actor_name, ', ') AS 'Actor Name', movies.genres AS 'Genre' FROM movies 
    JOIN movie_has_actor ON movies.id = movie_has_actor.movie_id
    JOIN actors ON actors.id = movie_has_actor.actor_id
    GROUP BY movies.id;

SELECT movies.title, actors.actor_name, movies.director, movies.state FROM movies 
    JOIN movie_has_actor ON movies.id = movie_has_actor.movie_id
    JOIN actors ON actors.id = movie_has_actor.actor_id
    WHERE actors.actor_name OR movies.director LIKE '%vi%';



SELECT movies.title, studio.studio_name AS 'Studio', studio.Id FROM movies
    LEFT JOIN studio ON movies.studio_id = studio.id
    GROUP BY movies.id;
    
       
SELECT studio_name, Id FROM studio
    WHERE studio_name LIKE '%Fil%';


SELECT studio.studio_name, Id FROM studio;

SELECT  movies.title, movies.state, group_concat(actor_name, ', ') AS 'Actor Name', actors.yob FROM movies 
    LEFT JOIN movie_has_actor ON movies.id = movie_has_actor.movie_id
    LEFT JOIN actors ON actors.id = movie_has_actor.actor_id
    GROUP BY movies.id;
    

SELECT actors.actor_name, actors.yob from actors
    WHERE yob < 1964;
    
    
SELECT movies.title, studio_name FROM movies
    LEFT JOIN studio ON movies.studio_id = studio.id
    WHERE title LIKE '%en%';
    
    
SELECT title AS 'Movies', year AS 'Year', director AS 'Director', genres AS 'Genre', group_concat(actor_name, ', ') AS 'Actor Name', studio_name FROM movies
LEFT JOIN movie_has_actor ON movie_has_actor.movie_id = movies.id
LEFT JOIN actors ON movie_has_actor.actor_id = actors.id
LEFT JOIN studio ON studio.id = movies.studio_id
GROUP by (movies);

SELECT title AS 'Movies', group_concat(actor_name, ', ') AS 'Actor Name', genres AS 'Genre', studio_name AS 'Studio Name' FROM movies
LEFT JOIN movie_has_actor ON movie_has_actor.movie_id = movies.id
LEFT JOIN actors ON movie_has_actor.actor_id = actors.id
LEFT JOIN studio ON studio.id = movies.studio_id
GROUP by (movies);

