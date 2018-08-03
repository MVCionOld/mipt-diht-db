/* LANGUAGE plpgsql */
SELECT 
  maker
  , COUNT(model) AS Count_Model
FROM 
  Product
WHERE 1=1
  AND type='PC'
GROUP BY 
  maker
HAVING 
  COUNT(model)>=3
