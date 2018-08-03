/* LANGUAGE plpgsql */
SELECT COUNT(*)
FROM (SELECT maker, COUNT(model) AS C
FROM Product
GROUP BY maker
HAVING COUNT(model) = 1) AS X