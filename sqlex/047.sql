/* LANGUAGE plpgsql */
SELECT COUNT(*)ROWNUM, Z.MAKER,Z.model FROM
(SELECT P0.MAKER,A.CNT,P0.MODEL FROM PRODUCT P0
JOIN
(SELECT P1.MAKER,COUNT(*) CNT FROM PRODUCT P1 GROUP BY P1.MAKER) A
ON P0.MAKER=A.MAKER
) Z
JOIN
(SELECT P0.MAKER,A.CNT,P0.MODEL FROM PRODUCT P0
JOIN (SELECT P1.MAKER,COUNT(*) CNT FROM PRODUCT P1 GROUP BY
P1.MAKER)A
ON P0.MAKER=A.MAKER
)W
ON
(
(Z.CNT < W.CNT)OR
(Z.CNT = W.CNT)AND(Z.MAKER >W.MAKER)OR
(Z.CNT = W.CNT)AND(Z.MAKER=W.MAKER)AND(Z.MODEL >= W.MODEL)
)
GROUP BY Z.MAKER,Z.model
ORDER by ROWNUM,Z.MAKER,Z.model
