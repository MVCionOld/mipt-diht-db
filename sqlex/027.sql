/* LANGUAGE plpgsql */
SELECT 
    maker
    , AVG(hd) AS Avg_hd
FROM 
    PC 
INNER JOIN 
    Product 
    ON 
        PC.model=Product.model
GROUP BY 
    maker
HAVING 
    maker IN (
        SELECT 
            maker 
        FROM 
            Product 
        WHERE 1=1
            AND type='printer'
    )
