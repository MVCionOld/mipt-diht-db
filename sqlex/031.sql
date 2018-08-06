/* LANGUAGE plpgsql */
SELECT 
    class
    , country
FROM
    Classes
WHERE 1=1
    AND bore>=16
