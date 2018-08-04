/* LANGUAGE plpgsql */
SELECT 
	AVG(price)
FROM (
	SELECT 
		price
	FROM 	
		PC 
	INNER JOIN 
		Product 
		ON 
			PC.model=Product.model
	WHERE 1=1
		AND maker='A'
	
	UNION ALL
	
	SELECT 
		price
	FROM 
		Laptop 
	INNER JOIN 
		Product 
		ON 
			Laptop.model=Product.model
	WHERE 1=1
		AND maker = 'A'
) AS pr
