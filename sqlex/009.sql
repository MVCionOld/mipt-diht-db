/* LANGUAGE plpgsql */
SELECT DISTINCT 
    maker
FROM 
    Product 
JOIN 
    PC
    ON 
        Product.model = PC.model
WHERE 1=1
    AND speed>=450
