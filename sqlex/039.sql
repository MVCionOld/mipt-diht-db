/* LANGUAGE plpgsql */
WITH 
t1 AS (
    SELECT 
        ship
        , date
    FROM 
        Outcomes
        , Battles
    WHERE 1=1
        AND Outcomes.battle=Battles.name
        AND Outcomes.result='damaged'
)
, t2 AS (
    SELECT 
        ship
        , date
    FROM 
        Outcomes
        , Battles
    WHERE 1=1
        AND Outcomes.battle=Battles.name
)

SELECT DISTINCT 
    t2.ship
FROM 
    t1
    , t2
WHERE 1=1
    AND t1.ship=t2.ship 
    AND t1.date<t2.date
