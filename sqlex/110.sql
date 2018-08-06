/* LANGUAGE plpgsql */
SELECT (
    SELECT 
        name 
    FROM 
        Passenger 
    WHERE 
        ID_psg=T.ID_psg
) AS name
FROM (
    SELECT DISTINCT 
        ID_psg
    FROM 
        Pass_in_trip AS PIT
    JOIN Trip 
        ON 
            PIT.trip_no=Trip.trip_no
    WHERE 1=1
          AND Trip.time_out>Trip.time_in 
          AND DATENAME(weekday, date)='Saturday'
) AS T
