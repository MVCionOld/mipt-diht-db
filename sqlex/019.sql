/* LANGUAGE plpgsql */
SELECT 
    maker
    , AVG(screen) AS 'Average Screen'
FROM 
    Product 
JOIN 
    Laptop
    ON 
        Product.model=Laptop.model
WHERE 1=1
    AND Laptop.model IN (
        SELECT 
            model 
        FROM 
            Product 
        WHERE 1=1
            AND type='Laptop'
    )
GROUP BY
    maker
