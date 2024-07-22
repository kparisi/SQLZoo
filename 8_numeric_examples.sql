/* Numeric Example

Field	                Type
ukprn	                varchar(8)
institution	            varchar(100)
subject	                varchar(60)
level	                varchar(50)
question	            varchar(10)
A_STRONGLY_DISAGREE	    int(11)
A_DISAGREE	            int(11)
A_NEUTRAL	            int(11)
A_AGREE	                int(11)
A_STRONGLY_AGREE	    int(11)
A_NA	                int(11)
CI_MIN	                int(11)
score	                int(11)
CI_MAX	                int(11)
response	            int(11)
sample	                int(11)
aggregate	            char(1)
National Student Survey 2012

The National Student Survey http://www.thestudentsurvey.com/ is presented to thousands of graduating students in UK Higher Education. The survey asks 22 questions, students can respond with STRONGLY DISAGREE, DISAGREE, NEUTRAL, AGREE or STRONGLY AGREE. The values in these columns represent PERCENTAGES of the total students who responded with that answer.

The table nss has one row per institution, subject and question.
*/

/* 1
Show the the percentage who STRONGLY AGREE
*/

SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science'




/* 2
Show the institution and subject 
where the score is at least 100 for question 15.
*/
SELECT institution, subject
  FROM nss
 WHERE question='Q15'
   AND score >=100


/* 3
Show the institution and score where the score for 
'(8) Computer Science' is less than 50 for question 'Q15'
*/

SELECT institution,score
  FROM nss
 WHERE question='Q15'
   AND score < 50
   AND subject='(8) Computer Science'

/* 4
Show the subject and total number of students 
who responded to question 22 for each of the subjects 
'(8) Computer Science' and '(H) Creative Arts and Design'.
*/

SELECT subject, SUM(response)
    FROM nss
    WHERE question='Q22' AND 
    subject IN ('(8) Computer Science','(H) Creative Arts and Design')
GROUP BY subject


/* 5
Show the subject and total number of students who A_STRONGLY_AGREE 
to question 22 for each of the subjects '(8) Computer Science' and 
'(H) Creative Arts and Design'.
*/

SELECT subject, SUM(response*A_STRONGLY_AGREE/100)
    FROM nss
    WHERE question='Q22' AND
    subject IN ('(8) Computer Science','(H) Creative Arts and Design')
    GROUP BY subject

/* 6
Show the percentage of students who 
A_STRONGLY_AGREE to question 22 for the subject 
'(8) Computer Science' show the same figure for the 
subject '(H) Creative Arts and Design'.

Use the ROUND function to show the percentage without 
decimal places.
*/

-- The question is confusing, because the integer in the A_ columns represents a percentage already. We are actually looking for a weighted average, not a percent.

SELECT subject, ROUND(SUM(response*A_STRONGLY_AGREE)/SUM(response)) -- (response*A_STRONGLY_AGREE) = the number of Students who Strongly Agree. SUM(response) = the total number of students. ROUND(SUM(response*A_STRONGLY_AGREE)/SUM(response)) gives a weighted average.
    FROM nss
    WHERE question='Q22' AND
    subject IN ('(8) Computer Science','(H) Creative Arts and Design')
    GROUP BY subject


/* 7
Show the average scores for question 'Q22' 
for each institution that include 'Manchester' in the name.

The column score is a percentage - you must use the method 
outlined above to multiply the percentage by the response and 
divide by the total response. 
Give your answer rounded to the nearest whole number.
*/
--avg scores = sum of all scores / count of all scores

SELECT institution, 
ROUND(SUM(score * response)/SUM(response),0) AS score
  FROM nss
 WHERE question='Q22'
   AND (institution LIKE '%Manchester%')
GROUP BY institution
ORDER BY institution



/* 8
Show the institution, the total sample size 
and the number of computing students 
for institutions in Manchester for 'Q01'.
*/

SELECT institution,SUM(sample), sum(CASE WHEN subject='(8) Computer Science' then sample else 0 END)
  FROM nss
 WHERE question='Q01'
   AND (institution LIKE '%Manchester%')
GROUP BY institution 
