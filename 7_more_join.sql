/*
https://sqlzoo.net/wiki/More_JOIN_operations


movie
id	title	yr	director	budget	gross 

actor
id	name 

casting
movieid	actorid	ord

-- 1
List the films where the yr is 1962 [Show id, title] */

SELECT id, title
 FROM movie
 WHERE yr=1962


/* 2
Give year of 'Citizen Kane'.
*/

SELECT yr FROM movie
WHERE title='Citizen Kane'


/* 3
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). 
Order results by year.
*/

SELECT id, title, yr FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr


/* 4
What id number does the actor 'Glenn Close' have?
*/

SELECT id FROM actor
WHERE name ='Glenn Close'

/* 5
What is the id of the film 'Casablanca'
*/

SELECT id FROM movie
WHERE title = 'Casablanca'

/* 6
Obtain the cast list for 'Casablanca'.

what is a cast list?
Use movieid=11768, (or whatever value you got from the previous question)
*/

SELECT actor.name FROM actor
JOIN casting 
ON actor.id = casting.actorid
WHERE movieid=11768

/* 7
Obtain the cast list for the film 'Alien'
*/

SELECT actor.name FROM actor
JOIN casting
ON actor.id = casting.actorid
JOIN movie
ON casting.movieid = movie.id
WHERE movie.title='Alien'


/* 8
List the films in which 'Harrison Ford' has appeared
*/
SELECT movie.title FROM movie
JOIN casting
ON movie.id = casting.movieid
JOIN actor
ON casting.actorid = actor.id
WHERE actor.name='Harrison Ford'


/* 9
List the films where 'Harrison Ford' has appeared - 
but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. 
If ord=1 then this actor is in the starring role]
*/
SELECT movie.title FROM movie
JOIN casting
ON movie.id = casting.movieid
JOIN actor
ON casting.actorid = actor.id
WHERE actor.name='Harrison Ford' AND  ord!=1

/* 10
List the films together with the leading star for all 1962 films
*/

select movie.title, actor.name FROM movie
JOIN casting
ON movie.id = casting.movieid
JOIN actor
ON casting.actorid = actor.id
WHERE casting.ord=1 AND movie.yr = 1962

/* 11
Which were the busiest years for 'Rock Hudson', 
show the year and the number of movies he made each year 
for any year in which he made more than 2 movies.
*/

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

/* 12
List the film title and the leading actor 
for all of the films 'Julie Andrews' played in.
*/

SELECT title, name FROM movie AS m
INNER JOIN casting AS c ON m.id = c.movieid
INNER JOIN actor AS a ON c.actorid = a.id
WHERE c.ord = 1 AND m.id IN
(SELECT m.id FROM movie AS m
INNER JOIN casting as c ON m.id = c.movieid
INNER JOIN actor AS a ON c.actorid = a.id
WHERE a.name = 'Julie Andrews')


/* 13
Obtain a list, in alphabetical order, 
of actors who've had at least 15 starring roles.
*/

        /* step 1: Get actor ids for actors that have 
        15 or more leading roles */

        SELECT actorid FROM casting
        WHERE casting.ord=1
        GROUP BY actorid
        HAVING COUNT(*) >=15

        /* step 2: get actor name that associates with actorid, then look
        to see if that actor has 15 more leading roles */

        SELECT actor.name FROM actor
        INNER JOIN casting ON actor.id = casting.actorid
        WHERE id IN  (
              SELECT actorid FROM casting
        WHERE casting.ord=1
        GROUP BY actorid
        HAVING COUNT(*) >=15
        )
        GROUP BY               --Only need one name per actor, so group to aggregate
        ORDER BY NAME          --alphabetical order


/* 14
List the films released in the year 1978 
ordered by the number of actors in the cast, then by title.
*/
    --Get number of actors for each movie

    SELECT movieid, count(actorid) AS actors FROM casting
    GROUP BY movieid
    ORDER BY actors DESC


    --Get movies from 1978
    SELECT movie.title FROM movie
    WHERE yr = 1978

    -- Now figure out how to combine the two and order columns.
    SELECT title, count(actorid) AS actors FROM casting
    INNER JOIN movie ON casting.movieid = movie.id
    WHERE yr = 1978
    GROUP BY title
    ORDER BY actors DESC, title;

/* 15
List all the people who have worked with 'Art Garfunkel'.
*/
    --Step 1: Get list of all movieid for Art Garfunkel
        SELECT movieid FROM casting
        INNER JOIN actor ON casting.actorid = actor.id
        WHERE actor.name = 'Art Garfunkel'

    --Step 2: Get list of actors who aren't 'Art Garfunkel'
       SELECT name FROM actor
        INNER JOIN casting ON actor.id = casting.actorid
        WHERE actor.name!='Art Garfunkel'
    

    --Step 3: Join Step 1 and Two Together
            --Query for list of actors who share a movieid wtih Art Garfunkel
        SELECT name FROM actor
        INNER JOIN casting ON actor.id = casting.actorid
        WHERE actor.name!='Art Garfunkel' AND casting.movieid IN (
        SELECT movieid FROM casting
        INNER JOIN actor ON casting.actorid = actor.id
        WHERE actor.name = 'Art Garfunkel'
        )
/*
*/


/*
*/


/*
*/

/*
*/


/*
*/


/*
*/


/*
*/

/*
*/


/*
*/


/*
*/


/*
*/

