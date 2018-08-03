/* LANGUAGE plpgsql */
SELECT DISTINCT 
	Product.type
	, Laptop.model
	, Laptop.speed
FROM 
	Laptop
	, PC
	, Product
WHERE 1=1
	AND Product.type='Laptop'
	AND Laptop.speed<ALL(
		SELECT 
			speed
		FROM 
			PC
	)
