/* LANGUAGE plpgsql */
SELECT DISTINCT
    maker
FROM 
    Product
WHERE 1=1
    AND model IN (
        SELECT 
            model
        FROM 
            PC
        WHERE 1=1
            AND ram=(
                SELECT 
                    MIN(ram)
                FROM 
                    PC
            )
            AND speed=(
                SELECT 
                    MAX(speed)
                FROM 
                    PC
                WHERE 1=1
                    AND ram=(
                       SELECT 
                            MIN(ram)
                       FROM 
                            PC
                    )
              )
        )
    AND maker IN (
        SELECT 
            maker
        FROM 
            Product
        WHERE 1=1 
            AND type='printer'
    )
