/* LANGUAGE plpgsql */
SELECT 
    model
    , speed
    , hd 
FROM pc
WHERE 1=1
    AND CD IN ('12x', '24X') 
    AND (price < 600)
