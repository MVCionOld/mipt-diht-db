DROP TABLE IF EXISTS RENTAL_X_LOCATION CASCADE;
DROP TABLE IF EXISTS PARTICIPANT_X_RENTAL CASCADE;
DROP TABLE IF EXISTS RENTAL CASCADE;
DROP TABLE IF EXISTS VEHICLE_X_LOCATION CASCADE;
DROP TABLE IF EXISTS LOCATION CASCADE;
DROP TABLE IF EXISTS PARTNER CASCADE;
DROP TABLE IF EXISTS PARTICIPANT_X_VEHICLE CASCADE;
DROP TABLE IF EXISTS VEHICLE CASCADE;
DROP TABLE IF EXISTS EMPLOYEE_PARTICIPANT CASCADE;
DROP TABLE IF EXISTS CLIENT_PARTICIPANT CASCADE;
DROP TABLE IF EXISTS PARTICIPANT CASCADE;

CREATE TABLE IF NOT EXISTS PARTICIPANT (
  participant_id         serial PRIMARY KEY
  ,participant_type_code int         NOT NULL
  ,first_nm              varchar(30) NOT NULL
  ,middle_nm             varchar(30)
  ,last_nm               varchar(30) NOT NULL
  ,gender_code           int
  ,email_txt             varchar(50) CHECK (email_txt ~ '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
  ,phone_no              varchar(50) CHECK (phone_no ~ '^(\s*)?(\+)?([-():=+]?\d[-():=+]?){10,14}(\s*)?$')
);
CREATE TABLE IF NOT EXISTS CLIENT_PARTICIPANT (
  participant_id  int PRIMARY KEY REFERENCES PARTICIPANT (participant_id)
  ,penalties_cnt  int NOT NULL DEFAULT 0 CHECK (penalties_cnt >= 0)
  ,departures_cnt int NOT NULL DEFAULT 0 CHECK (departures_cnt >= 0)
);
CREATE TABLE IF NOT EXISTS EMPLOYEE_PARTICIPANT (
  participant_id  int PRIMARY KEY REFERENCES PARTICIPANT (participant_id)
  ,contract_no    varchar(20) NOT NULL UNIQUE
  ,insurance_no   varchar(20) NOT NULL UNIQUE
  ,salary_amt     real        NOT NULL DEFAULT 0.0 CHECK (salary_amt >= 0.0)
  ,position_code  int         NOT NULL
);
CREATE TABLE IF NOT EXISTS VEHICLE (
  vehicle_id             serial PRIMARY KEY
  ,registration_plate_no varchar(20) NOT NULL UNIQUE
  ,make_nm               varchar(30)
  ,model_nm              varchar(30)
  ,vin                   varchar(17) NOT NULL UNIQUE
  ,electric_flg          boolean     NOT NULL DEFAULT false
  ,transmission_code     int         NOT NULL
  ,departures_cnt        int         NOT NULL DEFAULT 0 CHECK (departures_cnt >= 0)
);
CREATE TABLE IF NOT EXISTS PARTICIPANT_X_VEHICLE (
  participant_id  int REFERENCES PARTICIPANT (participant_id)
  ,vehicle_id     int REFERENCES VEHICLE (vehicle_id)
);
CREATE TABLE IF NOT EXISTS PARTNER (
  patrner_id           serial PRIMARY KEY
  ,partner_nm          varchar(50) NOT NULL
  ,specialization_code int
);
CREATE TABLE IF NOT EXISTS LOCATION (
  location_id  serial PRIMARY KEY
  ,partner_id  int REFERENCES PARTNER (patrner_id)
  ,latitude    real NOT NULL
  ,longitude   real NOT NULL
  ,address_txt varchar(50)
  ,city_nm     varchar(50)
  ,state_mn    varchar(50)
  ,type_code   int
);
CREATE TABLE IF NOT EXISTS VEHICLE_X_LOCATION (
  vehicle_id   int REFERENCES VEHICLE (vehicle_id)
  ,location_id int REFERENCES LOCATION (location_id)
);
CREATE TABLE IF NOT EXISTS RENTAL (
  rental_id         serial PRIMARY KEY
  ,participant_id   int REFERENCES PARTICIPANT (participant_id)
  ,vehicle_id       int REFERENCES VEHICLE (vehicle_id)
  ,cost_amt         real NOT NULL DEFAULT 0.0 CHECK (cost_amt >= 0.0)
  ,reservation_dttm timestamp(0)
  ,return_dttm      timestamp(0)
  ,distance_amt     real NOT NULL DEFAULT 0.0 CHECK (distance_amt >= 0.0)
  ,gasoline_amt     real NOT NULL DEFAULT 0.0 CHECK (gasoline_amt >= 0.0)
);
CREATE TABLE IF NOT EXISTS PARTICIPANT_X_RENTAL (
  participant_id  int REFERENCES PARTICIPANT (participant_id)
  ,rental_id      int REFERENCES RENTAL (rental_id)
);
CREATE TABLE IF NOT EXISTS RENTAL_X_LOCATION (
  rental_id      int REFERENCES RENTAL (rental_id)
  ,location_id   int REFERENCES LOCATION (location_id)
  ,checking_dttm timestamp(0)
);




