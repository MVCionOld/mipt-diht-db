/* LANGUAGE plpgsql */
SELECT DISTINCT 
    maker
    , price
FROM
    Printer 
JOIN
    Product
    ON
        Printer.model=Product.model
WHERE 1=1
    AND price=(
        SELECT 
            MIN(price)
        FROM
            Printer 
        WHERE 1=1
            AND color='y'
    ) 
    AND color='y'
