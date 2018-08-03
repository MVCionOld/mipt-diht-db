/* LANGUAGE plpgsql */
SELECT 
    maker
FROM 
    Product
WHERE 1=1 
    type='PC'
    
EXCEPT

SELECT 
    maker
FROM 
    Product
WHERE 1=1
    AND type='Laptop'
