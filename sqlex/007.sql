/* LANGUAGE plpgsql */
SELECT 
    Product.model
    , price
FROM 
    Product 
JOIN 
    PC
    ON 
        Product.model=PC.model
WHERE 1=1
    AND maker='B'
    
UNION

SELECT
    Product.model
    , price
FROM
    Product
JOIN 
    Laptop
    ON 
        Product.model=Laptop.model
WHERE 1=1
  AND maker='B'
  
UNION

SELECT 
    Product.model
    , price
FROM 
    Product 
JOIN 
    Printer
    ON 
        Product.model=Printer.model
WHERE 1=1
    AND maker='B'
