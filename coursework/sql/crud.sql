/*

  ОСНОВНАЯ ЧАСТЬ ЗАДАНИЯ ПО CRUD-ЗАПРОСАМ
  СОВМЕЩЕНА С ЗАДАНИЕМ №9 (ТРИГГЕРЫ, triggers.sql)

 */


/*
  Пример: скрипт для удаления всех электромобилей из базы
 (удаление вынесено отдельно, т.к. триггеры уже реализуют операции UPDATE, INSERT)
 */

DELETE FROM
  PARTICIPANT_X_VEHICLE
WHERE
  PARTICIPANT_X_VEHICLE.vehicle_id IN (
    SELECT
      VEHICLE.vehicle_id
    FROM
      VEHICLE
    WHERE
      VEHICLE.electric_flg
  );

DELETE FROM
  VEHICLE_X_LOCATION
WHERE
  VEHICLE_X_LOCATION.vehicle_id IN (
    SELECT
      VEHICLE.vehicle_id
    FROM
      VEHICLE
    WHERE
      VEHICLE.electric_flg
  );

DELETE FROM
  PARTICIPANT_X_RENTAL
WHERE
  PARTICIPANT_X_RENTAL.rental_id IN (
    SELECT
      RENTAL.rental_id
    FROM
      RENTAL
    INNER JOIN
      VEHICLE
      ON
        VEHICLE.vehicle_id = RENTAL.vehicle_id
    WHERE
      VEHICLE.electric_flg
  );

DELETE FROM
  RENTAL_X_LOCATION
WHERE
  RENTAL_X_LOCATION.rental_id IN (
    SELECT
      RENTAL.rental_id
    FROM
      RENTAL
    INNER JOIN
      VEHICLE
      ON
        RENTAL.vehicle_id = VEHICLE.vehicle_id
    WHERE
      VEHICLE.electric_flg
  );

DELETE FROM
  RENTAL
WHERE
  RENTAL.vehicle_id IN (
    SELECT
      VEHICLE.vehicle_id
    FROM
      VEHICLE
    WHERE
      VEHICLE.electric_flg
  );

DELETE FROM
  VEHICLE
WHERE
  VEHICLE.electric_flg;
