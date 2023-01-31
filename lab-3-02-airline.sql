DROP SCHEMA IF EXISTS airline;
CREATE SCHEMA airline;
USE airline;
-- 
CREATE TABLE customer_status (
    id INT NOT NULL AUTO_INCREMENT,
    status_name VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE aircraft (
    id INT NOT NULL AUTO_INCREMENT,
    model VARCHAR(255) NOT NULL UNIQUE,
    total_seats INT,
    PRIMARY KEY (id)
);

CREATE TABLE customer (
    id INT NOT NULL AUTO_INCREMENT,
    status_id INT NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    total_customer_mileage INT,
    PRIMARY KEY (id),
    FOREIGN KEY (status_id)
        REFERENCES customer_status (id)
);

CREATE TABLE flight (
    id INT NOT NULL AUTO_INCREMENT,
    aircraft_id INT NOT NULL,
    flight_number VARCHAR(6) NOT NULL UNIQUE,
    mileage INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (aircraft_id)
        REFERENCES aircraft (id)
);

CREATE TABLE customer_mileage (
    id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    flight_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id)
        REFERENCES customer (id),
    FOREIGN KEY (flight_id)
        REFERENCES flight (id)
);

INSERT INTO customer_status (status_name) VALUES
('None'),
('Silver'),
('Gold')
;

INSERT INTO aircraft (model, total_seats) VALUES
 ('Boeing 747', 400),
 ('Airbus A330', 236),
 ('Boeing 777', 264)
;

INSERT INTO customer (status_id, customer_name, total_customer_mileage) VALUES
(2, 'Agustine Riviera', 115235),
(1, 'Alaina Sepulvida', 6008),
(3, 'Tom Jones', 205767),
(1, 'Sam Rio', 2653),
(2, 'Jessica James', 127656),
(2, 'Ana Janco', 136773),
(3, 'Jennifer Cortez', 300582),
(2, 'Christian Janco', 14642)
;

INSERT INTO flight (aircraft_id, flight_number, mileage) VALUES
(1, 'DL143', 135),
(2, 'DL122', 4370),
(3, 'DL53', 2078),
(3, 'DL222', 1765),
(1, 'DL37', 531)
;

INSERT INTO customer_mileage (customer_id, flight_id) VALUES
(1,1),
(1,2),
(2,2),
(3,2),
(3,3),
(4,1),
(3,4),
(5,1),
(6,4),
(7,4),
(5,2),
(4,5),
(8,4)
;

-- get the total number of flights in the database.
SELECT 
    COUNT(*) AS total_flights
FROM
    flight;

-- get the average flight distance.
SELECT 
    ROUND(AVG(mileage), 2) AS average_flight_distance
FROM
    flight;

-- get the average number of seats (all flights).
SELECT 
    ROUND(AVG(a.total_seats), 2) AS avg_number_of_seats
FROM
    flight f
        INNER JOIN
    aircraft a ON f.aircraft_id = a.id;

-- get the average number of miles flown by customers grouped by status.
SELECT 
    s.status_name AS customer_status,
    ROUND(AVG(f.mileage), 2) AS miles_flown
FROM
    customer_status s,
    customer c,
    flight f,
    customer_mileage cm
WHERE
    f.id = cm.flight_id
        AND cm.customer_id = c.id
        AND c.status_id = s.id
GROUP BY s.status_name;
	
-- get the maximum number of miles flown by customers grouped by status.
SELECT 
    s.status_name AS customer_status,
    MAX(c.total_customer_mileage) AS max_miles_flown
FROM
    customer_status s,
    customer c
WHERE
    s.id = c.status_id
GROUP BY s.status_name;

-- get the total number of aircraft with a name containing Boeing (all flights).
SELECT 
    COUNT(*) AS number_of_boeing_flights
FROM
    flight f
        JOIN
    aircraft a ON f.aircraft_id = a.id
WHERE
    a.model LIKE '%boeing%';

-- get the total number of aircraft with a name containing Boeing.
SELECT 
    COUNT(*) AS number_of_boeing_model
FROM
    aircraft
WHERE
    model LIKE '%boeing%';

-- find all flights with a distance between 300 and 2000 miles.
SELECT 
    flight_number, mileage
FROM
    flight
WHERE
    mileage BETWEEN 300 AND 2000;

-- find the average flight distance booked grouped by customer status (this should require a join).
SELECT 
    s.status_name AS customer_status,
    ROUND(AVG(f.mileage), 2) AS flight_distance
FROM
    flight f
        INNER JOIN
    customer_mileage cm ON f.id = cm.flight_id
        INNER JOIN
    customer c ON c.id = cm.customer_id
        INNER JOIN
    customer_status s ON s.id = c.status_id
GROUP BY s.status_name;

-- find the most often booked aircraft by gold status members (this should require a join).
SELECT 
    MAX(a.model) AS most_often_booked_aircraft_by_gold_members
FROM
    aircraft a
        INNER JOIN
    flight f ON a.id = f.aircraft_id
        INNER JOIN
    customer_mileage cm ON cm.flight_id = f.id
        INNER JOIN
    customer c ON cm.customer_id = c.id
        INNER JOIN
    customer_status cs ON cs.id = c.status_id
WHERE
    cs.status_name = 'Gold'
        
