WITH NOTBLACK AS (SELECT B_Q_ID, 
SUM(CASE WHEN C = 'R' THEN B_VOL ELSE 0 END) AS R,
SUM(CASE WHEN C = 'G' THEN B_VOL ELSE 0 END) AS G,
SUM(CASE WHEN C = 'B' THEN B_VOL ELSE 0 END) AS B
FROM (SELECT *, (SELECT V_COLOR FROM utV WHERE V_ID = B_V_ID) AS C
FROM utB) AS T
GROUP BY B_Q_ID)

SELECT
255*((SELECT COUNT(*) FROM utQ) - (SELECT COUNT(*) FROM NOTBLACK)) + SUM(255 - R) AS R,
255*((SELECT COUNT(*) FROM utQ) - (SELECT COUNT(*) FROM NOTBLACK)) +  SUM(255 - G) AS G,
255*((SELECT COUNT(*) FROM utQ) - (SELECT COUNT(*) FROM NOTBLACK)) + SUM(255 - B) AS B
FROM NOTBLACK