/* LANGUAGE plpgsql */
WITH Q AS (
    SELECT C.country, C.class, C.bore, (
          SELECT (COUNT(name)+
                 (SELECT COUNT(T.ship) 
                  FROM (SELECT DISTINCT ship 
                        FROM Outcomes 
                        WHERE ship = C.class AND ship NOT IN (SELECT name FROM Ships)) T )) cnt       
          FROM Ships 
          WHERE class = C.class) cnt
     FROM Classes C
)

SELECT DISTINCT 
    Q.country
    , CONVERT(NUMERIC(6,2), (SUM((Q.bore * Q.bore * Q.bore) * Q.cnt) / SUM(Q.cnt) / 2)) weight
FROM  
    Q
WHERE 1=1 
    AND Q.cnt>0
GROUP BY 
    Q.country
