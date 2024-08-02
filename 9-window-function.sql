/* WINDOW FUNCTIONS
General Elections were held in the UK in 2015 and 2017. Every citizen votes in a constituency. The candidate who gains the most votes becomes MP for that constituency.

All these results are recorded in a table ge


yr	    firstName	lastName	constituency	        party	votes
2015	Ian	Murray          	            S14000024	Labour	                    19293
2015	Neil	                Hay	        S14000024	Scottish National Party	    16656
2015	Miles	                Briggs	    S14000024	Conservative	            8626
2015	Phyl	                Meyer	    S14000024	Green	                    2090
2015	Pramod	                Subbaraman	S14000024	Liberal Democrat	        1823
2015	Paul	                Marshall	S14000024	UK Independence Party	    601
2015	Colin	                Fox	        S14000024	Scottish Socialist Party	197
2017	Ian	                    MURRAY	    S14000024	Labour	                    26269
2017	Jim	                    EADIE	    S14000024	SNP	                        10755
2017	Stephanie Jane  Harley	SMITH	    S14000024	Conservative	            9428
2017	Alan Christopher	    BEAL	    S14000024	Liberal Democrats	        1388

*/


/* 1
Show the lastName, party and votes 
for the constituency 'S14000024' in 2017.
*/
SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC



/* 2
You can use the RANK function to see the order of the candidates. 
If you RANK using (ORDER BY votes DESC) then the candidate 
with the most votes has rank 1.

Show the party and RANK for constituency S14000024 in 2017. 
List the output by party
*/

SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party



/* 3
The 2015 election is a different PARTITION to the 2017 election. We only care about the order of votes for each year.

Use PARTITION to show the ranking of each party in S14000021 in each year. Include yr, party, votes and ranking (the party with the most votes is 1).
*/
SELECT yr,party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000021'
ORDER BY party,yr




/* 4
Edinburgh constituencies are numbered S14000021 to S14000026.

Use PARTITION BY constituency to show the ranking of each party in Edinburgh in 2017. 
Order your results so the winners are shown first, then ordered by constituency.
*/

SELECT constituency, party, SUM(votes), RANK() OVER (PARTITION by constituency
ORDER BY SUM(votes) DESC) AS winner
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
AND yr=2017
GROUP BY party, constituency
ORDER BY winner, constituency

/* 5
5.
You can use SELECT within SELECT to pick out only the winners in Edinburgh.

Show the parties that won for each Edinburgh constituency in 2017.
*/

SELECT constituency, party
FROM ge x
WHERE votes >= (
  SELECT MAX(votes)
  FROM ge y
WHERE x.constituency = y.constituency
AND yr=2017
)
AND yr=2017
AND constituency BETWEEN 'S14000021' AND 'S14000026'


/* 6
You can use COUNT and GROUP BY to see how each party did in Scotland. Scottish constituencies start with 'S'
Show how many seats for each party in Scotland in 2017.
*/

SELECT party, count(*)
FROM ge x
WHERE constituency LIKE 'S%'
AND yr=2017
AND votes >=(
  SELECT MAX(votes)
  FROM ge year
  WHERE y.constituency = x.constituency
  AND yr = 2017)
GROUP BY party
