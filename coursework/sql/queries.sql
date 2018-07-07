/*
  1
  Для каждого автомобиля найти среднее значение
  преодолённых километров, потраченного топлива, заработок
  для всех заказов, а также общее количество выполненых заказов
 */
SELECT
  V.make_nm || ' ' || V.model_nm AS car
  , avg(R.distance_amt)          AS average_dist
  , avg(R.gasoline_amt)          AS average_gasoline
  , avg(R.cost_amt)              AS average_cost
  , V.departures_cnt
FROM
  VEHICLE V
INNER JOIN
  RENTAL R
  ON
    V.vehicle_id = R.vehicle_id
GROUP BY
  V.vehicle_id
HAVING (V.departures_cnt > 0);

/*
  2
  Найти всех клиентов, которые использовали ТОЛЬКО электромобили в Москве.
 */
WITH
  MOSCOW_RENTAL AS (
    SELECT DISTINCT
      RENTAL_X_LOCATION.rental_id
    FROM
      RENTAL_X_LOCATION
    WHERE
      RENTAL_X_LOCATION.location_id IN (
        SELECT
          LOCATION.location_id
        FROM
          LOCATION
        WHERE
          LOCATION.city_nm = 'Moscow'
      )
  )
SELECT
  P.first_nm
  , P.last_nm
FROM
  PARTICIPANT P
INNER JOIN (
  SELECT R.participant_id
  FROM
    RENTAL R
    INNER JOIN
    MOSCOW_RENTAL M_R
      ON
        R.rental_id = M_R.rental_id
  EXCEPT
  SELECT R.participant_id
  FROM
    RENTAL R
    INNER JOIN
    MOSCOW_RENTAL M_R
      ON
        R.rental_id = M_R.rental_id
  WHERE
    R.vehicle_id IN (
      SELECT V.vehicle_id
      FROM
        VEHICLE V
      WHERE
        NOT V.electric_flg
    )
  ) P_ID
  ON
    P.participant_id = P_ID.participant_id
WHERE
  P.participant_type_code = 2;

/*
  3
  Найти суммарную стоимость и преодолённое расстояние на
  электромобилях за всё время. Вывести аналогичные данные
  для автомобилей с бензиновыми двигателями.
 */
WITH
  ELECTRO_RENTAL AS (
    SELECT
      RENTAL.*
    FROM
      RENTAL
      INNER JOIN
      VEHICLE
        ON
          VEHICLE.vehicle_id = RENTAL.rental_id
    WHERE
      VEHICLE.electric_flg
  )
  , GASOLINE_RENTAL AS (
    SELECT
      RENTAL.*
    FROM
      RENTAL
    EXCEPT
    SELECT
      ELECTRO_RENTAL.*
    FROM
      ELECTRO_RENTAL
  )
SELECT
  sum(ELECTRO_RENTAL.cost_amt)        AS electro_cost
  , sum(ELECTRO_RENTAL.distance_amt)  AS electro_dist
  , sum(GASOLINE_RENTAL.cost_amt)     AS gasoline_cost
  , sum(GASOLINE_RENTAL.distance_amt) AS gasoline_dist
FROM
  ELECTRO_RENTAL
  , GASOLINE_RENTAL;

/*
  4
  Вывести всех мужчин-клиентов, которые пользовались
  автомобилями с ручной коробкой передач более одного раза
 */
SELECT
  PARTICIPANT.first_nm
  , PARTICIPANT.last_nm
FROM
  PARTICIPANT
WHERE 1 = 1
  AND PARTICIPANT.gender_code = 2
  AND (
    SELECT
      count(*)
    FROM
      RENTAL
      INNER JOIN
      VEHICLE
        ON
          VEHICLE.vehicle_id = RENTAL.vehicle_id
    WHERE 1 = 1
      AND RENTAL.participant_id = PARTICIPANT.participant_id
      AND VEHICLE.vehicle_id IN (
        SELECT
          V.vehicle_id
        FROM
          VEHICLE V
        WHERE
          V.electric_flg
      )
  ) > 1;

/*
  5
  Найти наиболее популярный тип коробки передач
 */
WITH TRANSMISSION AS (
  SELECT
    count(R.*) cnt
    , V.transmission_code
  FROM
    VEHICLE V
  INNER JOIN
    RENTAL R
  ON V.vehicle_id = R.vehicle_id
  GROUP BY
    V.transmission_code
)
SELECT
  CASE
    WHEN TRANSMISSION.transmission_code = 1 THEN
      'manual transmission'
    WHEN TRANSMISSION.transmission_code = 2 THEN
      'semi-automatic transmission'
    WHEN TRANSMISSION.transmission_code = 3 THEN
      'automatic transmission'
    ELSE
      NULL
  END AS transmission_type
FROM
  TRANSMISSION
ORDER BY
  TRANSMISSION.cnt
DESC
LIMIT 1;
