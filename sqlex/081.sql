/* LANGUAGE plpgsql */
/* var. 1: WITH INNER JOIN */
SELECT code, point, date, out
FROM(SELECT CONVERT(CHAR(7), O.date, 120) AS month
FROM Outcome AS O
GROUP BY CONVERT(CHAR(7), O.date, 120)
HAVING (SELECT SUM(out) FROM Outcome WHERE CONVERT(CHAR(7), O.date, 120) = CONVERT(CHAR(7), date, 120)) >= ALL (SELECT SUM(out) FROM Outcome GROUP BY CONVERT(CHAR(7), date, 120))) AS mos INNER JOIN Outcome ON mos.month = CONVERT(CHAR(7), date, 120) 

/* var. 2: WITH WHERE 
SELECT *
FROM Outcome
WHERE CONVERT(CHAR(7), date, 120) IN (SELECT CONVERT(CHAR(7), O.date, 120) AS month
FROM Outcome AS O
GROUP BY CONVERT(CHAR(7), O.date, 120)
HAVING (SELECT SUM(out) FROM Outcome WHERE CONVERT(CHAR(7), O.date, 120) = CONVERT(CHAR(7), date, 120)) >= ALL (SELECT SUM(out) FROM Outcome GROUP BY CONVERT(CHAR(7), date, 120)))
*/