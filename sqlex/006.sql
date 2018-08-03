/* LANGUAGE plpgsql */
SELECT DISTINCT 
    maker
    , speed
FROM 
    Laptop 
JOIN 
    Product
ON 
    Laptop.model=Product.model
WHERE 
    hd>=10
