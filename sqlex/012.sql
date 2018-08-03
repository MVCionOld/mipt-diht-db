/* LANGUAGE plpgsql */
SELECT 
    AVG(speed)
FROM
    Laptop
WHERE 1=1
    AND price>1000
