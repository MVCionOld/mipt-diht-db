/* LANGUAGE plpgsql */
SELECT DISTINCT 
    a.model
    , b.model
    , a.speed
    , a.RAM
FROM 
  pc AS a
  , pc AS b
WHERE 1=1
    AND a.ram=b.ram 
    AND a.speed=b.speed
    AND a.model>b.model
