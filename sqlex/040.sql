/* LANGUAGE plpgsql */
SELECT DISTINCT
    Ships.class
    , name
    , country
FROM 
    Classes 
JOIN 
    Ships
    ON 
        Classes.class=Ships.class
WHERE 
    numGuns>=10
