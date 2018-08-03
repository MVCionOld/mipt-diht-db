/* LANGUAGE plpgsql */
SELECT 
    AVG(speed)
FROM
    Product 
JOIN PC
    ON 
        Product.model=PC.model
WHERE 1=1
    AND maker='A'
