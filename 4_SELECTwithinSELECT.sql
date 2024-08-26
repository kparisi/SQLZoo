/*
SELECT within SELECT Tutorial
Language:	English  • 日本語 • 中文
This tutorial looks at how we can use SELECT statements within SELECT statements to perform more complex queries.

name	        continent	area	population	gdp
Afghanistan	    Asia	    652230	25500100	20343000000
Albania	        Europe	    28748	2831741	12960000000
Algeria	        Africa	    2381741	37100000	188681000000
Andorra	        Europe	    468	    78115	    3712000000
Angola	        Africa	    1246700	20609294	100990000000
...
 */


/* 1.
List each country name where the population is larger than that of 'Russia'.
world(name, continent, area, population, gdp)*/

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')


/*2.
Show the countries in Europe with a per capita GDP greater than 'United Kingdom'. */

SELECT name FROM world
WHERE continent ='Europe' AND gdp/population >(
SELECT gdp/population FROM world WHERE name = 'United Kingdom'
)


/*3.

List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country. */

SELECT name, continent FROM world
WHERE continent = (SELECT continent FROM world WHERE name = 'Australia')
OR continent = ( SELECT continent FROM world WHERE name ='Argentina') 
ORDER BY name ASC

/*4.
Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

 */
SELECT name, population FROM world
WHERE population  > (SELECT population FROM world WHERE name ='United Kingdom') AND population < (SELECT population FROM world WHERE name='Germany')



/* */


/* */


/* */


/* */


/* */


/* */


/* */


/* */


/* */


/* */


/* */


/* */


/* */


/* */


/* */
