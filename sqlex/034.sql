/* LANGUAGE plpgsql */
SELECT 
    name
FROM 
    Ships
    , Classes 
WHERE 1=1
    Ships.class=Classes.class
    AND launched>=1922
    AND type = 'bb'
    AND displacement>35000
