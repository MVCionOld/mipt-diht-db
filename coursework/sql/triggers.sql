/* #1 ******************************************************************************************************** #1 */


DROP TRIGGER IF EXISTS add_rental
ON RENTAL;


CREATE OR REPLACE FUNCTION rental_update()
  RETURNS TRIGGER AS
$BODY$
BEGIN
  /*
    Работник автоматически становится клиетом, если он
    (работник) воспользуется услугами компании, т.е. он
    вносится в таблицу CLIENT_PARTICIPANT
   */
  IF (
    NEW.participant_id NOT IN (
      SELECT CLIENT_PARTICIPANT.participant_id
      FROM
        CLIENT_PARTICIPANT
    )
  )
  THEN
    INSERT INTO CLIENT_PARTICIPANT (participant_id)
    VALUES
      (NEW.participant_id);
  END IF;
  /*
    Увеличиваем кол-во выездов клиентов
   */
  UPDATE
    CLIENT_PARTICIPANT
  SET
    departures_cnt = departures_cnt + 1
  WHERE
    participant_id = NEW.participant_id;
  /*
    Увеличиваем кол-во выездов тр. средства
   */
  UPDATE
    VEHICLE
  SET
    departures_cnt = departures_cnt + 1
  WHERE
    vehicle_id = NEW.vehicle_id;
  /*
    Обновляем таблицу связей PARTICIPANT_X_RENTAL
   */
  INSERT INTO PARTICIPANT_X_RENTAL
  VALUES
    (NEW.participant_id, NEW.rental_id);
  /*
    Обновляем таблицу связей PARTICIPANT_X_VEHICLE
   */
  INSERT INTO PARTICIPANT_X_VEHICLE
  VALUES
    (NEW.participant_id, NEW.vehicle_id);
  RETURN NULL;
END;
$BODY$
LANGUAGE plpgsql;


CREATE TRIGGER add_rental
  AFTER INSERT
  ON
    RENTAL
  FOR EACH ROW EXECUTE PROCEDURE rental_update();


INSERT INTO RENTAL (participant_id, vehicle_id, cost_amt, reservation_dttm, return_dttm, distance_amt, gasoline_amt)
VALUES
  (4, 2, 102.5, '2004-10-19 10:23:54', '2004-10-21 08:00:00', 423.1, 34.0)
  , (9, 5, 23.7, '2004-10-21 09:00:00', '2004-10-21 16:57:05', 120.5, 5.2)
  , (1, 8, 3220.0, '2004-12-01 00:00:00', '2004-12-10 00:00:00', 1384.0, 263.8)
  , (1, 8, 5715.1, '2004-12-15 00:00:00', '2004-12-31 20:20:00', 2078.0, 450.4)
  , (2, 1, 2005.3, '2005-10-19 10:23:54', '2005-11-11 08:00:00', 523.2, 134.0)
  , (4, 2, 102.5, '2005-10-19 10:23:54', '2005-10-21 08:00:00', 423.1, 34.0)
  , (9, 5, 23.7, '2005-10-21 09:00:00', '2005-10-21 16:57:05', 120.5, 5.2)
  , (1, 8, 3220.0, '2005-12-01 00:00:00', '2005-12-10 00:00:00', 1384.0, 263.8)
  , (1, 8, 5715.1, '2005-12-15 00:00:00', '2005-12-31 20:20:00', 2078.0, 450.4)
  , (2, 1, 2005.3, '2005-10-19 10:23:54', '2005-11-11 08:00:00', 523.2, 134.0);


/* #2 ******************************************************************************************************** #2 */


/*
  Вспомогательная хранимая процедура, чтобы по номеру
  аренды узнавать номер используемого транспортного средства
 */
DROP FUNCTION IF EXISTS get_vehicle(integer);
CREATE OR REPLACE FUNCTION get_vehicle(rent int)
  RETURNS int AS
$BODY$
DECLARE
  id int;
BEGIN
  SELECT DISTINCT
    RENTAL.vehicle_id
  INTO
    id
  FROM
    RENTAL
  WHERE
    RENTAL.rental_id = rent;
  RETURN id;
END;
$BODY$
LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS add_rental_x_location
ON RENTAL_X_LOCATION;


CREATE OR REPLACE FUNCTION rental_x_location_update()
  RETURNS TRIGGER AS
$BODY$
BEGIN
  INSERT INTO VEHICLE_X_LOCATION
  VALUES
    (get_vehicle(NEW.rental_id), NEW.location_id);
  RETURN NULL;
END;
$BODY$
LANGUAGE plpgsql;


CREATE TRIGGER add_rental_x_location
  AFTER INSERT
  ON
    RENTAL_X_LOCATION
  FOR EACH ROW EXECUTE PROCEDURE rental_x_location_update();


INSERT INTO RENTAL_X_LOCATION(rental_id, location_id, checking_dttm)
VALUES
  (1, 9, '2004-10-21 08:00:00')
  , (2, 10, '2004-10-21 08:00:00')
  , (3, 10, '2004-10-21 08:00:00')
  , (4, 10, '2004-10-21 08:00:00')
  , (5, 10, '2004-10-21 08:00:00')
  , (6, 10, '2004-10-21 08:00:00')
  , (7, 10, '2004-10-21 08:00:00')
  , (8, 10, '2004-10-21 08:00:00')
  , (9, 10, '2004-10-21 08:00:00')
  , (10, 10, '2004-10-21 08:00:00')
  , (1, 9, '2004-10-21 08:00:00')
  , (1, 9, '2004-10-21 08:00:00');
