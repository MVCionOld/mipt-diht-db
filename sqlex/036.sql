/* LANGUAGE plpgsql */
SELECT DISTINCT 
    ship
FROM 
    Outcomes 
JOIN 
    Classes 
    ON 
      Classes.class=Outcomes.ship
      
UNION

SELECT DISTINCT 
    Ships.name
FROM 
    Ships 
JOIN 
    Classes 
    ON 
      Classes.class=Ships.name
