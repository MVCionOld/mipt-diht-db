/* LANGUAGE plpgsql */
SELECT
    model
    , ram
    , screen 
FROM 
    Laptop 
WHERE 1=1
    AND price>1000
