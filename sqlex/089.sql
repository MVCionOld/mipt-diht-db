/* LANGUAGE plpgsql */
WITH S AS (SELECT COUNT(model) AS C
FROM Product
GROUP BY Maker)

SELECT Maker, COUNT(model)
FROM Product
GROUP BY Maker
HAVING COUNT(model) >= ALL (SELECT * FROM S)

UNION

SELECT Maker, COUNT(model)
FROM Product
GROUP BY Maker
HAVING COUNT(model) <= ALL (SELECT * FROM S)