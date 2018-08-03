/* LANGUAGE plpgsql */
SELECT DISTINCT
    maker 
FROM 
    Product 
WHERE 
    type = 'printer'
