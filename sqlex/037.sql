/* LANGUAGE plpgsql */
WITH 
t1 AS (
    SELECT 
        class
        , name
    FROM 
        Ships

    UNION ALL

    SELECT 
        Outcomes.ship
        , Outcomes.ship
    FROM 
        Outcomes
        , Classes
    WHERE 
        Outcomes.ship=Classes.class
)
, t2 AS (
    SELECT 
        * 
    FROM 
        t1
    GROUP BY
        class
        , name
)

SELECT 
    class 
FROM 
    t2
GROUP BY
    class
HAVING
    COUNT(1)=1 /* dirty hack))0) */
