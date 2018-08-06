/* LANGUAGE plpgsql */
SELECT 
    ship
FROM
    Outcomes
WHERE 1=1
    AND battle='North Atlantic'
    AND result='sunk'
