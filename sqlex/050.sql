/* LANGUAGE plpgsql */
SELECT DISTINCT
    Battles.name
FROM (
    Battles 
    JOIN 
        Outcomes 
        ON 
            name=battle
) 
JOIN
    Ships 
    ON 
        ship=ships.name
WHERE 1=1
    AND class='Kongo'
