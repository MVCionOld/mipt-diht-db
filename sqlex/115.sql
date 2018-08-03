/* LANGUAGE plpgsql */
SELECT Up, Down, Side, CAST(SQRT(Side*Side - (Down-Up)*(Down-Up)/4)/2 AS NUMERIC(10, 2)) AS Rad
FROM (SELECT DISTINCT CAST(B_VOL AS int) AS Up FROM utB) AS A
INNER JOIN (SELECT DISTINCT CAST(B_VOL AS int) AS Down FROM utB) AS B ON Up < Down,
(SELECT DISTINCT CAST(B_VOL AS int) AS Side FROM utB) AS C
WHERE Up + Down = 2*Side