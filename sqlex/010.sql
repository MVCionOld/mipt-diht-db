/* LANGUAGE plpgsql */
SELECT 
    model
    , price
FROM 
    Printer
WHERE 1=1 
    AND price=(
	    SELECT
	    	MAX(price)
	    FROM
	        Printer
    )
