/* LANGUAGE plpgsql */
SELECT DISTINCT
    maker 
FROM 
    Product 
WHERE 1=1
    AND type='printer'
