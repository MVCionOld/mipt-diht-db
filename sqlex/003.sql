/* LANGUAGE plpgsql */
SELECT
    model
    , ram
    , screen 
FROM 
    laptop 
WHERE 1=1
    AND price>1000
