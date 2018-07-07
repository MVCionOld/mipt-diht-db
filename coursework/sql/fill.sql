/*
  transmission code:
  1 - manual transmission
  2 - semi-automatic transmission
  3 - automatic transmission
 */
INSERT INTO VEHICLE (registration_plate_no, make_nm, model_nm, vin, electric_flg, transmission_code, departures_cnt)
VALUES
  ('E777BA777', 'audi', 'a3', '1HGCM82633A004352', true, 1, 0)
  , ('O666OO199', 'ford', 'kuga', '1zvft80n355114299', false, 3, 0)
  , ('B999OX99', 'fiat', 'ducato', 'TRUUT28NX21004869', false, 1, 0)
  , ('B999HC99', 'citroen', 'c4', 'JHLRE48777C031579', true, 3, 0)
  , ('K989KK777', 'nissan', 'patrol', '1FTNW21F73EA50274', false, 1, 0)
  , ('M067MM777', 'honda', 'accord', '1P3XA46K8PF622638', false, 2, 0)
  , ('M068MM777', 'hyundai', 'solaris', '1P3XA46K33A004352', false, 3, 0)
  , ('K575EO799', 'lexus', 'gs', '1zvft80n33EA50274', false, 3, 0);


/*
  participant_type_code:
  1 - employee
  2 - client

  gender_code:
  1 - female
  2 - male
 */
INSERT INTO PARTICIPANT (participant_type_code, first_nm, middle_nm, last_nm, gender_code, email_txt, phone_no)
VALUES
  (1, 'Андрей', 'Михайлович', 'Райгородский', 2, 'andrey.raigor@phystech.edu', '+7(900)612-20-51')
  , (1, 'Иван', 'Генрирхович', 'Эрлих', 2, 'ivan.batya@phystech.edu', '+7(034)570-20-97')
  , (1, 'Александр', 'Фаритович', 'Халяпов', 2, 'adiabatic.macho@gmail.com', '+7(987)807-52-37')
  , (2, 'Дмитрий', 'Сергеевич', 'Родионов', 2, 'hjlbjyjd@yandex.com', '8(051)404-49-08')
  , (2, 'Михаил', 'Владиславович', 'Цион', 2, 'poor_tsion@rambler.ru', '8(437)817-11-14')
  , (2, 'Олеся', null, 'Любимова', 1, 'lyubimova.o@phystech.edu', '+7(133)787-68-63')
  , (2, 'Марк', null, 'Шехтер', 2, 'pydev@yandex.com', '+7(411)192-72-08')
  , (2, 'Илья', null, 'Гусев', 2, 'pydev@abbyy.com', '+7(270)791-63-34')
  , (2, 'Надежда', null, 'Меркурьева', 1, 'pmflector@phystech.edu', '8(080)543-33-00');


/*
  position_code:
  1 - director
  2 - lawyer
  3 - driver
 */
INSERT INTO EMPLOYEE_PARTICIPANT
VALUES
  (1, '18-2311-00', '100857', 150000.0, 1)
  , (2, '18-2311-01', '210093', 35000.0, 2)
  , (3, '18-2402-06', '3487519', 12000.0, 3);


INSERT INTO CLIENT_PARTICIPANT
VALUES
  (4, 0, 0)
  , (5, 0, 0)
  , (6, 0, 0)
  , (7, 0, 0)
  , (8, 0, 0)
  , (9, 0, 0);


INSERT INTO PARTICIPANT_X_VEHICLE
VALUES
  (2, 1)
  ,(3, 1)
  ,(2, 2)
  ,(3, 2)
  ,(2, 3)
  ,(3, 3)
  ,(2, 4)
  ,(3, 4)
  ,(2, 5)
  ,(3, 5)
  ,(2, 6)
  ,(3, 6)
  ,(2, 7)
  ,(3, 7)
  ,(2, 8)
  ,(3, 8);


/*
  specialization_code:
  0 - our company
  1 - gas station
  2 - electric station
  3 - car wash
 */
INSERT INTO PARTNER (partner_nm, specialization_code)
VALUES
  ('carsharing', 0)
  , ('lukoil', 1)
  , ('shell', 1)
  , ('electro planet', 2)
  , ('best car wash', 3)
  , ('crystal city', 3);


/*
  type_code:
  1 - gas station
  2 - electric station
  3 - car wash
  4 - garages
  5 - service station
 */
INSERT INTO LOCATION (partner_id, latitude, longitude, address_txt, city_nm, state_mn, type_code)
VALUES
  (2, 55.753960, 37.620393, 'CHkalova Ul., bld. 5, appt. 1', 'Dolgoprudny', 'Moscow', 1)
  , (2, 54.123960, 37.110352, 'Vozrozhdeniya Ul., bld. 14, appt. 225', 'Moscow', 'Moscow', 1)
  , (3, 55.753960, 37.110352, 'Lenina Pr., bld. 53, appt. 149', 'Dolgoprudny', 'Moscow', 1)
  , (3, 54.123946, 37.620393, 'Admirala Kuznetsova (Lumumby), bld. 70, appt. 32', 'Moscow', 'Moscow', 1)
  , (4, 55.753940, 36.004321, 'Pskovskaya Ul., bld. 2/К. 1, appt. 445', 'Dolgoprudny', 'Moscow', 2)
  , (4, 54.043964, 37.000393, 'Kalinina Ul., bld. 45, appt. 41', 'Moscow', 'Moscow', 2)
  , (6, 54.190023, 36.000321, 'Gospitalnaya Ul., bld. 15, appt. 107', 'Moscow', 'Moscow', 3)
  , (5, 55.444310, 36.990301, 'Mikhnovka/ Ozernaya Ul., bld. 25', 'Dolgoprudny', 'Moscow', 3)
  , (6, 54.754310, 37.320393, 'Krasnaya Pozitsiya Ul., bld. 41, appt. 52', 'Moscow', 'Moscow', 3)
  , (1, 54.000043, 37.110352, 'Severnaya Ul., bld. 26, appt. 3', 'Moscow', 'Moscow', 4)
  , (1, 55.700020, 36.000321, 'YUbileynaya Ul., bld. 50, appt. 197', 'Dolgoprudny', 'Moscow', 4)
  , (1, 54.000016, 35.620393, 'Naymushina Ul., bld. 10/А, appt. 19', 'Moscow', 'Moscow', 4)
  , (1, 55.999310, 36.661039, 'Губанова Ул., дом 18, кв. 3', 'Dolgoprudny', 'Moscow', 5)
  , (1, 55.529610, 35.998763, 'Moskovskaya Ul., bld. 10, appt. 3', 'Dolgoprudny', 'Moscow', 5);

