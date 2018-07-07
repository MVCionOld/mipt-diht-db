/*
  Простое представление
  Общая информация о партнёрах компании
 */
CREATE OR REPLACE VIEW VIEW_PARTNER AS (
  SELECT
    P.partner_nm AS partner_nm
  , CASE
      WHEN P.specialization_code = 1 THEN
        'gas station'
      WHEN P.specialization_code = 2 THEN
        'electric station'
      WHEN P.specialization_code = 3 THEN
        'car wash'
      ELSE
        NULL
    END AS partner_specialization
  FROM
    PARTNER P
  WHERE
    P.specialization_code != 0
);


/*
  Простое представление
  Общая информация из таблицы LOCATION
 */
CREATE OR REPLACE VIEW VIEW_LOCATION AS (
  SELECT
    L.address_txt
    , L.city_nm
    , L.state_mn
    , L.latitude
    , L.longitude
    , CASE
        WHEN L.type_code = 1 THEN
          'gas station'
        WHEN L.type_code = 2 THEN
          'electric station'
        WHEN L.type_code = 3 THEN
          'car wash'
        WHEN L.type_code = 4 THEN
          'garages'
        WHEN L.type_code = 5 THEN
          'service station'
        ELSE
          NULL
      END AS location_type
  FROM
    LOCATION L
);


/*
  Сложное представление (с джойном)
  Для каждого объекта из таблицы LOCATION дать полную информацию
 */
CREATE OR REPLACE VIEW VIEW_PARTNER_LOCATION AS (
  SELECT
    L.address_txt
    , L.city_nm
    , L.state_mn
    , L.latitude
    , L.longitude
    , P.partner_nm
    , CASE
        WHEN L.type_code = 1 THEN
          'gas station'
        WHEN L.type_code = 2 THEN
          'electric station'
        WHEN L.type_code = 3 THEN
          'car wash'
        WHEN L.type_code = 4 THEN
          'garages'
        WHEN L.type_code = 5 THEN
          'service station'
        ELSE
          NULL
      END AS location_type
  FROM
    LOCATION L
  INNER JOIN
    PARTNER P
    ON
      L.partner_id = P.patrner_id
);


/*
  Простое представление
  Общая информация об имеющихся тр. средствах
 */
DROP VIEW IF EXISTS VIEW_VEHICLE;
CREATE OR REPLACE VIEW VIEW_VEHICLE AS (
  SELECT
    V.make_nm
    , V.model_nm
    , substring(V.registration_plate_no, 1, 1) || '***' || substring(V.registration_plate_no, 5)
      AS registration_plate_no
    , CASE
        WHEN V.transmission_code = 1 THEN
          'manual'
        WHEN V.transmission_code = 2 THEN
          'semi-automatic'
        WHEN V.transmission_code = 3 THEN
          'automatic'
      END AS transmission
    , CASE
        WHEN V.electric_flg THEN
          'electric'
        ELSE
          'gasoline'
      END AS engine_type
  FROM
    VEHICLE V
);


/*
  Простое представление (с джойном)
  Полная информация о выполненых заказах
  автомобилями только с бензиновыми двигателями
  (без информация о самих клиентах)
 */
DROP VIEW IF EXISTS VIEW_VEHICLE_RENTAL;
CREATE OR REPLACE VIEW VIEW_VEHICLE_RENTAL AS (
  SELECT
    V.make_nm
    , V.model_nm
    , substring(V.registration_plate_no, 1, 1) || '***' || substring(V.registration_plate_no, 5)
      AS registration_plate_no
    , R.reservation_dttm
    , R.return_dttm
    , R.distance_amt
  FROM
    VEHICLE V
  INNER JOIN
    RENTAL R
    ON
      V.vehicle_id = R.vehicle_id
  WHERE
    NOT V.electric_flg
);


/*
  Сложное представление (с джойном)
  Полная информация о выполненых заказах
  автомобилями только с бензиновыми двигателями
  (в т.ч. и информация о самих клиентах)
 */
DROP VIEW IF EXISTS VIEW_CLIENT_VEHICLE_RENTAL;
CREATE OR REPLACE VIEW VIEW_CLIENT_VEHICLE_RENTAL AS (
  SELECT
    C_R.first_nm
    , C_R.last_nm
    , C_R.phone_no
    , V.make_nm
    , V.model_nm
    , substring(V.registration_plate_no, 1, 1) || '***' || substring(V.registration_plate_no, 5)
      AS registration_plate_no
    , C_R.reservation_dttm
    , C_R.return_dttm
    , C_R.distance_amt
  FROM
    VEHICLE V
  INNER JOIN (
    SELECT
      R.reservation_dttm
      , R.return_dttm
      , R.distance_amt
      , R.vehicle_id
      , P.first_nm
      , P.last_nm
      , P.phone_no
    FROM
      RENTAL R
    INNER JOIN
      PARTICIPANT P
      ON
        P.participant_id = R.participant_id
  ) AS C_R
    ON
      V.vehicle_id = C_R.vehicle_id
);


/*
  Сложное представление
  O всех клиентах, и о всех работниках
*/
DROP VIEW IF EXISTS VIEW_PARTICIPANT;
CREATE OR REPLACE VIEW VIEW_PARTICIPANT AS (

  WITH CLIENT_EMPLOYEE AS (
    SELECT
      CLIENT_PARTICIPANT.participant_id
    FROM
      CLIENT_PARTICIPANT
    INTERSECT
    SELECT
      EMPLOYEE_PARTICIPANT.participant_id
    FROM
      EMPLOYEE_PARTICIPANT
  )

  SELECT
    PARTICIPANT.first_nm
    , PARTICIPANT.middle_nm
    , PARTICIPANT.last_nm
    , CASE
        WHEN PARTICIPANT.gender_code = 1
          THEN
            'female'
        ELSE
          'male'
      END AS gender
    , CASE
        WHEN PARTICIPANT.participant_id IN (
          SELECT
            CLIENT_EMPLOYEE.participant_id
          FROM
            CLIENT_EMPLOYEE
          ) THEN
            'client & employee'
        WHEN PARTICIPANT.participant_type_code = 1
          THEN
            'employee'
        ELSE
          'client'
        END AS status
  FROM
    PARTICIPANT
  INNER JOIN
    CLIENT_PARTICIPANT
    ON
      PARTICIPANT.participant_id = CLIENT_PARTICIPANT.participant_id

  UNION

  SELECT
    PARTICIPANT.first_nm
    , PARTICIPANT.middle_nm
    , PARTICIPANT.last_nm
    , CASE
        WHEN PARTICIPANT.gender_code = 1
          THEN
            'female'
        ELSE
          'male'
      END AS gender
    , CASE
        WHEN PARTICIPANT.participant_id IN (
          SELECT
            CLIENT_EMPLOYEE.participant_id
          FROM
            CLIENT_EMPLOYEE
          ) THEN
            'client & employee'
        WHEN PARTICIPANT.participant_type_code = 1
          THEN
            'employee'
        ELSE
          'client'
        END AS status
  FROM
    PARTICIPANT
  INNER JOIN
    EMPLOYEE_PARTICIPANT
    ON
      PARTICIPANT.participant_id = EMPLOYEE_PARTICIPANT.participant_id
)
